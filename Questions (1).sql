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
Exersice 01
.فهرست شرکت‌هایی که بیش از 10 سفارش درخواست داشته‌اند
*/

/*
JOIN
*/
SELECT
	C.CompanyName,C.CustomerID
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName, C.CustomerID
HAVING COUNT(O.OrderID) > 10;
GO


/*
Subquery (WHERE)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CompanyName,
	C.CustomerID
FROM dbo.Customers AS C
	WHERE (SELECT COUNT(O.OrderID) FROM dbo.Orders AS O
			WHERE O.CustomerID = C.CustomerID) > 10;
GO


/*
Subquery (EXISTS)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CompanyName,
	C.CustomerID
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O
					WHERE O.CustomerID = C.CustomerID
					HAVING COUNT(O.OrderID) > 10);
GO


/*
Subquery (IN)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CompanyName,
	C.CustomerID
FROM dbo.Customers AS C
	WHERE C.CustomerID IN (SELECT CustomerID FROM dbo.Orders
						   GROUP BY CustomerID
							HAVING COUNT(OrderID) > 10);
GO


SELECT
	C.CompanyName,
	C.CustomerID
FROM dbo.Customers AS C
	WHERE C.CustomerID IN (SELECT O.CustomerID FROM dbo.Orders AS O
							WHERE O.CustomerID = C.CustomerID
						   GROUP BY O.CustomerID
							HAVING COUNT(O.OrderID) > 10);
GO


/*
Subquery (SELECT)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CompanyName,
	(SELECT O.CustomerID FROM dbo.Orders AS O
		WHERE O.CustomerID = C.CustomerID
	GROUP BY O.CustomerID
		HAVING COUNT(O.OrderID) > 10) AS CustomerID
FROM dbo.Customers AS C;
GO


/*
Subquery (SELECT)

Outer Query: Orders
Subquery: Customers
*/
SELECT
	(SELECT C.CompanyName FROM dbo.Customers AS C
		WHERE C.CustomerID = O.CustomerID),
	O.CustomerID
FROM dbo.Orders AS O
GROUP BY O.CustomerID
HAVING COUNT(O.OrderID) > 10;
GO
--------------------------------------------------------------------

/*
Exersice 02
.تعداد سفارش شرکت‌هایی که در استان زنجان واقع شده‌اند
*/

/*
JOIN
*/
SELECT
	C.CompanyName,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
	WHERE C.City = N'زنجان'
GROUP BY C.CompanyName;
GO


/*
Subquery (SELECT)

Outer Query: Customers
Subquery: Orders
*/
SELECT
	C.CompanyName,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O
		WHERE O.CustomerID = C.CustomerID) AS Num
FROM dbo.Customers AS C
	WHERE C.City = N'زنجان';
GO

-- ???
SELECT
	C.CompanyName, 
	(SELECT COUNT(OrderID) FROM dbo.Orders AS O 
		WHERE O.CustomerID = C.CustomerID
		AND C.City = N'زنجان') AS Num
FROM dbo.Customers AS C;
GO


/*
Subquery (SELECT)

Outer Query: Orders
Subquery: Customers
*/
SELECT
	(SELECT C.CompanyName FROM dbo.Customers AS C
		WHERE C.CustomerID = O.CustomerID
		AND C.City = N'زنجان'),
	COUNT(O.OrderID) AS Num
FROM dbo.Orders AS O
GROUP BY O.CustomerID;
GO
--------------------------------------------------------------------

/*
Exersice 03
.محصولاتی که قیمت واحد آن‌ها از میانگین قیمت واحد تمامی محصولات بیشتر و یا با آن برابر باشد
*/

-- میانگین قیمت واحد تمامی محصولات
SELECT AVG(UnitPrice) FROM dbo.Products;
GO

-- ???
SELECT
	ProductID, UnitPrice
FROM dbo.Products
GROUP BY ProductID
	HAVING UnitPrice >= AVG(UnitPrice);
GO

-- ???
SELECT
	ProductID, UnitPrice
