UPDATE products
SET
    title = LOWER(COALESCE($2, title)),
    description = LOWER(COALESCE($3, description)),
    price = COALESCE($4, price),
    category_id = COALESCE($5, category_id),
    subcategory_id = COALESCE($6, subcategory_id),
    stock = COALESCE($7, stock),
    actif = COALESCE($8, actif)
WHERE id = $1
RETURNING
    id,
    title,
    description,
    price,
    category_id,
    subcategory_id,
    stock,
    seller_id,
    actif,
    created_at;