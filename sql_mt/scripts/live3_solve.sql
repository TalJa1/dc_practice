-- Active: 1748774263027@@127.0.0.1@3306@bank_management
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
/*Business Scenario: The bank wants to analyze where customers are
depositing the most money via credits, and identify the top credit amount done
per city.

Task: For each city, return:
city
customer_name
max_credit_amount*/
SELECT *
FROM (
        SELECT c.city, c.cust_name, RANK() OVER (
                PARTITION BY
                    c.city
                ORDER BY MAX(t.amount) DESC
            ) AS rnk, MAX(t.amount) AS amount
        FROM
            customers c
            JOIN accounts a USING (cust_id)
            JOIN transactions t USING (account_id)
        WHERE
            t.txn_type = 'credit'
        GROUP BY
            c.city, c.cust_name, t.amount
    ) as tbl
WHERE
    tbl.rnk = 1

-- Problem 4: Average Transaction Volume vs Balance
/*Business Scenario: For better risk modeling, the bank wants to compare
average transaction amount to account balance for each account. If the
average transaction is more than 50% of the balance, the account is marked
“High Risk”, else “Low Risk”.

Task: Return:

account_id
balance
avg_txn_amount
risk_flag*/

