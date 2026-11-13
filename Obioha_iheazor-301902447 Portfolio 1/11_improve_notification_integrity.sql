
BEGIN;

ALTER TABLE notifications
DROP CONSTRAINT chk_notification_target;

ALTER TABLE notifications
ADD CONSTRAINT chk_notification_target
CHECK (
    (
        notification_type = 'follow'
        AND post_id IS NULL
        AND comment_id IS NULL
    )
    OR
    (
        notification_type = 'post_like'
        AND post_id IS NOT NULL
        AND comment_id IS NULL
    )
    OR
    (
        notification_type IN ('comment_like', 'comment', 'reply')
        AND comment_id IS NOT NULL
        AND post_id IS NULL
    )
);

COMMIT;