FROM dbo.Products
GROUP BY ProductID, UnitPrice
	HAVING UnitPrice >= AVG(UnitPrice);
GO

-- Subquery (WHERE)
SELECT
	ProductID, UnitPrice
FROM dbo.Products
	WHERE UnitPrice >= (SELECT AVG(UnitPrice) FROM dbo.Products);
GO


-- Subquery (IN)
SELECT
	P.ProductID, P.UnitPrice
FROM dbo.Products AS P
WHERE P.ProductID IN (SELECT P.ProductID FROM dbo.Products AS P 
						WHERE P.UnitPrice > (SELECT AVG(Products.UnitPrice) FROM dbo.Products))
ORDER BY P.UnitPrice;
GO


-- Subquery (EXISTS)
SELECT
	P1.ProductID, P1.UnitPrice
FROM dbo.Products AS P1
WHERE EXISTS (SELECT P2.ProductID FROM dbo.Products AS P2 
				WHERE P2.UnitPrice > (SELECT AVG(Products.UnitPrice) FROM dbo.Products)
				AND p1.ProductID = P2.ProductID)
ORDER BY P1.UnitPrice;
GO
--------------------------------------------------------------------

/*
Exersice 04
.مشخصات کارمندی که تا به امروز کمترین تعداد ثبتِ سفارش را داشته است
*/

-- تعداد سفارشات ثبت‌شده توسط هر کارمند
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY EmployeeID;
GO

-- .کارمندانی که کمترین ثبت‌سفارش داشته‌اند
SELECT
	TOP (1) WITH TIES EmployeeID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY EmployeeID
ORDER BY Num;
GO

-- JOIN
SELECT
	TOP (1) WITH TIES E.EmployeeID, E.FirstName, E.LastName
FROM dbo.Employees AS E
JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID
GROUP BY E.EmployeeID, E.FirstName, E.LastName
ORDER BY COUNT(O.OrderID);
GO


/*
Subquery (IN)

Outer Query: Employees
Subquery: Orders
*/
SELECT
	E.EmployeeID, E.FirstName, E.LastName
FROM dbo.Employees AS E
	WHERE E.EmployeeID IN (SELECT TOP (1) WITH TIES EmployeeID FROM dbo.Orders
							GROUP BY EmployeeID
							ORDER BY COUNT(OrderID));
GO


/*
Subquery (WHERE)

Outer Query: Employees
Subquery: Orders

روش خطرناک
*/
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE EmployeeID = (SELECT
							TOP (1) WITH TIES EmployeeID 
						FROM dbo.Orders
						GROUP BY EmployeeID
						ORDER BY COUNT(OrderID));
GO


/*
Subquery (SELECT)

Outer Query: Orders
Subquery: Employees
*/
SELECT
	TOP (1) WITH TIES O.EmployeeID,
	(SELECT E.FirstName FROM dbo.Employees AS E
		WHERE E.EmployeeID = O.EmployeeID) AS FirstName,
	(SELECT E.LastName FROM dbo.Employees AS E
		WHERE E.EmployeeID = O.EmployeeID) AS LastName
FROM dbo.Orders AS O
GROUP BY O.EmployeeID
ORDER BY COUNT(O.OrderID);
GO


/*
Subquery (SELECT)

Outer Query: Employees
Subquery: Orders
*/
SELECT
	TOP (1) WITH TIES E.employeeID, E.FirstName, E.LastName,
	(SELECT COUNT(OrderID) FROM dbo.Orders AS O
		WHERE E.EmployeeID = O.EmployeeID) AS Num 
FROM dbo.Employees AS E
ORDER BY Num;
GO

SELECT
	TOP (1) WITH TIES E.employeeID, E.FirstName, E.LastName
FROM dbo.Employees AS E
ORDER BY (SELECT COUNT(OrderID) FROM dbo.Orders AS O
		WHERE E.EmployeeID = O.EmployeeID);
GO
--------------------------------------------------------------------

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
							WHERE YEAR(O.OrderDate) = 2015)
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