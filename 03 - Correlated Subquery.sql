/*
SQL Server 2019 دوره آموزشی کوئری‌نویسی در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebory 
*/
--------------------------------------------------------------------

USE  NikamoozDB;
GO

/*
Correlated Subquery
*/

-- نمایش جدیدترین سفارش هر مشتری
-- Query1
SELECT
	CustomerID,
	MAX(OrderID) AS NewOrder
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- Self Contained Scalar Valued با استفاده از Query1 عدم نوشتن
SELECT
	CustomerID,
	(SELECT MAX(OrderID) FROM dbo.Orders) AS NewOrder
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- Self Contained Scalar Valued با استفاده از Query1 عدم نوشتن
SELECT
	CustomerID, OrderID
FROM dbo.Orders
	WHERE OrderID = (SELECT MAX(OrderID) FROM dbo.Orders);
GO
--------------------------------------------------------------------

-- SELECT در بخش Correlated Subquery نمایش جدیدترین کدسفارش هر مشتری با استفاده از
SELECT
	DISTINCT O.CustomerID,
	(SELECT MAX(O1.OrderID) FROM dbo.Orders AS O1
		WHERE O1.CustomerID = O.CustomerID) AS NewOrder
FROM dbo.Orders AS O;
GO

SELECT
	O.CustomerID,
	(SELECT MAX(O1.OrderID) FROM dbo.Orders AS O1
		WHERE O1.CustomerID = O.CustomerID) AS NewOrder
FROM dbo.Orders AS O
GROUP BY O.CustomerID;
GO
--------------------------------------------------------------------

/*
Query1
WHERE در بخش Correlated Subquery نمایش جدیدترین کدسفارش هر مشتری با استفاده از
*/
SELECT
	O.CustomerID,
	O.OrderID
FROM dbo.Orders AS O
	WHERE O.OrderID = (SELECT MAX(O1.OrderID) FROM dbo.Orders AS O1
						WHERE O1.CustomerID = O.CustomerID);
GO

/*
Query2
Correlated Subquery روشی ساده‌تر برای نمایش جدیدترین سفارش هر مشتری بدون استفاده از
*/
SELECT
	CustomerID, 
	MAX(OrderID) AS NewOrder
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- بدون درنظر گرفتن ایندکس جداول Query2 و Query1 مقایسه میان کوئری‌های
--Query1
SELECT
	O1.CustomerID, O1.OrderID
FROM dbo.Orders AS O1
	WHERE O1.OrderID = (SELECT MAX(O2.OrderID) FROM dbo.Orders AS O2
							WHERE O1.CustomerID = O2.CustomerID);
GO

--Query2
SELECT
	CustomerID, 
	MAX(OrderID) AS NewOrder
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- با درنظر گرفتن ایندکس جداول Query2 و Query1 مقایسه میان کوئری‌های
-- Query1
SELECT
	O1.CustomerID,
	O1.OrderID
FROM Sales.Orders AS O1
	WHERE O1.OrderID = (SELECT MAX(O2.OrderID) FROM Sales.Orders AS O2
							WHERE O2.CustomerID = O1.CustomerID);
GO

-- Query2
SELECT
	CustomerID, 
	MAX(OrderID) AS NewOrder
FROM Sales.Orders
GROUP BY CustomerID;
GO
--------------------------------------------------------------------

/*
Performance علاقه‌مندان
*/

USE AdventureWorks2017;
GO

SELECT * FROM Sales.SalesOrderHeader;
GO

SELECT
	SalesPersonID,
	MAX(OrderDate) AS NewOrder
FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID;
GO

SELECT
	SalesPersonID,
	OrderDate
FROM Sales.SalesOrderHeader AS SOH1
	WHERE SOH1.SalesOrderID = (SELECT MAX(SOH2.SalesOrderID) FROM Sales.SalesOrderHeader AS SOH2 
									WHERE SOH1.SalesPersonID = SOH2.SalesPersonID);
GO
--------------------------------------------------------------------

USE NikamoozDB;
GO

/*
تمرین کلاسی

.نمایش تعداد سفارش همه شرکت‌ها حتی آن‌هایی که سفارش نداشته‌اند 

CustomerID   CompanyName    Num
----------   ------------   ---
   1         شرکت IR- AA    6
   2         شرکت IR- AB    4
   3         شرکت IR- AC    7
   ...	  			   
   89        شرکت IR- DK    14
   90        شرکت IR- DL    7
   91        شرکت IR- DM    7

(91 rows affected)

*/

-- JOIN
SELECT
	C.CustomerID,
	C.CompanyName,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID,C.CompanyName;
GO

-- Correlated Subquery
SELECT
	C.CustomerID,
	C.CompanyName,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O
		WHERE O.CustomerID = C.CustomerID)
FROM dbo.Customers AS C;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

.نمایش تاریخ جدیدترین سفارش هر شرکت حتی فاقد سفارش‌ها‌

CustomerID   CompanyName     NewOrder
----------   ------------    -----------------------
   1         شرکت IR- AA     2016-04-09 00:00:00.000
   2         شرکت IR- AB     2016-03-04 00:00:00.000
   3         شرکت IR- AC     2016-01-28 00:00:00.000
   ...		 			    
   89        شرکت IR- DK     2016-05-01 00:00:00.000
   90        شرکت IR- DL     2016-04-07 00:00:00.000
   91        شرکت IR- DM     2016-04-23 00:00:00.000

(91 rows affected)

*/

--  JOIN
SELECT
	C.CustomerID,
	C.CompanyName,
	MAX(O.OrderDate)
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID , C.CompanyName;
GO

-- SELECT در بخش Correlated Subquery با استفاده از
SELECT
	C.CustomerID,
	C.CompanyName,
	(SELECT MAX(O.OrderDate) FROM dbo.Orders AS O
		WHERE O.CustomerID = C.CustomerID) AS NewOrder
FROM dbo.Customers AS C;
GO

-- WHERE در بخش Correlated Subquery با استفاده از
SELECT
	C.CustomerID,
	C.CompanyName,
	O1.OrderDate
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O1
	ON C.CustomerID = O1.CustomerID
	WHERE O1.OrderID = (SELECT MAX(O2.OrderID) FROM dbo.Orders AS O2
							WHERE O2.CustomerID = O1.CustomerID)
	OR O1.OrderDate IS NULL;
GO