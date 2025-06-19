INSERT INTO products (
    title, 
    description, 
    price, 
    category_id, 
    subcategory_id, 
    stock, 
    seller_id, 
    actif
)
VALUES (LOWER($1), LOWER($2), $3, $4, $5, $6, $7, $8)
RETURNING
    id,
    title,
    description,
    price,
    category_id,
    subcategory_id,
    created_at,
    seller_id,
    actif;