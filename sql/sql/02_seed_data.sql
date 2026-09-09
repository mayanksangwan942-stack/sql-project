USE restaurant_food_ordering;

INSERT INTO customers (full_name, phone, email) VALUES
('Aarav Sharma','9000000001','aarav@example.com'),('Diya Patel','9000000002','diya@example.com'),('Kabir Singh','9000000003','kabir@example.com'),('Ananya Gupta','9000000004','ananya@example.com'),('Vivaan Verma','9000000005','vivaan@example.com'),
('Isha Khan','9000000006','isha@example.com'),('Arjun Mehta','9000000007','arjun@example.com'),('Meera Iyer','9000000008','meera@example.com'),('Rohan Das','9000000009','rohan@example.com'),('Sanya Roy','9000000010','sanya@example.com'),
('Aditya Nair','9000000011','aditya@example.com'),('Kavya Joshi','9000000012','kavya@example.com'),('Neel Kapoor','9000000013','neel@example.com'),('Tara Bose','9000000014','tara@example.com'),('Reyansh Rao','9000000015','reyansh@example.com');

INSERT INTO restaurant_tables (table_number, capacity, location_note, status) VALUES
(1,2,'Window','Available'),(2,2,'Window','Occupied'),(3,4,'Main hall','Available'),(4,4,'Main hall','Reserved'),(5,4,'Main hall','Available'),
(6,6,'Family zone','Available'),(7,6,'Family zone','Occupied'),(8,2,'Patio','Available'),(9,2,'Patio','Reserved'),(10,4,'Patio','Available'),
(11,8,'Private room','Available'),(12,8,'Private room','Available'),(13,4,'Main hall','Occupied'),(14,2,'Entrance','Available'),(15,10,'Banquet','Out of Service');

INSERT INTO staff (full_name, role, phone, hire_date, salary, is_active) VALUES
('Ritika Malhotra','Manager','9100000001','2022-02-01',55000,1),('Manoj Kumar','Chef','9100000002','2021-06-15',48000,1),('Pooja Sethi','Chef','9100000003','2023-01-10',42000,1),('Amit Shah','Waiter','9100000004','2023-05-20',24000,1),('Nisha Jain','Waiter','9100000005','2022-11-08',25000,1),
('Karan Arora','Waiter','9100000006','2024-02-16',23000,1),('Sneha Paul','Cashier','9100000007','2022-08-25',28000,1),('Rahul Dev','Host','9100000008','2023-04-04',26000,1),('Priya Menon','Cleaner','9100000009','2021-12-12',19000,1),('Vikram Gill','Chef','9100000010','2020-09-01',50000,1),
('Aisha Ali','Waiter','9100000011','2024-01-05',23000,1),('Suresh Yadav','Cleaner','9100000012','2022-03-14',19000,1),('Rhea Kapoor','Host','9100000013','2023-07-23',26000,1),('Dev Bansal','Cashier','9100000014','2024-03-01',27000,1),('Mohan Lal','Waiter','9100000015','2021-01-18',26500,0);

INSERT INTO menu (item_name, category, price, is_vegetarian, is_available) VALUES
('Tomato Soup','Starter',120,1,1),('Crispy Corn','Starter',160,1,1),('Chicken Wings','Starter',240,0,1),('Paneer Tikka','Starter',220,1,1),('Veg Biryani','Main Course',250,1,1),
('Chicken Biryani','Main Course',320,0,1),('Butter Chicken','Main Course',350,0,1),('Dal Makhani','Main Course',210,1,1),('Margherita Pizza','Pizza',300,1,1),('Farmhouse Pizza','Pizza',380,1,1),
('Classic Burger','Burger',220,0,1),('Veggie Burger','Burger',190,1,1),('Brownie Sundae','Dessert',150,1,1),('Gulab Jamun','Dessert',100,1,1),('Cold Coffee','Beverage',140,1,1),
('Lemon Iced Tea','Beverage',110,1,1),('Masala Soda','Beverage',80,1,1),('Garlic Naan','Main Course',60,1,1),('Veg Manchurian','Starter',200,1,1),('Fish Fingers','Starter',260,0,0);

