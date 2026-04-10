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
      WHERE CustomerKey != 0
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
  ), 
  cohort_pivot AS 
  (

--- Pivot Data to see the cohort table
SELECT *
FROM (
    SELECT DISTINCT 
        CustomerKey,
        cohort_date,
        cohort_index
    FROM cohort_retention
) tbl
pivot(
    COUNT(CustomerKey)
    for cohort_index In
        ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12], [13], [14], [15], [16], [17], [18], [19],
        [20], [21], [22], [23], [24], [25], [26], [27], [28], [29], [30], [31], [32], [33], [34], [35], [36], [37])
) AS pivot_table
)

SELECT 
    cohort_pivot.*,
    1.0 * [1]/[1] * 100 as [1], 
    1.0 * [2]/[1] * 100 as [2],
    1.0 * [3]/[1] * 100 as [3],
    1.0 * [4]/[1] * 100 as [4],
    1.0 * [5]/[1] * 100 as [5],
    1.0 * [6]/[1] * 100 as [6],
    1.0 * [7]/[1] * 100 as [7],
    1.0 * [8]/[1] * 100 as [8],
    1.0 * [9]/[1] * 100 as [9],
    1.0 * [10]/[1] * 100 as [10],
    1.0 * [11]/[1] * 100 as [11],
    1.0 * [12]/[1] * 100 as [12],
    1.0 * [13]/[1] * 100 as [13],
    1.0 * [14]/[1] * 100 as [14],
    1.0 * [15]/[1] * 100 as [15],
    1.0 * [16]/[1] * 100 as [16],
    1.0 * [17]/[1] * 100 as [17],
    1.0 * [18]/[1] * 100 as [18],
    1.0 * [19]/[1] * 100 as [19],
    1.0 * [20]/[1] * 100 as [20],
    1.0 * [21]/[1] * 100 as [21],
    1.0 * [22]/[1] * 100 as [22],
    1.0 * [23]/[1] * 100 as [23],
    1.0 * [24]/[1] * 100 as [24],
    1.0 * [25]/[1] * 100 as [25],
    1.0 * [26]/[1] * 100 as [26],
    1.0 * [27]/[1] * 100 as [27],
    1.0 * [28]/[1] * 100 as [28],
    1.0 * [29]/[1] * 100 as [29],
    1.0 * [30]/[1] * 100 as [30],
    1.0 * [31]/[1] * 100 as [31],
    1.0 * [32]/[1] * 100 as [32],
    1.0 * [33]/[1] * 100 as [33],
    1.0 * [34]/[1] * 100 as [34],
    1.0 * [35]/[1] * 100 as [35],
    1.0 * [36]/[1] * 100 as [36],
    1.0 * [37]/[1] * 100 as [37]
FROM cohort_pivot 
ORDER BY cohort_date

