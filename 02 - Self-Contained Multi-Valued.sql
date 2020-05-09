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
Self-Contained Multi-Valued Subquery

<scalar_expression> IN (<multivalued subquery>)
*/

-- نمایش تمامی مشتریان شهر‌های تهران و اصفهان
SELECT
	CustomerID, City
FROM dbo.Customers
	WHERE City IN (N'تهران',N'اصفهان');
GO

-- .تمامی سفارشاتی که توسط کارمندانی ثبت شده که نام‌خانوادگی آن‌ها با کاراکتر 'ت' شروع شده باشد
SELECT
	EmployeeID, OrderID
FROM dbo.Orders
	WHERE EmployeeID = (SELECT E.EmployeeID FROM dbo.Employees AS E 
							WHERE E.lastname LIKE N'ت%'); -- کارمندان: تقوی / تهرانی
GO

-- Self-Contained Multi-Valued Subquery رفع مشکل کوئری بالا با استفاده از
SELECT
	EmployeeID, OrderID
FROM dbo.Orders
	WHERE EmployeeID IN (SELECT E.EmployeeID FROM dbo.Employees AS E 
							WHERE E.lastname LIKE N'ت%'); -- کارمندان: تقوی / تهرانی
GO
--------------------------------------------------------------------

/*
لیست مشتریانی که سفارش ثبت نکرده‌اند
*/
-- LEFT JOIN با استفاده از
SELECT C.* FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
	WHERE O.OrderID IS NULL;
GO

-- Self-Contained Multi-Valued Subquery نوشتن کوئری بالا با استفاده از
SELECT
	C.*
FROM dbo.Customers AS C
	WHERE C.CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders);
GO

-- ???
SELECT * FROM dbo.Customers AS C
	WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM dbo.Orders);
GO
--------------------------------------------------------------------

/*
DISTINCT مقایسه کوئری‌های مشابه در دیتابیسی با تعداد رکورد زیاد و عدم تاثیر
*/
USE AdventureWorks2017;
GO

SELECT *
FROM [Production].[Product]
	WHERE ProductID NOT IN (SELECT DISTINCT ProductID
							FROM [Sales].[SalesOrderDetail]);
GO

SELECT *
FROM [Production].[Product]
	WHERE ProductID NOT IN (SELECT ProductID
							FROM [Sales].[SalesOrderDetail]);
GO
--------------------------------------------------------------------

USE NikamoozDB;
GO

/*
تمرین کلاسی

مشاهده مشخصات تمامی شرکت‌هایی که در
.تاریخ 2016-05-05 درخواست سفارش نداشته‌اند 

CustomerID   CompanyName
----------   ------------
   1         شرکت IR- AA
   2         شرکت IR- AB
   3         شرکت IR- AC
   ...		 
   89        شرکت IR- DK
   90        شرکت IR- DL
   91        شرکت IR- DM

(87 rows affected)

*/
SELECT
	CustomerID, CompanyName
FROM dbo.Customers
	WHERE CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders
								WHERE OrderDate = '2016-05-05' );
GO
--------------------------------------------------------------------

/*
IN با گزاره NULL رفتار
*/

-- .نمایش تمامی مشتریانی که در منطقه مرکز واقع شده‌اند
SELECT * FROM dbo.Customers
	WHERE Region IN (N'مرکز');
GO

--  .است NULL آن‌ها برابر با Region نمایش تمامی مشتریانی که مقدار فیلد 
SELECT * FROM dbo.Customers
	WHERE Region IN (NULL); -- Region = NULL
GO

/*
روش اصلاح‌شده کوئری بالا
.است NULL آن‌ها برابر با Region نمایش تمامی مشتریانی که مقدار فیلد 
*/
SELECT * FROM dbo.Customers
	WHERE Region IS NULL;
GO

-- .قرار دارند NULL مشتریانی که در منطقه مرکز یا
SELECT * FROM dbo.Customers
	WHERE Region IN (N'مرکز', NULL);
GO

/*
.معادل کوئری بالا است و هیچ تفاوتی در خروجی دیده نخواهد شد
*/
SELECT * FROM dbo.Customers
	WHERE Region IN (N'مرکز');
GO

-- اصلاح دو کوئری اخیر
SELECT * FROM dbo.Customers
	WHERE Region = N'مرکز'
	OR Region IS NULL;
GO
--------------------------------------------------------------------

/*
NOT IN با گزاره NULL رفتار
*/

-- .یا مرکز نباشد NULL آن‌ها برابر با Region نمایش تمامی مشتریانی که مقدار فیلد 
SELECT * FROM dbo.Customers
	WHERE Region NOT IN (N'مرکز',NULL)
ORDER BY Region DESC;
GO

-- روش اصلاح‌شده کوئری بالا
SELECT * FROM dbo.Customers
	WHERE Region <> N'مرکز' AND Region IS NOT NULL
ORDER BY Region DESC;
GO

-- .آن‌ها برابر با مرکز یا غرب نباشد Region نمایش تمامی مشتریانی که مقدار فیلد 
SELECT * FROM dbo.Customers
	WHERE Region NOT IN (N'مرکز',N'غرب')
ORDER BY Region DESC;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

کوئری‌ای بنویسید که فقط مشخصات شرکت‌هایی رانمایش دهد که
.سفارشات درخواست‌شده آن‌ها فرد بوده یا اصلا درخواست سفارش نداشته‌اند

CompanyName    CustomerID
------------   ----------
شرکت IR- AM       13
شرکت IR- AV       22
شرکت IR- BZ       52
شرکت IR- CE       57

(4 rows affected)

*/
SELECT
	DISTINCT CustomerID
FROM dbo.Orders
	WHERE OrderID % 2 = 0;
GO

SELECT
	CustomerID,
	CompanyName
FROM dbo.Customers
	WHERE CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders
								WHERE OrderID % 2 = 0);
GO

/*
روشی پیچیده‌تر، پرهزینه‌تر و مشابه برای نوشتن کوئری بالا
که ناشی از عدم آگاهی از نحوه اجرای کوئری بالا است
*/
SELECT
	DISTINCT C.CompanyName, C.CustomerID
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
	WHERE C.CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders 
									WHERE OrderID % 2 = 0);
GO