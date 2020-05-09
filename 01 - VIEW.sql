﻿--------------------------------------------------------------------
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

CREATE  VIEW  view_name
AS 
SELECT_statement;

*/

-- تعداد سفارشات هر شرکت
SELECT
	C.CompanyName,
	C.CustomerID,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C 
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName, C.CustomerID;
GO

-- تعداد سفارشات هر شرکت
SELECT
	C.CompanyName,
	C.City,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O 
		WHERE C.CustomerID = O.CustomerID) AS Num
FROM dbo.Customers AS C;
GO

-- تعداد سفارشات شرکت‌های تهران
SELECT
	C.CompanyName,
	C.City,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O 
		WHERE C.CustomerID = O.CustomerID) AS Num
FROM dbo.Customers AS C
	 WHERE C.City= N'تهران';
GO

-- تعداد سفارشات شرکت‌های اصفهان
SELECT
	C.CompanyName,
	C.City,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O 
		WHERE C.CustomerID = O.CustomerID) AS Num
FROM dbo.Customers AS C
	 WHERE C.City= N'اصفهان';
GO

-- VIEW بررسی وجود
DROP VIEW IF EXISTS dbo.Company_List;
GO

/*
 از تمامی سفارشات شرکت‌ها VIEW ایجاد
!!!الزامات سه‌گانه رعایت شود
*/
CREATE VIEW dbo.Company_List
AS
SELECT
	C.CompanyName,
	C.City,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O 
		WHERE C.CustomerID = O.CustomerID) AS Num
FROM dbo.Customers AS C;
GO

-- VIEW فراخوانی
SELECT * FROM dbo.Company_List;
GO

-- VIEW نمایش مشتریان تهرانی با استفاده از
SELECT * FROM dbo.Company_List AS CL
	WHERE CL.City = N'تهران';
GO

-- VIEW نمایش مشتریان اصفهانی با استفاده از
SELECT * FROM dbo.Company_List AS CL
	WHERE CL.City = N'اصفهان';
GO
--------------------------------------------------------------------

/* 
تمرین کلاسی

.ای بنویسید که شامل تعداد کل سفارشات به‌تفکیک هر سال باشدVIEW

OrderYear   Num
---------   ---
  2016      270
  2014      152
  2015      408

ساده  SELECT در یک دستور VIEW در ادامه با فراخوانی این
.تعداد سفارشات برحسب سال دلخواه مثلا 2014 را نمایش دهید
*/

DROP VIEW IF EXISTS dbo.OrderCount_Year;
GO

-- VIEW ایجاد
CREATE VIEW dbo.OrderCount_Year
AS
SELECT
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY YEAR(OrderDate);
GO

-- VIEW فراخوانی
SELECT * FROM dbo.OrderCount_Year
	WHERE OrderYear = 2014;
GO
--------------------------------------------------------------------

/*
.استفاده نکنید SELECT * از VIEW هیچ‌گاه در
*/

DROP TABLE IF EXISTS dbo.TestTbl;
GO

CREATE TABLE dbo.TestTbl
(
	ID INT
);
GO

INSERT INTO dbo.TestTbl
VALUES
	(100),
	(200),
	(300);
GO

DROP VIEW IF EXISTS dbo.All_Fields;
GO

-- VIEW ایجاد
CREATE VIEW dbo.All_Fields
AS
	SELECT * FROM dbo.TestTbl;
GO

-- All_Fields فراخوانی
SELECT * FROM dbo.All_Fields;
GO

-- TestTbl اضافه کردن فیلد جدید به جدول
ALTER TABLE dbo.TestTbl
	ADD Code INT IDENTITY;
GO

SELECT * FROM dbo.TestTbl;
GO

-- ذخیره شده است VIEW فقط اطلاعات مربوط به قبل از تغییرات جدول در متا‌دیتای
SELECT * FROM dbo.All_Fields;
GO

/*
(VIEW به‌روزرسانی) VIEW اعمال تغییرات جدول بر روی
*/
EXEC sp_refreshview 'All_Fields';
GO

EXEC sp_refreshsqlmodule 'All_Fields';
GO

SELECT * FROM dbo.All_Fields;
GO

-- VIEW تغییر ساختار
ALTER VIEW dbo.All_Fields
AS
	SELECT ID, Code FROM dbo.TestTbl;
GO

SELECT * FROM dbo.All_Fields;
GO
--------------------------------------------------------------------

--VIEW بدست آوردن اطلاعاتی درباره 
SP_HELPTEXT 'All_Fields';
GO

SELECT * FROM INFORMATION_SCHEMA.VIEWS
	WHERE TABLE_NAME = 'All_Fields';
GO

SELECT * FROM sys.sql_modules 
	WHERE object_id = object_id('All_Fields');
GO
--------------------------------------------------------------------

-- دیگر VIEW در VIEW فراخوانی یک
DROP VIEW IF EXISTS
	dbo.Employees_OrderCount, dbo.Range_Employees_OrderCount;
GO

-- .ای که از طریق آن تعداد سفارشات هر کارمند شمارش می‌شود VIEW
CREATE VIEW dbo.Employees_OrderCount
AS
	SELECT 
		EmployeeID,
		COUNT(OrderID) AS Num
	FROM dbo.Orders
	GROUP BY EmployeeID;
GO

-- Employees_OrderCount فراخوانی
SELECT * FROM dbo.Employees_OrderCount;
GO

-- دیگری فراخوانی می‌شود VIEW ای که در آن VIEW
CREATE VIEW dbo.Range_Employees_OrderCount
AS
	SELECT * FROM dbo.Employees_OrderCount
		WHERE Num > 100;
GO

SELECT * FROM dbo.Range_Employees_OrderCount;
GO