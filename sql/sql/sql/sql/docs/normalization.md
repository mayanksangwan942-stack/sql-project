Normalization Notes (up to Third Normal Form)

## First Normal Form (1NF)

Every table has a primary key, each field stores one value, and repeating food items are separated from `orders` into `order_details`. A single order therefore has one row in `orders` and one row per menu item in `order_details`.

## Second Normal Form (2NF)

All non-key attributes depend on the whole key. `order_details` uses the surrogate key `order_detail_id` and enforces the business key `(order_id, menu_id)`. Quantity and unit price describe the selected order-menu combination, not just the order or just the menu.

## Third Normal Form (3NF)

Independent concepts are held in their own tables: customer details in `customers`, employee details in `staff`, table capacity in `restaurant_tables`, and supplier contact data in `suppliers`. Orders only retain their foreign keys and order-specific facts. `billing` and `payments` are separate because a bill may be settled through more than one payment.

### Intentional historical snapshots

`order_details.unit_price` and `billing` totals are retained intentionally. They preserve the price and amount charged at the time of sale, rather than creating a harmful dependency. The current menu price can change without altering past invoices.
