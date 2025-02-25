-- name: ListUsers :many
SELECT * FROM users
ORDER BY username
LIMIT $2
OFFSET $1;

-- name: CreateUser :one
INSERT INTO users (
  username, password
) VALUES (
  $1, $2
)
RETURNING *;

-- name: GetUserByUsername :one
SELECT * FROM users
WHERE username = $1
LIMIT 1;