DECLARE @reference_date DATE = '2014-02-28';

WITH rfm_base AS (
	SELECT 
		c.CustomerKey, 
		CONCAT(c.FirstName, ' ', c.Lastname) AS name,
		MAX(d.FullDateAlternateKey) AS last_purchase_date, 
		DATEDIFF(DAY, COALESCE(MAX(d.FullDateAlternateKey), @reference_date), @reference_date) AS recency_days,
		COUNT(DISTINCT f.SalesOrderNumber) AS frequency,
		COALESCE(SUM(f.SalesAmount), 0) AS monetary
	FROM dbo.DimCustomer c
	LEFT JOIN dbo.FactInternetSales f ON c.CustomerKey = f.CustomerKey
	LEFT JOIN dbo.DimDate d ON f.DueDateKey = d.DateKey
	GROUP BY c.CustomerKey, c.FirstName, c.Lastname
),
rfm_scores AS (
SELECT *,
	CASE 
		WHEN recency_days <= 30 THEN 5
		WHEN recency_days <= 90 THEN 4
		WHEN recency_days <= 180 THEN 3
		WHEN recency_days <= 360 THEN 2
		ELSE 1
	END AS recency_score,
CASE 
		WHEN frequency >= 20 THEN 5
		WHEN frequency >= 15 THEN 4
		WHEN frequency >= 10 THEN 3
		WHEN frequency >= 5 THEN 2
		ELSE 1
	END AS frequency_score,
CASE
		WHEN monetary >= 1000 THEN 5
		WHEN monetary >= 500 THEN 4
		WHEN monetary >= 200 THEN 3
		WHEN monetary >= 50 THEN 2
		ELSE 1
	END AS monetary_score
FROM rfm_base
)

SELECT *,
CASE 
    WHEN recency_score >= 4 AND frequency_score >= 4 AND monetary_score >= 4 THEN 'VIP customers'
    WHEN recency_score >= 4 AND frequency_score >= 3 THEN 'Loyal Customers'
    WHEN recency_score >= 4 AND frequency_score <= 2 THEN 'New Customers'
    WHEN recency_score <= 2 AND frequency_score >= 4 THEN 'At Risk'
    WHEN recency_score <= 2 AND frequency_score <= 2 THEN 'Lost Customers'
    WHEN monetary_score >= 4 THEN 'Big Spenders'
    ELSE 'Average Customers'
END AS customer_segment
FROM rfm_scores
ORDER BY recency_score DESC, frequency_score DESC, monetary_score DESC;
