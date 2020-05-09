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
	/*		Questions 01 روش‌های مختلف حل تمرین 1 از فایل		*/
--------------------------------------------------------------------

USE NikamoozDB;
GO

/*
Exersice 01
.فهرست شرکت‌هایی که بیش از 10 سفارش درخواست داشته‌اند
*/

/*
روش اول
JOIN
*/
SELECT
	C.CompanyName, C.CustomerID
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON O.CustomerID = C.CustomerID
GROUP BY C.CompanyName, C.CustomerID
	HAVING COUNT(O.OrderID) > 10;
GO

/*
روش دوم
Subquery (WHERE)

Outer Query: Customers
Sub Query: Orders
*/
SELECT
	C.CompanyName, C.CustomerID 
FROM dbo.Customers AS C
	WHERE (SELECT COUNT(OrderID) FROM dbo.Orders AS O 
			WHERE O.CustomerID = C.CustomerID ) > 10;
GO

/*
روش سوم
Subquery (EXISTS)

Outer Query: Customers
Sub Query: Orders
*/
SELECT
	C.CompanyName, C.CustomerID 
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O 
					WHERE O.CustomerID = C.CustomerID
					HAVING COUNT(O.OrderID) > 10);
GO

/*
روش چهارم
Subquery (WHERE)

Outer Query: Customers
Sub Query: Orders
*/
SELECT
	C.CompanyName, C.CustomerID 
FROM dbo.Customers AS C
	WHERE C.CustomerID = (SELECT O.CustomerID FROM dbo.Orders AS O 
							WHERE O.CustomerID = C.CustomerID
							GROUP BY O.CustomerID
							HAVING COUNT(O.OrderID) > 10);
GO

/*
روش پنجم
Subquery (NOT EXISTS)

Outer Query: Customers
Sub Query: Orders
*/
SELECT
	C.CompanyName, C.CustomerID
FROM dbo.Customers AS C
	WHERE NOT EXISTS (SELECT 1 FROM dbo.Orders AS O 
						WHERE O.CustomerID = C.CustomerID
						HAVING COUNT(O.OrderID) <= 10);
GO

/*
روش ششم
Subquery (SELECT)

Outer Query: Orders
Sub Query: Customers
*/
SELECT
	(SELECT C.CompanyName FROM dbo.Customers AS C 
		WHERE O.CustomerID = C.CustomerID) AS CustomerID,
	O.CustomerID
FROM dbo.Orders AS O
GROUP BY O.CustomerID
	HAVING COUNT(O.OrderID) > 10;
GO

/*
روش هفتم
روش آش شله قلم‌کار
*/
SELECT 
	C.CompanyName,
	(SELECT O.CustomerID FROM dbo.Orders AS O 
		WHERE O.CustomerID = C.CustomerID 
	 GROUP BY O.CustomerID 
		HAVING COUNT(Orderid) > 10) AS SU
FROM dbo.Customers AS C
	WHERE (SELECT COUNT(Orderid) FROM dbo.Orders AS O 
			WHERE O.CustomerID = C.CustomerID 
		   GROUP BY O.CustomerID 
			HAVING COUNT(Orderid) > 10) > 10;
GO