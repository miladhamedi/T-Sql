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
		/*		Questions 01 بررسی سوالات فایل		*/
--------------------------------------------------------------------

USE NikamoozDB;
GO


/*
Exersice 05
مشخصات شرکت‌هایی که حداقل در یکی از ماه‌های سال 2015 سفارش داشته‌اند
.اما در سال 2016 هنوز درخواست سفارشی نداشته‌اند
*/

/*
Set Operator های تنبل و استفاده از Developer رفتار
*/
SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					AND YEAR(O.OrderDate) = 2015);
GO

SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					AND YEAR(O.OrderDate) = 2016);
GO

-- EXCEPT
SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					AND YEAR(O.OrderDate) = 2015)

EXCEPT

SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					AND YEAR(O.OrderDate) = 2016);
GO

/*
Subquery (EXISTS)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					AND YEAR(O.OrderDate) = 2015)
	AND NOT EXISTS (SELECT 1 FROM dbo.Orders AS O 
					  WHERE O.CustomerID = C.CustomerID
					  AND YEAR(O.OrderDate) = 2016);
GO


/*
Subquery (IN)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CustomerID, C.CompanyName
FROM dbo.Customers AS C
	WHERE C.CustomerID IN (SELECT O.CustomerID FROM dbo.Orders AS O 
							WHERE  YEAR(O.OrderDate) = 2015)
	AND C.CustomerID NOT IN (SELECT O.CustomerID FROM dbo.Orders AS O 
							  WHERE YEAR(O.OrderDate) = 2016);
GO


/*
Subquery (SELECT)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	(SELECT DISTINCT O.CustomerID FROM dbo.Orders AS O
		WHERE O.CustomerID = C.CustomerID
		AND YEAR(O.OrderDate) = 2015
		AND O.CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders 
									WHERE YEAR(OrderDate) = 2016)) AS CustomerID,
	C.CompanyName
FROM dbo.Customers AS C;
GO


/*
Subquery (SELECT)

Outer Query: Orders
Subquery: Customers
*/
SELECT
	DISTINCT O.CustomerID,
	(SELECT C.CompanyName FROM dbo.Customers AS C
		WHERE C.CustomerID = O.CustomerID) AS CompanyName
FROM dbo.Orders AS O
	WHERE YEAR(O.OrderDate) = 2015
	AND O.CustomerID NOT IN (SELECT CustomerID FROM dbo.Orders 
								WHERE YEAR(OrderDate) = 2016);
GO