
CREATE TABLE comment_likes (
    user_id BIGINT NOT NULL,
    comment_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_comment_likes
        PRIMARY KEY (user_id, comment_id),

    CONSTRAINT fk_comment_likes_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_comment_likes_comment
        FOREIGN KEY (comment_id)
        REFERENCES comments(comment_id)
        ON DELETE CASCADE
);
