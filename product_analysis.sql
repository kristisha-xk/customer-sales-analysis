SELECT top 10 EnglishProductName,
	SUM(SalesAmount) AS revenue,
	CAST(ROUND(SUM(SalesAmount) * 1.0 / SUM(SUM(SalesAmount)) OVER () * 100, 2) AS DECIMAL(5,2)) AS revenue_share
FROM dbo.DimProduct p
INNER JOIN dbo.FactInternetSales f ON p.ProductKey = f.ProductKey
GROUP BY EnglishProductName
ORDER BY revenue DESC