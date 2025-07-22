INSERT INTO categories (user_id, label, color) VALUES
($1::uuid, $2, $3)
RETURNING id, user_id, label, color, created_at, updated_at;