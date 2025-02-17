-- name: ListUsers :many
SELECT * FROM users
ORDER BY name;

-- name: CreateUser :one
INSERT INTO users (
  username, password
) VALUES (
  $1, $2
)
RETURNING *;

-- name: GetUserByUsername :one
DELETE FROM users
WHERE username = $1
LIMIT 1;