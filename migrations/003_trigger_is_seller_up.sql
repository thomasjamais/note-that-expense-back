CREATE OR REPLACE FUNCTION update_user_is_seller()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE users
  SET is_seller = TRUE
  WHERE id = NEW.seller_id
    AND is_seller = FALSE;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_is_seller
AFTER INSERT ON products
FOR EACH ROW
EXECUTE FUNCTION update_user_is_seller();