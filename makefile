include .env

# Inspect & generate current database schema
schema:
	atlas schema inspect --url "$(DB_URL)&search_path=$(service)" --exclude "atlas_schema_revisions"> ./internal/$(service)/infras/schema.hcl

# Generate migration
migrate:
	atlas migrate diff $(name) --dir "file://internal/$(service)/infras/postgresql/migrations" --to "file://internal/$(service)/infras/schema.hcl" --format '{{ sql . " " }}' --dev-url "$(DEV_DB_URL)"

migrate-up:
	atlas migrate apply --dir "file://internal/$(service)/infras/postgresql/migrations" --url "$(DB_URL)"
	sqlc generate

migrate-down:
	atlas migrate down --dir "file://internal/$(service)/infras/postgresql/migrations" --url "$(DB_URL)" --dev-url "$(DEV_DB_URL)"
	sqlc generate
format:
	go fmt ./...