INSERT INTO suppliers (supplier_name, contact_name, phone, email, address) VALUES
('Fresh Farm Produce','Ramesh Patel','9200000001','ramesh@freshfarm.test','Nashik'),('Dairy Best','Anil Rao','9200000002','anil@dairybest.test','Pune'),('Spice Route','Fatima Khan','9200000003','fatima@spiceroute.test','Mumbai'),('Grain House','Sanjay Gupta','9200000004','sanjay@grainhouse.test','Indore'),('Meat Market','Salim Sheikh','9200000005','salim@meatmarket.test','Delhi'),
('Ocean Catch','Ravi Nair','9200000006','ravi@oceancatch.test','Kochi'),('Beverage Hub','Kiran Bose','9200000007','kiran@beveragehub.test','Kolkata'),('Bake Supply','Nitin Jain','9200000008','nitin@bakesupply.test','Jaipur'),('Green Valley','Shweta Roy','9200000009','shweta@greenvalley.test','Bengaluru'),('Oil and More','Iqbal Ansari','9200000010','iqbal@oilandmore.test','Lucknow'),
('Paper Pack','Vijay Shah','9200000011','vijay@paperpack.test','Ahmedabad'),('Frozen Foods','Neha Sood','9200000012','neha@frozenfoods.test','Chandigarh'),('Fruit Basket','Aman Verma','9200000013','aman@fruitbasket.test','Nagpur'),('Kitchen Care','Reena Das','9200000014','reena@kitchencare.test','Hyderabad'),('Sauce Works','Deepak Iyer','9200000015','deepak@sauceworks.test','Chennai');

INSERT INTO inventory (supplier_id,item_name,unit,quantity_in_stock,reorder_level,unit_cost,last_restocked) VALUES
(1,'Tomato','kg',18,8,32,'2026-09-05'),(1,'Sweet Corn','kg',4,5,60,'2026-09-04'),(2,'Paneer','kg',10,4,280,'2026-09-06'),(2,'Butter','kg',6,3,450,'2026-09-05'),(3,'Garam Masala','kg',2,1,620,'2026-09-01'),
(4,'Basmati Rice','kg',25,10,110,'2026-09-07'),(5,'Chicken','kg',12,6,260,'2026-09-07'),(6,'Fish Fillet','kg',3,4,480,'2026-09-03'),(7,'Coffee Beans','kg',5,2,700,'2026-09-02'),(8,'Pizza Base','piece',16,10,30,'2026-09-06'),
(9,'Lettuce','kg',3,3,90,'2026-09-08'),(10,'Cooking Oil','litre',12,5,145,'2026-09-01'),(11,'Takeaway Box','piece',50,25,8,'2026-09-08'),(12,'French Fries','kg',8,5,170,'2026-09-05'),(13,'Ice Cream','litre',5,3,240,'2026-09-06');

INSERT INTO reservations (customer_id,table_id,reservation_time,party_size,status,special_request) VALUES
(1,1,'2026-09-10 19:00',2,'Booked','Window seat'),(2,3,'2026-09-10 19:30',4,'Booked',NULL),(3,6,'2026-09-10 20:00',5,'Booked','Birthday cake'),(4,8,'2026-09-11 18:30',2,'Booked',NULL),(5,11,'2026-09-11 20:30',7,'Booked','Quiet room'),
(6,2,'2026-09-12 19:00',2,'Booked',NULL),(7,4,'2026-09-12 19:30',4,'Booked','No onion'),(8,7,'2026-09-13 20:00',6,'Booked',NULL),(9,9,'2026-09-13 18:45',2,'Booked',NULL),(10,10,'2026-09-14 19:15',4,'Booked','Anniversary'),
(11,12,'2026-09-14 20:00',8,'Booked',NULL),(12,13,'2026-09-15 19:00',4,'Booked',NULL),(13,14,'2026-09-15 18:30',2,'Booked',NULL),(14,5,'2026-09-16 20:00',3,'Booked',NULL),(15,6,'2026-09-16 19:30',6,'Booked','High chair');

