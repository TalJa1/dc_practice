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
SELECT
FROM