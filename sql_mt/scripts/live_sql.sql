CREATE DATABASE IF NOT EXISTS test_db;

USE test_db;

-- Total profit by MaritialStatus and Gender
SELECT c.Gender, c.MaritalStatus, SUM(
        (
            p.ProductPrice - p.ProductCost
        ) * s.OrderQuantity
    ) AS TotalProfit
FROM
    tbl_stg_customers c
    JOIN (
        SELECT *
        from tbl_stg_sales_2015
        UNION
        SELECT *
        FROM tbl_stg_sales_2016
        UNION
        SELECT *
        FROM tbl_stg_sales_2017
    ) s ON c.CustomerKey = s.CustomerKey
    JOIN tbl_stg_prd p ON s.ProductKey = p.ProductKey
GROUP BY
    c.Gender,
    c.MaritalStatus
ORDER BY c.Gender, c.MaritalStatus;

-- Total profit by Category
SELECT pc.`CategoryName`, SUM(
        (
            p.ProductPrice - p.ProductCost
        ) * s.OrderQuantity
    ) AS TotalProfit
from
    tbl_stg_prdcat pc
    JOIN tbl_stg_prdsubcat pr USING (`ProductCategoryKey`)
    JOIN tbl_stg_prd p USING (`ProductSubcategoryKey`)
    JOIN (
        SELECT *
        FROM tbl_stg_sales_2015
        UNION
        SELECT *
        FROM tbl_stg_sales_2016
        UNION
        SELECT *
        FROM tbl_stg_sales_2017
    ) s USING (`ProductKey`)
GROUP BY
    pc.`CategoryName`

-- How many customers are there for each MaritalStatus and Gender combination? List MaritalStatus, Gender, and the count of customers
SELECT c.`MaritalStatus`, c.`Gender`, COUNT(*)
FROM tbl_stg_customers c
GROUP BY
    c.`MaritalStatus`,
    c.`Gender`

-- What is the total OrderQuantity sold for each product? List the ProductName and the sum of OrderQuantity.
-- Order the results by total quantity sold in descending order
CREATE View sales AS
SELECT *
FROM tbl_stg_sales_2015
UNION ALL
SELECT *
FROM tbl_stg_sales_2016
UNION ALL
SELECT *
FROM tbl_stg_sales_2017;

SELECT p.`ProductName`, SUM(s.`OrderQuantity`) AS TotalOrderQuantity
FROM tbl_stg_prd p
    JOIN sales s USING (`ProductKey`)
GROUP BY
    p.`ProductName`
ORDER BY TotalOrderQuantity DESC;

-- Calculate the total profit generated from all sales across all products
SELECT p.`ProductName`, SUM(
        (
            p.`ProductPrice` - p.`ProductCost`
        ) * s.`OrderQuantity`
    ) AS TotalProfit
FROM tbl_stg_prd p
    JOIN sales s USING (`ProductKey`)
GROUP BY
    p.`ProductName`
ORDER BY TotalProfit DESC;

-- What is the total profit generated from customers, grouped by their MaritalStatus and Gender?
SELECT c.`MaritalStatus`, c.`Gender`, SUM(
        (
            p.`ProductPrice` - p.`ProductCost`
        ) * s.`OrderQuantity`
    ) AS TotalProfit
FROM
    tbl_stg_customers c
    JOIN sales s USING (`CustomerKey`)
    JOIN tbl_stg_prd p USING (`ProductKey`)
GROUP BY
    c.`MaritalStatus`, 
    c.`Gender`
ORDER BY TotalProfit DESC;

-- List all product CategoryNames and the total number of distinct products within each category.
SELECT p.`ProductName`, pc.`CategoryName`, COUNT(DISTINCT p.`ProductKey`) AS DistinctProductCount
FROM tbl_stg_prd p
JOIN tbl_stg_prdsubcat pr
USING (`ProductSubcategoryKey`)
JOIN tbl_stg_prdcat pc
USING (`ProductCategoryKey`)
GROUP BY p.`ProductName`, pc.`CategoryName`
ORDER BY pc.`CategoryName`, p.`ProductName`;

-- What is the average AnnualIncome of customers who have purchased products belonging to the 'Bikes' CategoryName?
SELECT AVG(c.`AnnualIncome`) as `AnnualIncome`, CONCAT(c.`FirstName`, ' ', c.`LastName`) AS CustomerName
FROM tbl_stg_prdsubcat pr
JOIN tbl_stg_prdcat pc USING (`ProductCategoryKey`)
JOIN tbl_stg_prd p USING (`ProductSubcategoryKey`)
JOIN sales s USING (`ProductKey`)
JOIN tbl_stg_customers c USING (`CustomerKey`)
WHERE pc.`CategoryName` = 'Bikes'
GROUP BY pc.`CategoryName`, c.`AnnualIncome`, CustomerName

-- Which sales Country (from tbl_stg_territory) has the highest total OrderQuantity? Show the country and its total quantity.
SELECT te.`Country`, SUM(s.`OrderQuantity`) as "Total Order Quantity"
FROM tbl_stg_territory te
JOIN sales s ON te.`SalesTerritoryKey` = s.`TerritoryKey`
GROUP BY te.`Country`
ORDER BY SUM(s.`OrderQuantity`) DESC