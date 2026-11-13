# ConnectSphere Database Normalisation Analysis

## 1. Introduction

ConnectSphere is a simulated social media and comment management system implemented using PostgreSQL 18. The database contains seven core tables: users, posts, comments, post_likes, comment_likes, follows, and notifications.

The relational design aims to satisfy Third Normal Form (3NF) to reduce unnecessary redundancy and maintain data integrity.

## 2. First Normal Form (1NF)

Each table has uniquely identifiable rows, and its columns contain individual values rather than repeating groups.

For example, post likes are stored as individual records in the `post_likes` table instead of keeping multiple user identifiers in a single column of the `posts` table.

## 3. Second Normal Form (2NF)

The design aims to satisfy 2NF by ensuring non-key attributes depend on complete candidate keys.

For example, the `post_likes` table uses `(user_id, post_id)` as its composite primary key. Its `created_at` attribute describes when that particular user liked that particular post, rather than depending on either identifier alone.

The `follows` and `comment_likes` tables follow a similar design.

## 4. Third Normal Form (3NF)

The design avoids storing user profile details repeatedly in related tables.

For example, `posts` references `users` through `user_id` rather than duplicating `username` and `email`.

Similarly, `comments` stores references to the relevant user and post instead of duplicating their details.

This separation helps prevent update anomalies and improves consistency.

## 5. Conclusion

The seven-table ConnectSphere schema has been designed with 3NF principles in mind. Its primary keys, foreign keys, unique constraints, and check constraints help enforce relational integrity.

A final review of functional dependencies and business rules is necessary before concluding that every relation fully satisfies 3NF.