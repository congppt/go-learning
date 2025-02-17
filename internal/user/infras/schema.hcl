schema "user" {}
table "users"{
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