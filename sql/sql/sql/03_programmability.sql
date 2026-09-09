USE restaurant_food_ordering;

DELIMITER $$

CREATE TRIGGER trg_order_details_after_insert
AFTER INSERT ON order_details
FOR EACH ROW
BEGIN
  UPDATE orders
  SET order_total = (SELECT COALESCE(SUM(line_total), 0) FROM order_details WHERE order_id = NEW.order_id)
  WHERE order_id = NEW.order_id;
END$$

CREATE TRIGGER trg_order_details_after_update
AFTER UPDATE ON order_details
FOR EACH ROW
BEGIN
  UPDATE orders
  SET order_total = (SELECT COALESCE(SUM(line_total), 0) FROM order_details WHERE order_id = NEW.order_id)
  WHERE order_id = NEW.order_id;
END$$

CREATE TRIGGER trg_order_details_after_delete
AFTER DELETE ON order_details
FOR EACH ROW
BEGIN
  UPDATE orders
  SET order_total = (SELECT COALESCE(SUM(line_total), 0) FROM order_details WHERE order_id = OLD.order_id)
  WHERE order_id = OLD.order_id;
END$$

CREATE PROCEDURE sp_create_bill(IN p_order_id INT, IN p_payment_method VARCHAR(20))
BEGIN
  DECLARE v_subtotal DECIMAL(12,2);
  DECLARE v_tax DECIMAL(12,2);
  DECLARE v_total DECIMAL(12,2);
  DECLARE v_bill_id INT;

  IF EXISTS (SELECT 1 FROM billing WHERE order_id = p_order_id) THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'A bill already exists for this order';
  END IF;
  SELECT order_total INTO v_subtotal FROM orders WHERE order_id = p_order_id;
  IF v_subtotal IS NULL OR v_subtotal = 0 THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Order does not exist or has no items';
  END IF;
  SET v_tax = ROUND(v_subtotal * 0.05, 2);
  SET v_total = v_subtotal + v_tax;
  INSERT INTO billing(order_id, subtotal, tax_rate, tax_amount, discount_amount, grand_total, payment_status)
  VALUES(p_order_id, v_subtotal, 5, v_tax, 0, v_total, 'Paid');
  SET v_bill_id = LAST_INSERT_ID();
  INSERT INTO payments(bill_id, amount, payment_method, transaction_reference, payment_status)
  VALUES(v_bill_id, v_total, p_payment_method, CONCAT('AUTO-', p_order_id, '-', UNIX_TIMESTAMP()), 'Successful');
  UPDATE orders SET status = 'Completed' WHERE order_id = p_order_id;
END$$

CREATE PROCEDURE sp_low_stock_report()
BEGIN
  SELECT i.inventory_id, i.item_name, i.quantity_in_stock, i.reorder_level, i.unit, s.supplier_name, s.phone
  FROM inventory i JOIN suppliers s ON s.supplier_id = i.supplier_id
  WHERE i.quantity_in_stock <= i.reorder_level
  ORDER BY (i.reorder_level - i.quantity_in_stock) DESC, i.item_name;
END$$

DELIMITER ;
