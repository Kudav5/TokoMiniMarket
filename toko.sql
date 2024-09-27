-- Create the database
CREATE DATABASE IF NOT EXISTS Toko_Mini_Market;
USE Toko_Mini_Market;

-- Table 1: Customers
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) UNIQUE,
    customer_phone VARCHAR(15),
    customer_address TEXT
);

-- Table 2: Employees
CREATE TABLE IF NOT EXISTS Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    employee_position VARCHAR(50),
    employee_salary DECIMAL(10, 2),
    hire_date DATE,
    employee_phone VARCHAR(15),
    employee_address TEXT
);

-- Table 3: Products
CREATE TABLE IF NOT EXISTS Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    product_description TEXT,
    product_price DECIMAL(10, 2) NOT NULL,
    product_stock INT NOT NULL,
    product_category VARCHAR(50),
    product_supplier_id INT,
    FOREIGN KEY (product_supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Table 4: Suppliers
CREATE TABLE IF NOT EXISTS Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    supplier_contact VARCHAR(100),
    supplier_phone VARCHAR(15),
    supplier_address TEXT
);

-- Table 5: Categories
CREATE TABLE IF NOT EXISTS Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Table 6: Sales
CREATE TABLE IF NOT EXISTS Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE NOT NULL,
    sale_total DECIMAL(10, 2) NOT NULL,
    customer_id INT,
    employee_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Table 7: Sale Items
CREATE TABLE IF NOT EXISTS Sale_Items (
    sale_item_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    product_id INT,
    quantity_sold INT NOT NULL,
    product_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table 8: Inventory
CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    quantity_in_stock INT NOT NULL,
    last_update DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table 9: Purchase Orders
CREATE TABLE IF NOT EXISTS Purchase_Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE NOT NULL,
    supplier_id INT,
    total_amount DECIMAL(10, 2),
    status VARCHAR(20),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Table 10: Order Items
CREATE TABLE IF NOT EXISTS Order_Items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity_ordered INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Purchase_Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table 11: Payments
CREATE TABLE IF NOT EXISTS Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    payment_date DATE NOT NULL,
    payment_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);

-- Table 12: Expenses
CREATE TABLE IF NOT EXISTS Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    expense_description TEXT,
    expense_amount DECIMAL(10, 2),
    expense_date DATE NOT NULL,
    employee_id INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Table 13: Discounts
CREATE TABLE IF NOT EXISTS Discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_description TEXT,
    discount_percentage DECIMAL(5, 2),
    start_date DATE,
    end_date DATE,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- Table 14: Product Returns
CREATE TABLE IF NOT EXISTS Product_Returns (
    return_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_item_id INT,
    return_date DATE,
    return_reason TEXT,
    FOREIGN KEY (sale_item_id) REFERENCES Sale_Items(sale_item_id)
);

-- Table 15: Promotions
CREATE TABLE IF NOT EXISTS Promotions (
    promotion_id INT AUTO_INCREMENT PRIMARY KEY,
    promotion_name VARCHAR(100),
    promotion_description TEXT,
    start_date DATE,
    end_date DATE
);

-- Table 16: User Accounts
CREATE TABLE IF NOT EXISTS User_Accounts (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20)
);

-- Table 17: Product Reviews
CREATE TABLE IF NOT EXISTS Product_Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    customer_id INT,
    review_date DATE,
    review_text TEXT,
    rating INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table 18: Employee Shifts
CREATE TABLE IF NOT EXISTS Employee_Shifts (
    shift_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    shift_start_time DATETIME,
    shift_end_time DATETIME,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Table 19: Supplier Transactions
CREATE TABLE IF NOT EXISTS Supplier_Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    transaction_date DATE,
    total_amount DECIMAL(10, 2),
    payment_method VARCHAR(20),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

-- Table 20: Store Locations
CREATE TABLE IF NOT EXISTS Store_Locations (
    store_id INT AUTO_INCREMENT PRIMARY KEY,
    store_name VARCHAR(100),
    store_address TEXT,
    store_phone VARCHAR(15)
);

-- Table 21: Inventory Logs
CREATE TABLE IF NOT EXISTS Inventory_Logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    change_quantity INT,
    change_date DATETIME,
    reason VARCHAR(100),
    employee_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Table 22: Customer Loyalty
CREATE TABLE IF NOT EXISTS Customer_Loyalty (
    loyalty_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    points INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Table 23: Delivery Orders
CREATE TABLE IF NOT EXISTS Delivery_Orders (
    delivery_id INT AUTO_INCREMENT PRIMARY KEY,
    sale_id INT,
    delivery_address TEXT,
    delivery_status VARCHAR(20),
    delivery_date DATE,
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id)
);

-- Table 24: Audit Logs
CREATE TABLE IF NOT EXISTS Audit_Logs (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100),
    action_date DATETIME,
    FOREIGN KEY (user_id) REFERENCES User_Accounts(user_id)
);

-- Table 25: Inventory Reorders
CREATE TABLE IF NOT EXISTS Inventory_Reorders (
    reorder_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    reorder_quantity INT,
    reorder_date DATE,
    supplier_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);
