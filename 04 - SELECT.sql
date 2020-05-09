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

-- بدون جدول SELECT
SELECT 1;
SELECT N'سحر';
SELECT 10/2;

-- Orders انتخاب تمامی ستون‌های جدول
SELECT * FROM dbo.Orders;
GO

-- Drag & Drop درج تمامی ستون‌های یک جدول با استفاده از
SELECT [OrderID], [CustomerID], [EmployeeID], [OrderDate], [ShipperID], [Freight] FROM dbo.Orders;
GO

-- Orders انتخاب ستون‌های دلخواه از جدول
SELECT
	OrderID, OrderDate, Freight
FROM dbo.Orders;
GO
--------------------------------------------------------------------
 
/* Alias
<expression> AS <alias> (Readable & Safety)
<alias> = <expression>
<expression> <alias>
*/

-- <expression> AS <alias>
SELECT
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders;
GO

-- <alias> = <expression>
SELECT
	EmployeeID, OrderYear = YEAR(OrderDate)  
FROM dbo.Orders;
GO

-- <expression> <alias>
SELECT
	EmployeeID, YEAR(OrderDate)  OrderYear
FROM dbo.Orders;
GO

-- !!!همیشه قرار نیست کوئری ها این قدر ساده باشد
SELECT 
	OrderID OrderDate
FROM dbo.Orders;
GO

-- معادل کوئری بالا
SELECT 
	OrderID AS OrderDate
FROM dbo.Orders;
GO
--------------------------------------------------------------------

-- ???
SELECT 
	OrderID, YEAR(OrderDate) AS OD
FROM dbo.Orders
	WHERE OD > 2015;
GO

-- اصلاح کوئری بالا
SELECT 
	OrderID, YEAR(OrderDate) AS OD
FROM dbo.Orders
	WHERE YEAR(OrderDate) > 2015;
GO

-- ???
SELECT 
	OrderID, YEAR(OrderDate) AS OD
FROM dbo.Orders
	WHERE OrderDate > 2015;
GO

-- اصلاح کوئری بالا
SELECT 
	OrderID, YEAR(OrderDate) AS OD
FROM dbo.Orders
	WHERE OrderDate > '2015';
GO