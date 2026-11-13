
ALTER TABLE comments
ADD CONSTRAINT fk_comments_parent_same_post
FOREIGN KEY (post_id, parent_comment_id)
REFERENCES comments(post_id, comment_id)
ON DELETE CASCADE;
