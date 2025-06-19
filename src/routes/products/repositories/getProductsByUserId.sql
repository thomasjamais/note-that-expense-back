SELECT 
  products.*, 
  categories.name AS category_name,
  subcategories.name AS subcategory_name
FROM products
LEFT JOIN categories ON products.category_id = categories.id
LEFT JOIN subcategories ON products.subcategory_id = subcategories.id
WHERE products.seller_id = $1
ORDER BY products.created_at DESC;