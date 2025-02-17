// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.28.0
// source: query.sql

package postgresql

import (
	"context"

	"github.com/jackc/pgx/v5/pgtype"
)

const createPost = `-- name: CreatePost :one
INSERT INTO posts (
  content, user_id
) VALUES (
  $1, $2
)
RETURNING id, content, user_id, created_at
`

type CreatePostParams struct {
	Content string      `json:"content"`
	UserID  pgtype.UUID `json:"user_id"`
}

func (q *Queries) CreatePost(ctx context.Context, arg CreatePostParams) (Post, error) {
	row := q.db.QueryRow(ctx, createPost, arg.Content, arg.UserID)
	var i Post
	err := row.Scan(
		&i.ID,
		&i.Content,
		&i.UserID,
		&i.CreatedAt,
	)
	return i, err
}

const getPostByUserId = `-- name: GetPostByUserId :one
SELECT id, content, user_id, created_at FROM posts
WHERE user_id = $3
LIMIT $2
OFFSET $1
`

type GetPostByUserIdParams struct {
	Offset int32       `json:"offset"`
	Limit  int32       `json:"limit"`
	UserID pgtype.UUID `json:"user_id"`
}

func (q *Queries) GetPostByUserId(ctx context.Context, arg GetPostByUserIdParams) (Post, error) {
	row := q.db.QueryRow(ctx, getPostByUserId, arg.Offset, arg.Limit, arg.UserID)
	var i Post
	err := row.Scan(
		&i.ID,
		&i.Content,
		&i.UserID,
		&i.CreatedAt,
	)
	return i, err
}

const listPosts = `-- name: ListPosts :many
SELECT id, content, user_id, created_at FROM posts
ORDER BY id
LIMIT $2
OFFSET $1
`

type ListPostsParams struct {
	Offset int32 `json:"offset"`
	Limit  int32 `json:"limit"`
}

func (q *Queries) ListPosts(ctx context.Context, arg ListPostsParams) ([]Post, error) {
	rows, err := q.db.Query(ctx, listPosts, arg.Offset, arg.Limit)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	items := []Post{}
	for rows.Next() {
		var i Post
		if err := rows.Scan(
			&i.ID,
			&i.Content,
			&i.UserID,
			&i.CreatedAt,
		); err != nil {
			return nil, err
		}
		items = append(items, i)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return items, nil
}
