WITH customers_orders AS
(SELECT 
	c.CustomerKey,
	COUNT(DISTINCT SalesOrderNumber) AS order_cnt
FROM dbo.FactInternetSales f
LEFT JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
GROUP BY c.CustomerKey)
	
SELECT 
	COUNT(*) AS customer_cnt,
	AVG(order_cnt * 1.0) AS avg_order_per_customer,
	COUNT(CASE WHEN order_cnt > 1 THEN 1 END) AS active_customer,
	COUNT(CASE WHEN order_cnt = 1 THEN 1 END) AS one_time_customer,
	COUNT(CASE WHEN order_cnt = 0 THEN 1 END) AS not_active_customer
FROM customers_orders

