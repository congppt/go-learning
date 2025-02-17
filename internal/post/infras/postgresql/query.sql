-- name: ListPosts :many
SELECT * FROM posts
ORDER BY id
LIMIT $2
OFFSET $1;

-- name: CreatePost :one
INSERT INTO posts (
  content, user_id
) VALUES (
  $1, $2
)
RETURNING *;

-- name: GetPostByUserId :one
SELECT * FROM posts
WHERE user_id = $3
LIMIT $2
OFFSET $1;