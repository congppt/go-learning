-- Create "posts" table
CREATE TABLE "posts" (
 "id" uuid NOT NULL,
 "content" text NOT NULL,
 "user_id" uuid NOT NULL,
 "created_at" timestamptz NOT NULL DEFAULT now(),
 CONSTRAINT "pk_posts" PRIMARY KEY ("id")
);
-- Create index "ix_user_id" to table: "posts"
CREATE INDEX "ix_user_id" ON "posts" ("user_id");
