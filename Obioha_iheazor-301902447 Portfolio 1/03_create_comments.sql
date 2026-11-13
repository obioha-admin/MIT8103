
CREATE TABLE comments (
    comment_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    post_id BIGINT NOT NULL,
    user_id BIGINT NOT NULL,
    parent_comment_id BIGINT,
    content TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_comments_post
        FOREIGN KEY (post_id)
        REFERENCES posts(post_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_comments_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_comments_parent
        FOREIGN KEY (parent_comment_id)
        REFERENCES comments(comment_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_comment_content
        CHECK (char_length(trim(content)) > 0),

    CONSTRAINT chk_no_self_reply
        CHECK (
            parent_comment_id IS NULL
            OR parent_comment_id <> comment_id
        ),

    CONSTRAINT uq_comments_post_comment
        UNIQUE (post_id, comment_id)
);
