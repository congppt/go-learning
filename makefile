include .env

# Define paths
SCHEMA_FILE = ./internal/$(service)/infras/schema.hcl
MIGRATIONS_DIR = file://internal/$(service)/infras/postgresql/migrations

DB_URL = $(if $(findstring user,$(service)),$(USER_DB_URL),\
		 $(if $(findstring post,$(service)),$(POST_DB_URL),\
		 "UNKNOWN_SERVICE"))

# Function to check required variables
check-service:
	@if [ -z "$(service)" ]; then \
		echo "❌ ERROR: 'service' variable is not set."; \
		echo "👉 Usage: make <target> service=<your_service>"; \
		exit 1; \
	fi

check-name:
	@if [ -z "$(name)" ]; then \
		echo "❌ ERROR: 'name' variable is required for migration."; \
		echo "👉 Usage: make migrate name=<migration_name>"; \
		exit 1; \
	fi

# Inspect & generate current database schema
schema: check-service
	@echo "🔍 Inspecting database schema for service: $(service)"
	atlas schema inspect --url "$(DB_URL)" --exclude "atlas_schema_revisions" > $(SCHEMA_FILE)

# Generate migration
migrate: check-service check-name
	@echo "📦 Generating migration: $(name) for service: $(service)"
	atlas migrate diff $(name) --dir "$(MIGRATIONS_DIR)" --to "file://$(SCHEMA_FILE)" --format '{{ sql . " " }}' --dev-url "$(DEV_DB_URL)"

# Apply migrations
migrate-up: check-service
	@echo "🚀 Applying migrations for service: $(service)"
	atlas migrate apply --dir "$(MIGRATIONS_DIR)" --url "$(DB_URL)"
	sqlc generate

# Rollback migrations
migrate-down: check-service
	@echo "⏪ Rolling back migrations for service: $(service)"
	atlas migrate down --dir "$(MIGRATIONS_DIR)" --url "$(DB_URL)" --dev-url "$(DEV_DB_URL)"
	sqlc generate

# Format Go code
format:
	@echo "🖌 Formatting Go code..."
	go fmt ./...

# Run tests
test:
	@echo "🧪 Running tests..."
	go test ./...

# Run application
run:
	@echo "🚀 Running application..."
	go run ./...
