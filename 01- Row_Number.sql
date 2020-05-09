--------------------------------------------------------------------
/*
SQL Server 2019 دوره آموزشی کوئری‌نویسی در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebory 
*/
--------------------------------------------------------------------

USE NikamoozDB;
GO

/*
ROW_NUMBER() OVER(ORDER BY Clause)
*/

SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY City) AS Row_Num
FROM dbo.Customers;
GO

SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID,
	CompanyName,
	City
FROM dbo.Customers;
GO

SELECT
	ROW_NUMBER() OVER(ORDER BY State, City DESC) AS Ranking,
	EmployeeID,
	State,
	City
FROM dbo.Employees;
GO

-- Ranking Functions عدم دسترسی به مقادیر تولید‌شده توسط
SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID,
	CompanyName,
	City
FROM dbo.Customers
	WHERE Ranking BETWEEN 10 AND 20;
GO

-- WHERE در بخش OVER عدم استفاده از
SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID,
	CompanyName,
	City
FROM dbo.Customers
	WHERE ROW_NUMBER() OVER(ORDER BY CustomerID) BETWEEN 10 AND 20;
GO

-- Derived Table با استفاده از Ranking Function رفع مشکل دسترسی به فیلدهای
SELECT * FROM
(
SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID,
	CompanyName,
	City
FROM dbo.Customers
)AS Tmp
	WHERE Tmp.Ranking BETWEEN 10 AND 20;
GO

-- CTE با استفاده از Ranking Function رفع مشکل دسترسی به فیلدهای
WITH CTE
AS
(
SELECT
	ROW_NUMBER() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID,
	CompanyName,
	City
FROM dbo.Customers
)
SELECT * FROM CTE
	WHERE CTE.Ranking BETWEEN 10 AND 20;
GO

-- Ranking اضافی در هنگام استفاده از توابع ORDER BY
SELECT
	ROW_NUMBER() OVER(ORDER BY State) AS Ranking , -- State رنکینگ براساس فیلد
	EmployeeID,
	State,
	City
FROM dbo.Employees;
GO

SELECT
	ROW_NUMBER() OVER(ORDER BY State) AS Ranking , -- State رنکینگ براساس فیلد
	EmployeeID,
	State,
	City
FROM dbo.Employees
ORDER BY City;
GO