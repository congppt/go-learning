// Code generated by sqlc. DO NOT EDIT.
// versions:
//   sqlc v1.28.0

package postgresql

import (
	"github.com/jackc/pgx/v5/pgtype"
)

type Post struct {
	ID        pgtype.UUID        `json:"id"`
	Content   string             `json:"content"`
	UserID    pgtype.UUID        `json:"user_id"`
	CreatedAt pgtype.Timestamptz `json:"created_at"`
}
