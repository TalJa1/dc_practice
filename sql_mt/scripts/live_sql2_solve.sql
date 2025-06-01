-- Active: 1748482717956@@127.0.0.1@3306@sqlbusinessproblem
use sqlbusinessproblem;

-- Problem 1: Identify 5 Underperforming Agents
WITH
    AgentTotalOrders AS (
        SELECT
            a.AGENT_CODE,
            a.AGENT_NAME,
            SUM(o.ORD_AMOUNT) AS calculated_total_ord_amount
        FROM agents a
            JOIN orders o ON a.AGENT_CODE = o.AGENT_CODE
        GROUP BY
            a.AGENT_CODE,
            a.AGENT_NAME
    ),
    RankedAgents AS (
        SELECT
            AGENT_NAME,
            calculated_total_ord_amount,
            RANK() OVER (
                ORDER BY calculated_total_ord_amount ASC
            ) AS calculated_ranking
        FROM AgentTotalOrders
    )
SELECT
    AGENT_NAME AS agent_name,
    calculated_total_ord_amount AS total_ord_amount,
    calculated_ranking AS ranking
FROM RankedAgents
WHERE
    calculated_ranking <= 5
ORDER BY ranking ASC;

-- Problem 2: Most Stable Customers by Country
WITH
    RankedCustomers AS (
        SELECT c.CUST_NAME, c.CUST_COUNTRY, c.OUTSTANDING_AMT, ROW_NUMBER() OVER (
                PARTITION BY
                    c.CUST_COUNTRY
                ORDER BY c.OUTSTANDING_AMT ASC
            ) as rn
        FROM customer c
    )
SELECT rc.CUST_COUNTRY AS cust_country, rc.CUST_NAME AS cust_name
FROM RankedCustomers rc
WHERE
    rc.rn = 1;

-- Problem 3: Payment Trends with Running Totals (Wrong)
SELECT
    c.CUST_CITY AS cust_city,
    c.PAYMENT_AMT AS payment_amt,
    SUM(c.PAYMENT_AMT) OVER (
        PARTITION BY
            c.CUST_CITY
        ORDER BY c.GRADE ASC
            ROWS BETWEEN CURRENT ROW
            AND 2 FOLLOWING
    ) AS running_tot
FROM customer c

-- Problem 4: Dynamic Commission Adjustment
SELECT
    tbl.`AGENT_CODE`,
    tbl.`AGENT_NAME`,
    CASE
        WHEN tbl.avg_advance_amount < 750 THEN (0.75 * tbl.`COMMISSION`)
        WHEN tbl.avg_advance_amount BETWEEN 750 AND 1000  THEN (0.9 * tbl.`COMMISSION`)
        ELSE (1.2 * tbl.`COMMISSION`)
    END AS `Update_commision`
from (
        SELECT a.`AGENT_CODE`, a.`AGENT_NAME`, ROUND(AVG(o.`ADVANCE_AMOUNT`)) AS avg_advance_amount, a.`COMMISSION`
        FROM agents a
            JOIN orders o USING (`AGENT_CODE`)
        GROUP BY
            a.`AGENT_CODE`
    ) as tbl
ORDER BY tbl.`AGENT_CODE` ASC;