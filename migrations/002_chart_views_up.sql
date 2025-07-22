CREATE OR REPLACE VIEW category_totals_by_trip_per_user AS
SELECT
  e.user_id,
  e.trip_id,
  e.category_id,
  c.label AS category_label,
  c.color AS category_color,
  DATE(e.date) AS day,
  SUM(e.converted_amount) AS total_amount
FROM expenses e
INNER JOIN categories c ON e.category_id = c.id
GROUP BY e.user_id, e.trip_id, e.category_id, c.label, c.color, DATE(e.date);

CREATE OR REPLACE VIEW expense_category_daily_summary AS
SELECT
  e.user_id,
  e.trip_id,
  e.category_id,
  c.label AS category_label,
  c.color AS category_color,
  DATE(e.date) AS day,
  SUM(e.converted_amount) AS total
FROM expenses e
JOIN categories c ON e.category_id = c.id
GROUP BY e.user_id, e.trip_id, e.category_id, c.label, c.color, DATE(e.date)
ORDER BY day;