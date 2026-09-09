# Restaurant Food Ordering Database

A GitHub-ready MySQL 8 project for restaurant operations: dining tables, customers and reservations, staff, menu and inventory, food orders, bills, and payments.

## Contents

| Path | Purpose |
|---|---|
| `sql/01_schema.sql` | Database, tables, keys, checks, indexes, and view |
| `sql/02_seed_data.sql` | 15-20 realistic sample rows for every core table |
| `sql/03_programmability.sql` | Trigger and stored procedures |
| `sql/04_examples.sql` | JOIN, GROUP BY, HAVING, subquery, view, and routine examples |
| `docs/er-diagram.md` | Entity relationship diagram and relationship notes |
| `docs/er-diagram.svg` | High-resolution ER diagram image for report or GitHub |
| `docs/normalization.md` | 3NF normalization rationale |
| `report/Restaurant_Food_Ordering_Database_Project_Report.docx` | Submission-ready project report |

## ER Diagram

![Restaurant Food Ordering Database ER Diagram](docs/er-diagram.svg)

## Requirements

- MySQL Server 8.0+
- MySQL Workbench recommended

## Run the Project

Run these files in order using MySQL Workbench:

```sql
SOURCE sql/01_schema.sql;
SOURCE sql/02_seed_data.sql;
SOURCE sql/03_programmability.sql;
SOURCE sql/04_examples.sql;
Or open and run each file in the same order.
The schema script drops and recreates the restaurant_food_ordering database. Use it only in a development environment.

Main Features
- Customer, staff, restaurant table, menu, supplier, and inventory management
- Table reservations and order handling
- Multiple food items per order using order_details
- Billing with tax, discount, and payment status
- Multiple payment methods: Cash, Card, UPI, and Wallet
- Low-stock inventory reporting
- Foreign keys, validation constraints, indexes, views, triggers, and stored procedures
- JOIN, GROUP BY, HAVING, subquery, and view examples
Database Tables
1. customers
2. restaurant_tables
3. staff
4. menu
5. suppliers
6. inventory
7. reservations
8. orders
9. order_details
10. billing
11. payments
Business Rules
1. Every order belongs to one customer, one table, and one staff member.
2. One order can contain multiple menu items.
3. A reservation has a customer, table, reservation time, party size, and status.
4. A reservation cannot duplicate the same table and time slot.
5. Every menu item has a positive price.
6. Payment amount must be positive.
7. One order can generate only one bill.
8. One bill can have one or more payments.
9. Inventory is connected to suppliers.
10. Historical order prices are stored in order_details.unit_price.
Advanced MySQL Features
View
vw_order_sales_summary shows order, customer, table, staff, bill, and payment information together.
Trigger
Order total is automatically recalculated whenever an order item is inserted, updated, or deleted.
Stored Procedures
- sp_create_bill creates a bill, applies 5 percent tax, records a payment, and completes the order.
- sp_low_stock_report shows items that have reached their reorder level.
Normalization
The project follows Third Normal Form (3NF).
- 1NF: All values are atomic and repeating order items are stored separately.
- 2NF: Order details depend on the complete order and menu-item relationship.
- 3NF: Customers, staff, menu, tables, suppliers, inventory, orders, bills, and payments are stored separately to avoid duplication.
Project Structure
restaurant-food-ordering-db/
│── README.md
│── sql/
│   ├── 01_schema.sql
│   ├── 02_seed_data.sql
│   ├── 03_programmability.sql
│   └── 04_examples.sql
│── docs/
│   ├── er-diagram.md
│   ├── er-diagram.svg
│   └── normalization.md
└── report/
    └── Restaurant_Food_Ordering_Database_Project_Report.docx
Author
Mayank Sangwan
