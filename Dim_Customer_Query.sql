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