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
EXCEPT
*/

SELECT 
	State, Region, City FROM dbo.Employees
EXCEPT
SELECT
	State, Region, City FROM dbo.Customers;
GO

SELECT
	State, Region, City FROM dbo.Customers
EXCEPT
SELECT 
	State, Region, City FROM dbo.Employees;
GO
--------------------------------------------------------------------

-- Set Operator اولویت
SELECT
	State, Region, City FROM dbo.Suppliers
EXCEPT
SELECT
	State, Region, City FROM dbo.Employees
INTERSECT
SELECT
	State, Region, City FROM dbo.Customers;
GO