INSERT INTO orders (customer_id,table_id,staff_id,order_time,order_type,status,order_total,notes) VALUES
(1,1,4,'2026-09-01 12:10','Dine In','Completed',240,NULL),(2,2,5,'2026-09-01 13:05','Dine In','Completed',320,NULL),(3,3,6,'2026-09-02 19:15','Dine In','Completed',640,'Less spicy'),(4,4,11,'2026-09-02 20:00','Dine In','Completed',440,NULL),(5,5,4,'2026-09-03 12:30','Takeaway','Completed',250,NULL),
(6,6,5,'2026-09-03 19:10','Dine In','Completed',700,NULL),(7,7,6,'2026-09-04 20:15','Dine In','Completed',600,NULL),(8,8,11,'2026-09-04 18:35','Dine In','Completed',380,NULL),(9,9,4,'2026-09-05 13:00','Dine In','Completed',440,NULL),(10,10,5,'2026-09-05 20:10','Dine In','Completed',300,NULL),
(11,11,6,'2026-09-06 19:30','Dine In','Completed',500,NULL),(12,12,11,'2026-09-06 20:00','Dine In','Completed',700,NULL),(13,13,4,'2026-09-07 13:20','Dine In','Completed',280,NULL),(14,14,5,'2026-09-07 18:45','Takeaway','Completed',220,NULL),(15,6,6,'2026-09-08 19:40','Dine In','Completed',400,NULL),
(1,1,11,'2026-09-08 20:00','Dine In','Completed',150,NULL),(2,2,4,'2026-09-09 12:15','Dine In','Preparing',160,NULL),(3,3,5,'2026-09-09 13:10','Dine In','New',350,NULL),(4,4,6,'2026-09-09 19:00','Dine In','Served',300,NULL),(5,5,11,'2026-09-09 20:00','Takeaway','Completed',190,NULL);

INSERT INTO order_details (order_id,menu_id,quantity,unit_price) VALUES
(1,1,2,120),(2,2,2,160),(3,6,2,320),(4,4,2,220),(5,5,1,250),(6,7,2,350),(7,9,2,300),(8,10,1,380),(9,11,2,220),(10,9,1,300),
(11,5,2,250),(12,7,2,350),(13,15,2,140),(14,11,1,220),(15,19,2,200),(16,13,1,150),(17,2,1,160),(18,7,1,350),(19,9,1,300),(20,12,1,190);

INSERT INTO billing (order_id,bill_date,subtotal,tax_rate,tax_amount,discount_amount,grand_total,payment_status) VALUES
(1,'2026-09-01 12:45',240,5,12,0,252,'Paid'),(2,'2026-09-01 13:35',320,5,16,0,336,'Paid'),(3,'2026-09-02 20:00',640,5,32,20,652,'Paid'),(4,'2026-09-02 20:35',440,5,22,0,462,'Paid'),(5,'2026-09-03 12:45',250,5,12.5,0,262.5,'Paid'),
(6,'2026-09-03 20:00',700,5,35,0,735,'Paid'),(7,'2026-09-04 20:50',600,5,30,0,630,'Paid'),(8,'2026-09-04 19:10',380,5,19,0,399,'Paid'),(9,'2026-09-05 13:35',440,5,22,0,462,'Paid'),(10,'2026-09-05 20:35',300,5,15,0,315,'Paid'),
(11,'2026-09-06 20:00',500,5,25,0,525,'Paid'),(12,'2026-09-06 20:40',700,5,35,35,700,'Paid'),(13,'2026-09-07 13:40',280,5,14,0,294,'Paid'),(14,'2026-09-07 19:00',220,5,11,0,231,'Paid'),(15,'2026-09-08 20:20',400,5,20,0,420,'Paid'),
(16,'2026-09-08 20:30',150,5,7.5,0,157.5,'Paid'),(20,'2026-09-09 20:20',190,5,9.5,0,199.5,'Paid');

INSERT INTO payments (bill_id,payment_time,amount,payment_method,transaction_reference,payment_status) VALUES
(1,'2026-09-01 12:45',252,'UPI','UPI1001','Successful'),(2,'2026-09-01 13:35',336,'Card','CARD1002','Successful'),(3,'2026-09-02 20:00',652,'Cash',NULL,'Successful'),(4,'2026-09-02 20:35',462,'UPI','UPI1004','Successful'),(5,'2026-09-03 12:45',262.5,'Wallet','WAL1005','Successful'),
(6,'2026-09-03 20:00',735,'Card','CARD1006','Successful'),(7,'2026-09-04 20:50',630,'UPI','UPI1007','Successful'),(8,'2026-09-04 19:10',399,'Cash',NULL,'Successful'),(9,'2026-09-05 13:35',462,'Card','CARD1009','Successful'),(10,'2026-09-05 20:35',315,'UPI','UPI1010','Successful'),
(11,'2026-09-06 20:00',525,'Cash',NULL,'Successful'),(12,'2026-09-06 20:40',700,'Card','CARD1012','Successful'),(13,'2026-09-07 13:40',294,'UPI','UPI1013','Successful'),(14,'2026-09-07 19:00',231,'Cash',NULL,'Successful'),(15,'2026-09-08 20:20',420,'Wallet','WAL1015','Successful'),
(16,'2026-09-08 20:30',157.5,'Card','CARD1016','Successful'),(17,'2026-09-09 20:20',199.5,'UPI','UPI1017','Successful');
