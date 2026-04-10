SELECT 
	SUM(SalesAmount) AS revenue,
	COUNT(DISTINCT SalesOrderNumber) AS order_cnt,
	CAST(ROUND(SUM(SalesAmount) * 1.0 / COUNT(DISTINCT SalesOrderNumber), 2) AS DECIMAL(10,2)) AS aov,
	EnglishCountryRegionName
FROM dbo.FactInternetSales f
INNER JOIN dbo.DimCustomer c ON f.CustomerKey = c.CustomerKey
INNER JOIN dbo.DimGeography g ON c.GeographyKey = g.GeographyKey
GROUP BY EnglishCountryRegionName
