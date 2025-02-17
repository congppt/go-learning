package events

import (
	"congppt/sample-api/internal/pkg/shared_kernel"
	"github.com/google/uuid"
)


type UserCreated struct {
	sharedkernel.DomainEvent
	UserID uuid.UUID
}

func (e UserCreated) Identity() string {
	return "UserCreated"
}
