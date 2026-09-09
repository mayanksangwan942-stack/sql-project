USE restaurant_food_ordering;

-- JOIN: complete order and bill details
SELECT * FROM vw_order_sales_summary ORDER BY order_time DESC;

-- JOIN: each food item sold with its order and customer
SELECT o.order_id, c.full_name, m.item_name, od.quantity, od.unit_price, od.line_total
FROM orders o JOIN customers c ON c.customer_id = o.customer_id
JOIN order_details od ON od.order_id = o.order_id
JOIN menu m ON m.menu_id = od.menu_id
ORDER BY o.order_id, od.order_detail_id;

-- GROUP BY: sales by menu category
SELECT m.category, SUM(od.quantity) AS units_sold, ROUND(SUM(od.line_total),2) AS sales
FROM order_details od JOIN menu m ON m.menu_id = od.menu_id
GROUP BY m.category ORDER BY sales DESC;

-- HAVING: customers whose completed-order spending exceeds 500
SELECT c.customer_id, c.full_name, COUNT(o.order_id) AS orders_placed, SUM(o.order_total) AS total_spent
FROM customers c JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.order_total) > 500
ORDER BY total_spent DESC;

-- Subquery: menu items priced above the menu average
SELECT menu_id, item_name, category, price
FROM menu
WHERE price > (SELECT AVG(price) FROM menu)
ORDER BY price DESC;

-- Correlated subquery: customers with more than one order
SELECT c.customer_id, c.full_name
FROM customers c
WHERE (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) > 1;

-- View: daily revenue from paid bills
CREATE OR REPLACE VIEW vw_daily_revenue AS
SELECT DATE(bill_date) AS sales_date, COUNT(*) AS bills_issued, SUM(grand_total) AS revenue
FROM billing WHERE payment_status = 'Paid'
GROUP BY DATE(bill_date);
SELECT * FROM vw_daily_revenue ORDER BY sales_date;

-- Index-useful low stock search
SELECT item_name, quantity_in_stock, reorder_level, unit
FROM inventory WHERE quantity_in_stock <= reorder_level ORDER BY item_name;

-- Stored procedure calls
CALL sp_low_stock_report();
-- Call this only for an unbilled non-empty order, e.g. after adding details to order 17:
-- CALL sp_create_bill(17, 'UPI');
