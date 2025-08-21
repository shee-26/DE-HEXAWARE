-- Database Basics & Schema
-- Create a Database
CREATE DATABASE SalesDB;

-- Create a Schema
CREATE SCHEMA reporting;

-- Create a Table
CREATE TABLE reporting.Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100),
    City VARCHAR(50),
    CreatedDate DATE
);

SELECT * 
FROM sys.tables
WHERE schema_id = SCHEMA_ID('reporting');


-- 2. Managing Database & Tables
-- Alter Table: Add a new column
ALTER TABLE reporting.Customers
ADD Email VARCHAR(100);

-- Drop a column
ALTER TABLE reporting.Customers
DROP COLUMN Email;

-- Delete Table
DROP TABLE reporting.Customers;

-- 3. Functions & Subtotals
INSERT INTO reporting.Customers (CustomerID, Name, City, CreatedDate)
VALUES
(1, 'Rahul', 'Delhi', '2024-01-10'),
(2, 'Asha', 'Mumbai', '2024-02-05'),
(3, 'Ravi', 'Delhi', '2024-03-15'),
(4, 'Sneha', 'Bangalore', '2024-04-20');

-- Using Aggregate Functions
SELECT City, COUNT(*) AS Total_Customers
FROM reporting.Customers
GROUP BY City;

-- Subtotals using GROUPING SETS
SELECT City, COUNT(*) AS Total_Customers
FROM reporting.Customers
GROUP BY GROUPING SETS (City, ());

-- 4. Stored Procedure
-- Stored Procedure Example
CREATE PROCEDURE GetCustomerByCity (@CityName VARCHAR(50))
AS
BEGIN
   SELECT * FROM reporting.Customers
   WHERE City = @CityName;
END;

-- Execute Stored Procedure
EXEC GetCustomerByCity 'Delhi';
