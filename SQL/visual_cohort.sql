--- Cleaning Data 

-- Total Records = 60 398
-- No records have CustomerKey = 0

WITH internet_sales AS
(
    SELECT [ProductKey]
          ,[OrderDateKey]
          ,[CustomerKey]
          ,[SalesOrderNumber]
          ,[OrderQuantity]
          ,[UnitPrice]
          ,[SalesAmount]
          ,[OrderDate]
      FROM [AdventureWorksDW2025].[dbo].[FactInternetSales]
      WHERE CustomerKey != 0 AND YEAR(OrderDate) > 2011
  ), 
  quantity_unit_price AS 
  (
  -- No records have Quantity or Unit price = 0
      SELECT ProductKey,
          CustomerKey,
          SalesOrderNumber,
          OrderQuantity,
          UnitPrice,
          OrderDate,
          OrderDateKey
      FROM internet_sales
      WHERE OrderQuantity > 0 AND UnitPrice > 0
  ), 
  -- 60 398 Clean Data
  
  --- BEGIN COHORT ANALYSIS 

  cohort AS 
  (
    SELECT 
        CustomerKey,
        MIN(OrderDate) AS first_purchase_date,
        DATEFROMPARTS(year(MIN(OrderDate)), month(MIN(OrderDate)), 1) AS cohort_date
    FROM quantity_unit_price 
    GROUP BY CustomerKey
  ), 
  cohort_retention AS 
  (
    SELECT 
        q.*,
        c.cohort_date,
        YEAR(q.OrderDate) AS purchase_year,
        MONTH(q.OrderDate) AS purchase_month,
        YEAR(c.cohort_date) AS cohort_year,
        MONTH(c.cohort_date) AS cohort_month,
        (year(q.OrderDate) - year(c.cohort_date)) * 12 
          + (month(q.OrderDate) - month(c.cohort_date)) + 1 AS cohort_index
    FROM quantity_unit_price q
    LEFT JOIN cohort c
        ON q.CustomerKey = c.CustomerKey
  )

SELECT 
    cohort_date,
    cohort_index,
    COUNT(DISTINCT CustomerKey) AS users_count
FROM cohort_retention
GROUP BY cohort_date, cohort_index
ORDER BY cohort_date, cohort_index

