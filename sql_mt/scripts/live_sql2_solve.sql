-- Active: 1748774263027@@127.0.0.1@3306@sqlbusinessproblem
use sqlbusinessproblem;

-- problem 1: Identify 5 Underperforming Agents
/*Business Scenario: The company wants to optimize its operations by
identifying agents who are underperforming in terms of the total order amounts
they are handling. Specifically, they need to find the 5 agents with the lowest
total order amounts. These agents might be subject to review or potential
termination based on their performance.

Task: Write a SQL query that retrieves the names of the 5 agents with the
least total order amounts. The output should include the following columns:

agent_name: The name of the agent.

total_ord_amount: The total amount of orders handled by the agent.

ranking: The rank of the agent based on the total order amount, where 1
indicates the agent with the lowest total order amount.*/
SELECT *
FROM (
        SELECT
            a.`AGENT_NAME`, ROUND(SUM(o.`ORD_AMOUNT`)) AS `total_ord_amount`, RANK() OVER (
                ORDER BY SUM(o.`ORD_AMOUNT`) ASC
            ) AS `ranking`
        FROM agents a
            JOIN orders o USING (`AGENT_CODE`)
        GROUP BY
            a.`AGENT_NAME`
        ORDER BY `total_ord_amount` ASC
    ) as tbl
WHERE
    `ranking` <= 5

-- problem 2: Most Stable Customers by Country
/*Business Scenario: The company aims to identify the most financially stable
customers by finding those with the lowest outstanding amounts in each
country. This analysis will help the company understand which customers are
least likely to default on payments. However, it has been noted that data
provided by the agent named "Mukesh" is not reliable, so any data associated
with this agent should be excluded from the analysis.

Task: Write a SQL query that retrieves the name of the customer with the
minimum outstanding amount from each country. The output should include
the following columns:

cust_country: The country of the customer.

cust_name: The name of the customer with the minimum outstanding amount
in that country.*/
SELECT *
FROM (
        SELECT c.`CUST_NAME`, c.`CUST_COUNTRY`, c.`OUTSTANDING_AMT`, RANK() OVER (
                PARTITION BY
                    c.`CUST_COUNTRY`
                ORDER BY c.`OUTSTANDING_AMT` ASC
            ) AS `ranking`
        FROM customer c
        ORDER BY c.`CUST_COUNTRY`, `ranking`
    ) AS tbl
WHERE
    `ranking` = 1

-- problem 3: Payment Trends with Running Totals
/*Business Scenario: The company wants to analyze the payment behavior of
customers in different cities. Specifically, they are interested in understanding
how payments accumulate over time for customers within the same city.
Additionally, the company is interested in seeing how payments trend when
considering not just the current payment but also the payments from the next
two rows.

Task: Write a SQL query that calculates the running total of the payment_amt
for each cust_city, ordered by the grade in ascending order. The running total
should include the payment_amt of the current row plus the payment_amt
from the next two rows.

The output should include the following columns:

cust_city: The city of the customer.
payment_amt: The payment amount from the current row.
running_tot: The running total of payment_amt calculated by summing the
current row's payment_amt and the payment_amt of the next two rows.*/
SELECT c.`CUST_CITY`, c.`PAYMENT_AMT`, SUM(c.`PAYMENT_AMT`) OVER (
        PARTITION BY
            c.`CUST_CITY`
        ORDER BY c.`GRADE` ASC ROWS BETWEEN CURRENT ROW
            AND 2 FOLLOWING
    )
FROM customer c

-- problem 4: Dynamic Commission Adjustment
/*Business Scenario: The company wants to adjust the commission rates for
its agents based on their performance in collecting advance payments. The
adjustment is to be made according to the average amount of advance
payments each agent has collected. The goal is to incentivize agents who
collect higher advance payments by increasing their commission, while
reducing the commission for those who collect lower advance payments.

Task: Write a SQL query that calculates a new commission rate for each
agent based on the following rules:

If the average advance amount collected by an agent is less than 750: The
new commission will be 0.75 times the current commission.

If the average advance amount collected by an agent is between 750 and
1000 (inclusive): The new commission will be 0.9 times the current
commission.

If the average advance amount collected by an agent is more than 1000: The
new commission will be 1.2 times the current commission.

The output should include the following columns:

agent_code: The code of the agent.

updated_commission: The newly calculated commission based on the rules
above.*/
WITH
    Avg_Advance AS (
        SELECT a.`AGENT_CODE`, a.`COMMISSION`, ROUND(AVG(o.`ADVANCE_AMOUNT`)) as `avg_advance_amt`, a.`AGENT_NAME`
        FROM agents a
            JOIN orders o USING (`AGENT_CODE`)
        GROUP BY
            a.`AGENT_CODE`
        ORDER BY a.`AGENT_CODE`
    )
SELECT
    `AGENT_CODE`,
    `AGENT_NAME`,
    CASE
        WHEN Avg_Advance.`avg_advance_amt` < 750 THEN Avg_Advance.`COMMISSION` * 0.75
        WHEN Avg_Advance.`avg_advance_amt` BETWEEN 750 AND 1000  THEN Avg_Advance.`COMMISSION` * 0.9
        ELSE Avg_Advance.`COMMISSION` * 1.2
    END AS `updated_commission`
FROM Avg_Advance