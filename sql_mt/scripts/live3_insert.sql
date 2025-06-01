CREATE DATABASE IF NOT EXISTS bank_management;
USE bank_management;

CREATE TABLE customers (
    cust_id INT PRIMARY KEY,
    cust_name VARCHAR(100),
    city VARCHAR(50),
    join_date DATE
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    cust_id INT,
    acc_type VARCHAR(50),
    balance DECIMAL(12,2),
    rm_id INT,
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

CREATE TABLE transactions (
    txn_id INT PRIMARY KEY,
    account_id INT,
    txn_date DATE,
    txn_type VARCHAR(10),  -- 'credit' or 'debit'
    amount DECIMAL(10,2),
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE relationship_managers (
    rm_id INT PRIMARY KEY,
    rm_name VARCHAR(100),
    region VARCHAR(50)
);


-- Customers
INSERT INTO customers VALUES
(1, 'Amit Shah', 'Delhi', '2022-01-15'),
(2, 'Priya Verma', 'Mumbai', '2023-03-22'),
(3, 'Rahul Joshi', 'Delhi', '2021-11-05'),
(4, 'Sneha Nair', 'Bangalore', '2023-07-18');

-- Relationship Managers
INSERT INTO relationship_managers VALUES
(101, 'Ravi Mehta', 'North'),
(102, 'Swati Patel', 'West'),
(103, 'Anil Rao', 'South');

-- Accounts
INSERT INTO accounts VALUES
(1001, 1, 'Savings', 15000.50, 101),
(1002, 2, 'Current', 8500.00, 102),
(1003, 3, 'Savings', 72000.00, 101),
(1004, 4, 'Savings', 9200.75, 103);

-- Transactions
INSERT INTO transactions VALUES
(5001, 1001, '2024-12-01', 'debit', 2000.00),
(5002, 1001, '2025-01-10', 'credit', 5000.00),
(5003, 1002, '2025-01-11', 'credit', 1500.00),
(5004, 1003, '2025-01-12', 'debit', 10000.00),
(5005, 1004, '2025-01-12', 'debit', 1200.00),
(5006, 1003, '2025-01-15', 'credit', 3000.00),
(5007, 1002, '2025-01-15', 'debit', 800.00);
