
CREATE TABLE posts (
    post_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    user_id BIGINT NOT NULL,
    content TEXT NOT NULL,
    visibility VARCHAR(20) NOT NULL DEFAULT 'public',
    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_posts_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT chk_post_content
        CHECK (char_length(trim(content)) > 0),

    CONSTRAINT chk_post_visibility
        CHECK (visibility IN ('public', 'followers', 'private'))
);
