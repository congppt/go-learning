include .env

# Inspect & generate current database schema
schema:
	atlas schema inspect --url "$(DB_URL)" --exclude "atlas_schema_revisions"> ./internal/pkg/db/schema.hcl

# Generate migration
migrate:
	atlas migrate diff $(name) --dir "file://internal/pkg/db/migrations" --to "file://internal/pkg/db/schema.hcl" --format '{{ sql . " " }}' --dev-url "$(DEV_DB_URL)"

migrate-up:
	atlas migrate apply --dir "file://internal/pkg/db/migrations" --url "$(DB_URL)"

migrate-down:
	atlas migrate down --dir "file://internal/pkg/db/migrations" --url "$(DB_URL)" --dev-url "$(DEV_DB_URL)"

format:
	go fmt ./...