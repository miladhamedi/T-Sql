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
		/*		Questions 02 بررسی سوالات فایل		*/
--------------------------------------------------------------------

USE NikamoozDB;
GO

/*
Exersice 01

.هستند A نمایش رکوردهایی که فقط در جدول

ID
--
1
3
4

(3 row(s) affected)

*/

DROP TABLE IF EXISTS A,B;
GO

CREATE TABLE A
(
	ID TINYINT
);
GO

CREATE TABLE B
(
	ID TINYINT
);
GO

INSERT INTO A
	VALUES (1),(2),(3),(4);
GO

INSERT INTO B
	VALUES (2),(NULL);
GO 

-- JOIN
SELECT A.ID FROM A
JOIN B 
	ON A.ID <> B.ID;
GO

-- Subquery (EXISTS)
SELECT ID FROM A
	WHERE EXISTS (SELECT 1 FROM B
					WHERE A.ID <> B.ID);
GO

-- Subquery (NOT EXISTS)
SELECT ID FROM A
	WHERE NOT EXISTS (SELECT 1 FROM B
						WHERE A.ID = B.ID);
GO

-- Subquery (NOT IN) Without Checking
SELECT ID FROM A
	WHERE  ID NOT IN (SELECT ID FROM B);
GO

-- Subquery (NOT IN) With Checking
SELECT ID FROM A
	WHERE  ID NOT IN (SELECT ID FROM B
						WHERE ID IS NOT NULL);
GO

-- Subquery (NOT IN) With Checking
SELECT ID FROM A
	WHERE  ID NOT IN (SELECT ISNULL(ID, '') FROM B);
GO

-- Subquery (NOT IN)
SELECT ID FROM A
	WHERE  ID NOT IN (SELECT ID FROM B
						WHERE A.ID = B.ID);
GO
--------------------------------------------------------------------

/*
Exersice 02
*/

SELECT
	DISTINCT C.CustomerID
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
	WHERE O.OrderDate >= '20160505'
	AND OD.UnitPrice > 20;
GO

SELECT
	C.CustomerID
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O
				  JOIN dbo.OrderDetails AS OD
					ON OD.OrderID = O.OrderID
					WHERE  O.CustomerID = C.CustomerID
					AND OD.UnitPrice > 20
					AND O.OrderDate >= '20160505');
GO

/*
:تفسیر کوئری بالا

تمامی مشتریانی که از تاریخ 20160505 به‌بعد در فاکتور
.درخواستی‌شان کالاهایی با قیمت بیش از 20 را سفارش داده‌اند

*/

-- ???
SELECT
	C.CustomerID
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O
				  JOIN dbo.OrderDetails AS OD
					ON OD.OrderID = O.OrderID
					--WHERE  O.CustomerID = C.CustomerID
					AND OD.UnitPrice > 20
					AND O.OrderDate >= '20160505');
GO
--------------------------------------------------------------------

/*
Exersice 03

.فهرست شهرها و تعداد مشتریان شهرهایی که از مشتریان شهر سمنان بیشتر هستند

Num   City
---   ------
اصفهان     7
تهران    14
شیراز     6

(3 rows affected)

*/

-- تعداد مشتریان از شهر سمنان
SELECT
	City,
	COUNT(City) AS Num
FROM dbo.Customers
	WHERE City = N'سمنان'
GROUP BY City;
GO

-- تعداد مشتران از تمامی شهرها به‌جز سمنان
SELECT
	City,
	COUNT(City) AS Num
FROM dbo.Customers
	WHERE City <> N'سمنان'
GROUP BY City
ORDER BY Num DESC;
GO

-- Subquery (HAVING)
SELECT
	City,
	COUNT(City) AS Num
FROM dbo.Customers
GROUP BY City
	HAVING COUNT(City) > (SELECT COUNT(City) FROM dbo.Customers
							WHERE City = N'سمنان');
GO
--------------------------------------------------------------------

/*
Exersice 04

EmployeeID
-----------
    1
    6

(2 row(s) affected)

*/

-- .کارمندانی که با مشتری شماره 1 ثبت سفارش داشته‌اند
SELECT EmployeeID FROM dbo.Orders 
	WHERE CustomerID = 1
ORDER BY EmployeeID;
GO

-- .کارمندانی که با مشتری شماره 2 ثبت سفارش داشته‌اند
SELECT EmployeeID FROM dbo.Orders 
	WHERE CustomerID = 2
ORDER BY EmployeeID;
GO

-- Set Operator
SELECT EmployeeID FROM dbo.Orders 
	WHERE CustomerID = 1

EXCEPT

SELECT EmployeeID FROM dbo.Orders 
	WHERE CustomerID = 2;
GO

-- Subquery(IN)
SELECT
	 DISTINCT EmployeeID 
FROM dbo.Orders
	WHERE EmployeeID NOT IN (SELECT EmployeeID FROM dbo.Orders 
								WHERE CustomerID = 2)
	AND CustomerID = 1;
GO

--Subquery(EXISTS)
SELECT
	DISTINCT EmployeeID 
FROM Orders AS O1
	WHERE NOT EXISTS(SELECT EmployeeID FROM dbo.Orders AS O2 
						WHERE O2.EmployeeID = O1.EmployeeID 
						AND O2.CustomerID = 2)
	AND CustomerID = 1;
GO

-- EXISTS (رویال برگر با قارچ و پنیر)
SELECT 
	EmployeeID 
FROM Employees AS O1
	WHERE NOT EXISTS(SELECT EmployeeID FROM Orders AS O2 
						WHERE O1.EmployeeID = O2.EmployeeID 
						AND CustomerID = 2)
	AND EXISTS(SELECT EmployeeID FROM Orders AS O2 
						WHERE O1.EmployeeID = O2.EmployeeID 
						AND CustomerID = 1);
GO