schema "user" {}
table "users" {
    schema = schema.user
    column "id" {
        type = uuid
    }
    column "username" {
        type = text
    }
    column "password" {
        type = bytea
    }
    column "created_at" {
        type = timestamptz
        default = sql("now()")
    }
    primary_key "pk_users" {
        columns = [column.id]
    }
    index "ix_username" {
        columns = [column.username]
        unique = true
    }
}

schema "post" {}
table "posts" {
    schema = schema.post
    column "id" {
        type = uuid
    }
    column "content" {
        type = text
    }
    column "user_id" {
        type = uuid
    }
    column "created_at" {
        type = timestamptz
        default = sql("now()")
    }
    primary_key "pk_posts" {
        columns = [column.id]
    }
    index "ix_user_id" {
        columns = [column.user_id]
    }
}