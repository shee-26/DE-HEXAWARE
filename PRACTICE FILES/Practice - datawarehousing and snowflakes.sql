-- Customers table
CREATE TABLE reporting.Customers (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    City NVARCHAR(50),
    CreatedDate DATE
);

-- Orders table (fact table with FK)
CREATE TABLE reporting.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES reporting.Customers(CustomerID)
);

-- Insert Customers
INSERT INTO reporting.Customers (CustomerID, Name, City, CreatedDate)
VALUES
(1, 'Rahul', 'Delhi', '2024-01-10'),
(2, 'Asha', 'Mumbai', '2024-02-05'),
(3, 'Ravi', 'Delhi', '2024-03-15'),
(4, 'Sneha', 'Bangalore', '2024-04-20');

-- Insert Orders
INSERT INTO reporting.Orders (OrderID, CustomerID, OrderAmount, OrderDate)
VALUES
(101, 1, 1200.00, '2024-01-15'),
(102, 2, 8000.00, '2024-02-10'),
(103, 3, 600.00, '2024-03-12'),
(104, 1, 7000.00, '2024-04-05'),
(105, 4, 3000.00, '2024-05-20');

SELECT * FROM reporting.Customers;

SELECT * FROM reporting.Orders;


-- 1. Filter & Aggregate on Join
SELECT c.City, COUNT(*) AS OrderCount, SUM(o.OrderAmount) AS TotalAmount
FROM reporting.Customers c
JOIN reporting.Orders o ON c.CustomerID = o.CustomerID
WHERE o.OrderAmount > 1000
GROUP BY c.City;

-- 2. Cumulative Aggregations
SELECT CustomerID, OrderDate, OrderAmount,
       SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS CumulativeTotal
FROM reporting.Orders;

-- 3. OVER & PARTITION BY
SELECT CustomerID, OrderAmount,
       AVG(OrderAmount) OVER (PARTITION BY CustomerID) AS AvgPerCustomer
FROM reporting.Orders;

-- 4. Total Aggregation
SELECT CustomerID, OrderAmount,
       SUM(OrderAmount) OVER () AS GrandTotal
FROM reporting.Orders;

-- 5. Ranking
SELECT CustomerID, OrderAmount,
       ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderAmount DESC) AS RowNum
FROM reporting.Orders;

-- Data Warehouse Queries
-- 16. Fact & Dimension Tables
-- Dimension Table
CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50)
);

-- Fact Table
CREATE TABLE FactSales (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Amount DECIMAL(10,2),
    SaleDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

-- 17. Star Schema
-- FactSales connected to multiple dimensions
SELECT f.SaleID, c.Name, p.ProductName, f.Amount, d.DateKey
FROM FactSales f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
JOIN DimProduct p ON f.ProductID = p.ProductID
JOIN DimDate d ON f.SaleDate = d.Date;

-- 18. Snowflake Schema
-- Snowflake: Product dimension normalized
SELECT f.SaleID, c.Name, p.ProductName, pc.CategoryName, f.Amount
FROM FactSales f
JOIN DimCustomer c ON f.CustomerID = c.CustomerID
JOIN DimProduct p ON f.ProductID = p.ProductID
JOIN DimProductCategory pc ON p.CategoryID = pc.CategoryID;

