
DO $$
DECLARE
    test_recipient BIGINT;
    test_actor BIGINT;
BEGIN
    INSERT INTO users (username, email, password_hash)
    VALUES ('notify_user_a', 'notify_a@example.com', 'demo_hash')
    RETURNING user_id INTO test_recipient;

    INSERT INTO users (username, email, password_hash)
    VALUES ('notify_user_b', 'notify_b@example.com', 'demo_hash')
    RETURNING user_id INTO test_actor;

    BEGIN
        INSERT INTO notifications (
            recipient_id,
            actor_id,
            notification_type
        )
        VALUES (
            test_recipient,
            test_actor,
            'invalid_type'
        );

        RAISE EXCEPTION 'TEST FAILED: Invalid notification accepted';

    EXCEPTION
        WHEN check_violation THEN
            RAISE NOTICE 'PASS: Invalid notification type rejected';
    END;

    DELETE FROM users
    WHERE user_id IN (test_recipient, test_actor);
END $$;
