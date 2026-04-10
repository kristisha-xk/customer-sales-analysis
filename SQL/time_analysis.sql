SELECT
	SUM(SalesAmount) AS revenue,
	COUNT(DISTINCT SalesOrderNumber) AS order_over_time,
	CONCAT(CalendarYear, '-', MonthNumberOfYear) AS date
FROM dbo.FactInternetSales f
INNER JOIN dbo.DimDate d ON f.DueDateKey = d.DateKey
GROUP BY CalendarYear, MonthNumberOfYear
ORDER BY CalendarYear ASC, MonthNumberOfYear ASC
