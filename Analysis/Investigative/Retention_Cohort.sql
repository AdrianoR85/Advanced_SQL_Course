/*
===================================================================================
🧠 RETENTION COHORT ANALYSIS - GAME STORE CUSTOMERS
-----------------------------------------------------------------------------------
This SQL script performs a **customer retention cohort analysis**, which helps 
understand how long after their first purchase customers tend to return and 
buy again.

📌 What is a retention cohort?
A **cohort** is a group of customers who made their **first purchase** in a 
given period (in this case, all-time). A **retention cohort analysis** tracks 
these customers over time to see **how many come back** and **when**.

📊 What this query does:
1. Identifies each customer's first purchase date.
2. Tracks if and when they made additional purchases.
3. Categorizes returning customers into time buckets (7, 30, 60, and over 60 days).
4. Calculates the **retention rate** (percentage of customers who returned in each bucket).

This type of analysis is useful to:
- Understand customer loyalty and buying behavior
- Design better marketing campaigns (e.g., when to follow up after a purchase)
- Compare effectiveness of acquisition strategies over time

===================================================================================
*/

-- Step 1: Identify the first purchase date for each customer
WITH first_purchase AS (
	SELECT
		customer_id,
		MIN(purchase_date) AS first_purchase -- The earliest purchase date per customer
	FROM purchase
	GROUP BY customer_id
),

-- Step 2: Find subsequent purchases after the first one
other_purchase AS (
	SELECT
		p.customer_id,
		p.purchase_date AS date, -- The date of a repeated purchase
		fp.first_purchase,
		DATE_PART('day', p.purchase_date - fp.first_purchase) AS days_after -- Days between first and repeated purchase
	FROM purchase p
	JOIN first_purchase fp 
		ON fp.customer_id = p.customer_id 
	WHERE p.purchase_date > fp.first_purchase -- Only consider purchases after the first one
),

-- Step 3: Group customers by how many days after the first purchase they came back
retention_raw AS (
	SELECT 
		-- Define the retention period buckets
		CASE
			WHEN days_after <= 7 THEN '7_days'
			WHEN days_after <= 30 THEN '30_days'
			WHEN days_after <= 60 THEN '60_days'
			ELSE 'after_60_days'
		END AS retention_period,
		customer_id
	FROM other_purchase
	GROUP BY retention_period, customer_id -- Avoid double counting the same customer in the same period
)

-- Step 4: Calculate the retention count and rate
SELECT
	retention_period, -- Time bucket (7, 30, 60, or >60 days)
	COUNT(customer_id) AS retained_customers, -- Number of customers who returned in this period
	ROUND(
		(COUNT(customer_id) * 100.0) / 
		(SELECT COUNT(customer_id) FROM first_purchase), -- Total unique customers who made a first purchase
	2) AS retention_rate -- Percentage of customers who returned in each period
FROM retention_raw
GROUP BY retention_period
ORDER BY retention_period;
