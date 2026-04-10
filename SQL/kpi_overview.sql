WITH base AS(
SELECT * 
FROM dbo.FactInternetSales
WHERE SalesAmount > 0)

SELECT SUM(SalesAmount) AS revenue,
	COUNT(DISTINCT SalesOrderNumber) AS order_cnt,
	SUM(OrderQuantity) AS quantity_cnt,
	SUM(SalesAmount) / COUNT(DISTINCT SalesOrderNumber) AS aov,
	SUM(OrderQuantity) / COUNT(DISTINCT SalesOrderNumber) AS avg_quan_per_order
FROM base
