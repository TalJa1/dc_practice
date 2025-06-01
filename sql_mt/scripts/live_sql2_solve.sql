use sqlbusinessproblem;

-- Problem 1: Identify 5 Underperforming Agents
SELECT a.`AGENT_NAME`, COUNT(o.`ORD_AMOUNT`) AS `TOTAL_ORDERS`, RANK() OVER (ORDER BY COUNT(o.`ORD_AMOUNT`) ASC) AS `RANK`
FROM agents a
JOIN orders o
USING(`AGENT_CODE`)
GROUP BY a.`AGENT_NAME`
HAVING COUNT(o.`ORD_AMOUNT`) < 5
