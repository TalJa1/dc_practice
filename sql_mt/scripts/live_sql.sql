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
from tbl_stg_prdcat pc
JOIN tbl_stg_prdsubcat pr
USING (`ProductCategoryKey`)
JOIN tbl_stg_prd p
USING (`ProductSubcategoryKey`)
JOIN (
    SELECT *
    FROM tbl_stg_sales_2015
    UNION
    SELECT *
    FROM tbl_stg_sales_2016
    UNION
    SELECT *
    FROM tbl_stg_sales_2017
) s
USING (`ProductKey`)
GROUP BY pc.`CategoryName`