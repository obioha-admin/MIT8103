
CREATE TABLE notifications (
    notification_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    recipient_id BIGINT NOT NULL,
    actor_id BIGINT NOT NULL,

    notification_type VARCHAR(30) NOT NULL,

    post_id BIGINT,
    comment_id BIGINT,

    is_read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_notifications_recipient
        FOREIGN KEY (recipient_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_notifications_actor
        FOREIGN KEY (actor_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_notifications_post
        FOREIGN KEY (post_id)
        REFERENCES posts(post_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_notifications_comment
        FOREIGN KEY (comment_id)
        REFERENCES comments(comment_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_notification_type
        CHECK (
            notification_type IN (
                'post_like',
                'comment_like',
                'comment',
                'reply',
                'follow'
            )
        ),

    CONSTRAINT chk_no_self_notification
        CHECK (recipient_id <> actor_id),

    CONSTRAINT chk_notification_target
        CHECK (
            (notification_type = 'follow'
                AND post_id IS NULL
                AND comment_id IS NULL)
            OR
            (notification_type = 'post_like'
                AND post_id IS NOT NULL
                AND comment_id IS NULL)
            OR
            (notification_type IN ('comment_like', 'comment', 'reply')
                AND comment_id IS NOT NULL)
        )
);
