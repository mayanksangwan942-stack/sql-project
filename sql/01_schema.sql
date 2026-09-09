- Restaurant Food Ordering Database | MySQL 8.0+
DROP DATABASE IF EXISTS restaurant_food_ordering;
CREATE DATABASE restaurant_food_ordering CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE restaurant_food_ordering;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  email VARCHAR(120) UNIQUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE restaurant_tables (
  table_id INT AUTO_INCREMENT PRIMARY KEY,
  table_number INT NOT NULL UNIQUE,
  capacity TINYINT UNSIGNED NOT NULL,
  location_note VARCHAR(80),
  status ENUM('Available','Occupied','Reserved','Out of Service') NOT NULL DEFAULT 'Available',
  CONSTRAINT chk_table_capacity CHECK (capacity BETWEEN 1 AND 20)
) ENGINE=InnoDB;

CREATE TABLE staff (
  staff_id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  role ENUM('Manager','Chef','Waiter','Cashier','Host','Cleaner') NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  hire_date DATE NOT NULL,
  salary DECIMAL(10,2) NOT NULL,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT chk_staff_salary CHECK (salary > 0)
) ENGINE=InnoDB;

CREATE TABLE menu (
  menu_id INT AUTO_INCREMENT PRIMARY KEY,
  item_name VARCHAR(120) NOT NULL UNIQUE,
  category ENUM('Starter','Main Course','Pizza','Burger','Dessert','Beverage') NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  is_vegetarian BOOLEAN NOT NULL DEFAULT FALSE,
  is_available BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT chk_menu_price CHECK (price > 0)
) ENGINE=InnoDB;

CREATE TABLE suppliers (
  supplier_id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_name VARCHAR(120) NOT NULL UNIQUE,
  contact_name VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL UNIQUE,
  email VARCHAR(120),
  address VARCHAR(255)
) ENGINE=InnoDB;

CREATE TABLE inventory (
  inventory_id INT AUTO_INCREMENT PRIMARY KEY,
  supplier_id INT NOT NULL,
  item_name VARCHAR(120) NOT NULL UNIQUE,
  unit VARCHAR(20) NOT NULL,
  quantity_in_stock DECIMAL(10,2) NOT NULL DEFAULT 0,
  reorder_level DECIMAL(10,2) NOT NULL,
  unit_cost DECIMAL(10,2) NOT NULL,
  last_restocked DATE,
  CONSTRAINT chk_inventory_quantities CHECK (quantity_in_stock >= 0 AND reorder_level >= 0 AND unit_cost > 0),
  CONSTRAINT fk_inventory_supplier FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE reservations (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  table_id INT NOT NULL,
  reservation_time DATETIME NOT NULL,
  party_size TINYINT UNSIGNED NOT NULL,
  status ENUM('Booked','Seated','Cancelled','Completed','No Show') NOT NULL DEFAULT 'Booked',
  special_request VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_reservation_party CHECK (party_size BETWEEN 1 AND 20),
  CONSTRAINT uq_table_time UNIQUE (table_id, reservation_time),
  CONSTRAINT fk_reservation_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_reservation_table FOREIGN KEY (table_id) REFERENCES restaurant_tables(table_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  table_id INT NOT NULL,
  staff_id INT NOT NULL,
  order_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  order_type ENUM('Dine In','Takeaway') NOT NULL DEFAULT 'Dine In',
  status ENUM('New','Preparing','Served','Completed','Cancelled') NOT NULL DEFAULT 'New',
  order_total DECIMAL(12,2) NOT NULL DEFAULT 0,
  notes VARCHAR(255),
  CONSTRAINT chk_order_total CHECK (order_total >= 0),
  CONSTRAINT fk_order_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_order_table FOREIGN KEY (table_id) REFERENCES restaurant_tables(table_id)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_order_staff FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE order_details (
  order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  menu_id INT NOT NULL,
  quantity SMALLINT UNSIGNED NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  line_total DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
  CONSTRAINT uq_order_menu UNIQUE (order_id, menu_id),
  CONSTRAINT chk_order_detail_quantity CHECK (quantity > 0),
  CONSTRAINT chk_order_detail_price CHECK (unit_price > 0),
  CONSTRAINT fk_detail_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON UPDATE CASCADE ON DELETE CASCADE,
  CONSTRAINT fk_detail_menu FOREIGN KEY (menu_id) REFERENCES menu(menu_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE billing (
  bill_id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL UNIQUE,
  bill_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  subtotal DECIMAL(12,2) NOT NULL,
  tax_rate DECIMAL(5,2) NOT NULL DEFAULT 5.00,
  tax_amount DECIMAL(12,2) NOT NULL,
  discount_amount DECIMAL(12,2) NOT NULL DEFAULT 0,
  grand_total DECIMAL(12,2) NOT NULL,
  payment_status ENUM('Pending','Partially Paid','Paid','Refunded') NOT NULL DEFAULT 'Pending',
  CONSTRAINT chk_bill_amounts CHECK (subtotal >= 0 AND tax_rate >= 0 AND tax_amount >= 0 AND discount_amount >= 0 AND grand_total >= 0),
  CONSTRAINT fk_bill_order FOREIGN KEY (order_id) REFERENCES orders(order_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE payments (
  payment_id INT AUTO_INCREMENT PRIMARY KEY,
  bill_id INT NOT NULL,
  payment_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  amount DECIMAL(12,2) NOT NULL,
  payment_method ENUM('Cash','Card','UPI','Wallet') NOT NULL,
  transaction_reference VARCHAR(80) UNIQUE,
  payment_status ENUM('Successful','Pending','Failed','Refunded') NOT NULL DEFAULT 'Successful',
  CONSTRAINT chk_payment_amount CHECK (amount > 0),
  CONSTRAINT fk_payment_bill FOREIGN KEY (bill_id) REFERENCES billing(bill_id)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE INDEX idx_reservation_time ON reservations(reservation_time);
CREATE INDEX idx_orders_time_status ON orders(order_time, status);
CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_order_details_menu ON order_details(menu_id);
CREATE INDEX idx_inventory_low_stock ON inventory(quantity_in_stock, reorder_level);
CREATE INDEX idx_payments_bill_time ON payments(bill_id, payment_time);

CREATE OR REPLACE VIEW vw_order_sales_summary AS
SELECT o.order_id, o.order_time, o.status AS order_status, c.full_name AS customer_name,
       rt.table_number, s.full_name AS served_by, o.order_total,
       b.bill_id, b.grand_total, b.payment_status
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
JOIN restaurant_tables rt ON rt.table_id = o.table_id
JOIN staff s ON s.staff_id = o.staff_id
LEFT JOIN billing b ON b.order_id = o.order_id;
