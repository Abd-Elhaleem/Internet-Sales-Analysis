# Title
Internet Sales Analysis by using (SQL / Power Bi)

# Business Request & User Stories
- The business request for this data analyst project was an executive sales report for sales managers. Based on the request that was made from the business we following user stories were defined to fulfill delivery and ensure that acceptance criteria’s were maintained throughout the project

![task](https://github.com/user-attachments/assets/3ab3e0f6-e828-4a1e-bc21-f273c25f202f)

# Data Cleaning & Transformation (SQL)

- To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following tables were extracted using SQL.

- One data source (sales budgets) were provided in Excel format and were connected in the data model in a later step of the process.

- Below are the SQL statements for cleaning and transforming necessary data.

## DIM_Calendar:

```ruby
-- Cleansed DIM_Date Table --
SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  --[DayNumberOfWeek], 
  [EnglishDayNameOfWeek] AS Day, 
  --[SpanishDayNameOfWeek], 
  --[FrenchDayNameOfWeek], 
  --[DayNumberOfMonth], 
  --[DayNumberOfYear], 
  --[WeekNumberOfYear],
  [EnglishMonthName] AS Month, 
  Left([EnglishMonthName], 3) AS MonthShort,   
 -- Useful for front end date navigation and front end graphs.
  --[SpanishMonthName], 
  --[FrenchMonthName], 
  [MonthNumberOfYear] AS MonthNo, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year --[CalendarSemester], 
  --[FiscalQuarter], 
  --[FiscalYear], 
  --[FiscalSemester] 
FROM 
 [AdventureWorksDW2019].[dbo].[DimDate]
WHERE 
  CalendarYear >= 2019
```

## DIM_Customers:

```ruby
-- Cleansed DIM_Customers Table --
SELECT 
 c.customerkey as [CustomerKey],
--      ,[GeographyKey]
--      ,[CustomerAlternateKey]
--      ,[Title]
 c.firstname as [FirstName],
--      ,[MiddleName]
 c.lastname as [LastName],
 c.firstname + ' ' + c.lastname As [Full Name],
--      ,[NameStyle]
--      ,[BirthDate]
--      ,[MaritalStatus]
--      ,[Suffix]
Case c.gender When 'M' Then 'Male' When 'F' Then 'Female' End As Gender,
--      ,[EmailAddress]
--      ,[YearlyIncome]
--      ,[TotalChildren]
--      ,[NumberChildrenAtHome]
--      ,[EnglishEducation]
--      ,[SpanishEducation]
--      ,[FrenchEducation]
--      ,[EnglishOccupation]
--      ,[SpanishOccupation]
--      ,[FrenchOccupation]
--      ,[HouseOwnerFlag]
--      ,[NumberCarsOwned]
--      ,[AddressLine1]
--      ,[AddressLine2]
--      ,[Phone]
c.datefirstpurchase AS DateFirstPurchase,
g.city AS [Customer City]
--      ,[CommuteDistance]
  FROM [AdventureWorksDW2019].[dbo].[DimCustomer] as c
  LEFT JOIN dbo.DimGeography as g ON g.GeographyKey = c.GeographyKey
  ORDER By CustomerKey ASC
```

## DIM_Products:

```ruby
-- Cleansed DIM_Products Table--
SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  --      ,[ProductSubcategoryKey]
  --      ,[WeightUnitMeasureCode]
  --      ,[SizeUnitMeasureCode]
  p.[EnglishProductName] AS [Product Name], 
  ps.EnglishProductSubcategoryName AS [Sub Category], 
  pc.EnglishProductCategoryName AS [Product Category], 
  --      ,[SpanishProductName]
  --      ,[FrenchProductName]
  --      ,[StandardCost]
  --      ,[FinishedGoodsFlag]
  p.color AS [Product Color], 
  --      ,[SafetyStockLevel]
  --      ,[ReorderPoint]
  --      ,[ListPrice]
  p.size AS [Product Size], 
  --      ,[SizeRange]
  --      ,[Weight]
  --      ,[DaysToManufacture]
  p.ProductLine AS [ProductLine], 
  --      ,[DealerPrice]
  --      ,[Class]
  --      ,[Style]
  p.modelname AS [Product Model Name], 
  --      ,[LargePhoto]
  p.[EnglishDescription] AS [Product Description], 
  --      ,[FrenchDescription]
  --      ,[ChineseDescription]
  --      ,[ArabicDescription]
  --      ,[HebrewDescription]
  --      ,[ThaiDescription]
  --      ,[GermanDescription]
  --      ,[JapaneseDescription]
  --      ,[TurkishDescription]
  --      ,[StartDate]
  --      ,[EndDate],
  ISNULL (p.Status, 'OutDate') AS [Product Status] 
FROM 
  [AdventureWorksDW2019].[dbo].[DimProduct] AS P 
  LEFT JOIN dbo.DimProductSubcategory AS ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory AS pc ON ps.ProductCategoryKey = pc.ProductCategoryKey 
ORDER By 
  p.ProductKey ASC
  ```

## FACT_InternetSales:
```ruby
--Cleanesd FACT_InternetSales Table--
SELECT 
[ProductKey],
[OrderDateKey],
[DueDateKey],
[ShipDateKey],
[CustomerKey],
--      ,[PromotionKey]
--      ,[CurrencyKey]
--      ,[SalesTerritoryKey]
[SalesOrderNumber],
--      ,[SalesOrderLineNumber]
--      ,[RevisionNumber]
--      ,[OrderQuantity]
--      ,[UnitPrice]
--      ,[ExtendedAmount]
--      ,[UnitPriceDiscountPct]
--      ,[DiscountAmount]
--      ,[ProductStandardCost]
--      ,[TotalProductCost]
[SalesAmount]
--      ,[TaxAmt]
--      ,[Freight]
--      ,[CarrierTrackingNumber]
--      ,[CustomerPONumber]
--      ,[OrderDate]
--      ,[DueDate]
--      ,[ShipDate]
  FROM [AdventureWorksDW2019].[dbo].[FactInternetSales]
  WHERE 
  LEFT (OrderDateKey, 4) >= YEAR(GETDATE()) - 2
  ORDER BY
  OrderDateKey ASC
```

# Data Model

- Below is a screenshot of the data model after cleansed and prepared tables were read into Power BI.

- This data model also shows how FACT_Budget hsa been connected to FACT_InternetSales and other necessary DIM tables.

![modeling](https://github.com/user-attachments/assets/226e2419-a40c-4ff9-833d-90007f3b0224)

# Sales Management Dashboard
- The finished sales management dashboard with one page with works as a dashboard and overview, with two other pages focused on combining tables for necessary details and visualizations to show sales over time, per customers and per products.

![report](https://github.com/user-attachments/assets/7fe0186d-f710-4b11-a290-d1b7ff1b0426)


