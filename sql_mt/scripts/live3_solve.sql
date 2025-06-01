-- Active: 1748482717956@@127.0.0.1@3306@bank_management
use bank_management;

-- Problem 1:
/*Write a SQL query to return:

rm_name
total_managed_balance
ranking (where 1 = lowest)*/
WITH
    RMtotals AS (
        SELECT rm.rm_name, SUM(a.balance) AS total_managed_balance
        FROM
            relationship_managers rm
            JOIN accounts a ON rm.rm_id = a.rm_id
        GROUP BY
            rm.rm_name
    ),
    RankedRMs AS (
        SELECT
            rm_name,
            total_managed_balance,
            RANK() OVER (
                ORDER BY total_managed_balance ASC
            ) AS ranking
        FROM RMtotals
    )
SELECT
    rm_name,
    total_managed_balance,
    ranking
FROM RankedRMs
WHERE
    ranking <= 3
ORDER BY ranking ASC;

-- Problem 2:
/*Detecting Dormant Bank Accounts*/
SELECT a.account_id, c.cust_name, a.acc_type
FROM accounts a
    JOIN customers c ON a.cust_id = c.cust_id
WHERE
    NOT EXISTS (
        SELECT 1
        FROM transactions t
        WHERE
            t.account_id = a.account_id
            AND t.txn_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH) -- Check for any transaction in the last 6 months
    );

-- Problem 3: Identifying Top Credit Transactions by City
