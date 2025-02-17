-- Create "users" table
CREATE TABLE "users" (
 "id" uuid NOT NULL,
 "username" text NOT NULL,
 "password" bytea NOT NULL,
 "created_at" timestamptz NOT NULL DEFAULT now(),
 CONSTRAINT "pk_users" PRIMARY KEY ("id")
);
-- Create index "ix_username" to table: "users"
CREATE UNIQUE INDEX "ix_username" ON "users" ("username");
