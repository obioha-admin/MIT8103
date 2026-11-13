
BEGIN;

INSERT INTO users (username, email, password_hash, full_name)
VALUES (
    'amina_dev',
    'amina@example.com',
    'demo_hash_not_real_password',
    'Amina Yusuf'
);

INSERT INTO posts (user_id, content)
SELECT user_id, 'Learning advanced database systems!'
FROM users
WHERE username = 'amina_dev';

INSERT INTO comments (post_id, user_id, content)
SELECT p.post_id, u.user_id, 'This is my first comment!'
FROM posts p
JOIN users u ON p.user_id = u.user_id
WHERE u.username = 'amina_dev'
  AND p.content = 'Learning advanced database systems!';

SELECT
    u.username,
    p.content AS post,
    c.content AS comment
FROM comments c
JOIN posts p ON c.post_id = p.post_id
JOIN users u ON c.user_id = u.user_id
WHERE u.username = 'amina_dev';

ROLLBACK;
