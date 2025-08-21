-- 5. Subqueries & Inline Queries
-- Create a Database
CREATE DATABASE SaleDB;

-- Create a Schema
CREATE SCHEMA reporting;

-- Create table
CREATE TABLE reporting.Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES reporting.Customers(CustomerID)
);

-- Insert values to the table
INSERT INTO reporting.Customers (CustomerID, Name, City, CreatedDate)
VALUES
(1, 'Rahul', 'Delhi', '2024-01-10'),
(2, 'Asha', 'Mumbai', '2024-02-05'),
(3, 'Ravi', 'Delhi', '2024-03-15'),
(4, 'Sneha', 'Bangalore', '2024-04-20');

-- Subquery in WHERE clause
SELECT Name, City
FROM reporting.Customers
WHERE CustomerID IN (
    SELECT CustomerID
    FROM reporting.Orders
    WHERE OrderAmount > 5000
);

-- Inline View (subquery in FROM)
SELECT City, AVG(OrderAmount) AS AvgOrder
FROM (
    SELECT o.CustomerID, c.City, o.OrderAmount
    FROM reporting.Orders o
    JOIN reporting.Customers c ON o.CustomerID = c.CustomerID
) sub
GROUP BY City;

-- 6. Data Cleansing & Manipulation
-- Remove duplicates
DELETE FROM reporting.Customers
WHERE CustomerID NOT IN (
    SELECT MIN(CustomerID)
    FROM reporting.Customers
    GROUP BY Name, City
);

-- Update null values
UPDATE reporting.Customers
SET City = 'Unknown'
WHERE City IS NULL;

-- 7. Regex
-- Extract digits from a string
SELECT Name, REGEXP_SUBSTR(Name, '[0-9]+') AS Extracted_Number
FROM reporting.Customers;

-- Filter names starting with 'A'
SELECT * FROM reporting.Customers
WHERE Name REGEXP '^A';

-- 8. Aggregate Functions
SELECT City, 
       COUNT(*) AS TotalCustomers, 
       AVG(OrderAmount) AS AvgPurchase
FROM reporting.Customers c
JOIN reporting.Orders o ON c.CustomerID = o.CustomerID
GROUP BY City;

-- 9. Analytical Functions
-- Running total
SELECT CustomerID, OrderID, OrderAmount,
       SUM(OrderAmount) OVER (PARTITION BY CustomerID ORDER BY OrderDate) AS RunningTotal
FROM reporting.Orders;

-- 10. Ranking Functions
-- Rank customers based on purchase amount
SELECT CustomerID, OrderAmount,
       RANK() OVER (ORDER BY OrderAmount DESC) AS RankNo
FROM reporting.Orders;

-- 11. CTE (Common Table Expression)
WITH HighValueOrders AS (
   SELECT CustomerID, OrderAmount
   FROM reporting.Orders
   WHERE OrderAmount > 5000
)
SELECT * FROM HighValueOrders;

-- 12. Group By Extensions
-- ROLLUP: Hierarchical subtotal
SELECT City, SUM(OrderAmount) AS TotalAmount
FROM reporting.Orders o
JOIN reporting.Customers c ON o.CustomerID = c.CustomerID
GROUP BY ROLLUP (City);

-- CUBE: All combinations
SELECT City, CreatedDate, SUM(OrderAmount)
FROM reporting.Orders o
JOIN reporting.Customers c ON o.CustomerID = c.CustomerID
GROUP BY CUBE (City, CreatedDate);

-- 13. Hierarchical Queries
-- Organization hierarchy
SELECT EmployeeID, ManagerID, LEVEL
FROM Employees
CONNECT BY PRIOR EmployeeID = ManagerID
START WITH ManagerID IS NULL;

-- 14. Correlated Subqueries
-- Customers with order count > 2
SELECT c.CustomerID, c.Name
FROM reporting.Customers c
WHERE (SELECT COUNT(*) FROM reporting.Orders o 
       WHERE o.CustomerID = c.CustomerID) > 2;

-- 15. Materialized Views
-- Create Materialized View
CREATE MATERIALIZED VIEW mv_CustomerSales
AS
SELECT c.CustomerID, c.Name, SUM(o.OrderAmount) AS TotalSales
FROM reporting.Customers c
JOIN reporting.Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;





