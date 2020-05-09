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
		/*		Step by Step بررسی سوالات فایل		*/
--------------------------------------------------------------------

USE NikamoozDB;
GO


/*
گام اول

.کارمندان تهرانی (منظور شهر تهران است) که ثبت سفارش داشته‌اند

EmployeeID   LastName
-----------  --------
1             تقوی 
2             فکری
3             پایدار

(3 row(s) affected)

*/

-- Query1 (JOIN)
SELECT
	DISTINCT E.EmployeeID, E.LastName
FROM dbo.Employees AS E
LEFT JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID
	WHERE E.City = N'تهران';
GO
--------------------------------------------------------------------

/*
گام دوم

IN و Subquery با استفاده از Query1 بازنویسی

*/
SELECT
	E.EmployeeID, E.LastName
FROM dbo.Employees AS E
	WHERE E.EmployeeID IN (SELECT O.EmployeeID FROM dbo.Orders AS O
								WHERE E.City = N'تهران');
GO

--بررسی جابجایی شرط میان کوئری درونی و بیرونی
SELECT
	E.EmployeeID, E.LastName
FROM dbo.Employees AS E
	WHERE E.EmployeeID IN (SELECT O.EmployeeID FROM dbo.Orders AS O)
	AND E.City = N'تهران';
GO
--------------------------------------------------------------------

/*
گام سوم

EXISTS و Subquery با استفاده از Query1 بازنویسی
*/

SELECT
	E.EmployeeID, E.LastName
FROM dbo.Employees AS E
	WHERE EXISTS (SELECT O.EmployeeID FROM dbo.Orders AS O
					WHERE O.EmployeeID = E.EmployeeID)
	AND E.City = N'تهران';
GO

--بررسی جابجایی شرط میان کوئری درونی و بیرونی
SELECT
	E.EmployeeID, E.LastName
FROM dbo.Employees AS E
	WHERE EXISTS (SELECT O.EmployeeID FROM dbo.Orders AS O
					WHERE O.EmployeeID = E.EmployeeID
					AND E.City = N'تهران');
GO

-- ???
SELECT 
E.EmployeeID ,E.LastName 
FROM dbo.Employees AS E
	WHERE EXISTS(SELECT O.EmployeeID FROM dbo.Orders AS O
					WHERE E.City  = N'تهران');
GO
--------------------------------------------------------------------

/*
گام چهارم

نمایش تعداد سفارشات ثبت‌شده توسط کارمندان
.تهرانی (منظور شهر است) که انجام شده است


EmployeeID   Num     LastName
----------   ----    --------
1            تقوی     123
2            فکری      96
3            پایدار     127

(3 row(s) affected)

*/

/*
Subquery (SELECT)
Outer Query: Orders
Subquery: Employees
*/
SELECT
	O.EmployeeID,
	(SELECT E.LastName FROM dbo.Employees AS E
		WHERE E.EmployeeID = O.EmployeeID
		AND E.City = N'تهران') AS LastName,
	COUNT(O.OrderID) AS Num
FROM dbo.Orders AS O
GROUP BY O.EmployeeID;
GO

/*

Outer Query: Employees
Subquery: Orders
*/
SELECT
	E.EmployeeID,
	E.LastName,
	(SELECT COUNT(O.OrderID) FROM dbo.Orders AS O
		WHERE O.EmployeeID = E.EmployeeID) AS Num
FROM dbo.Employees AS E
	WHERE E.City = N'تهران';
GO
--------------------------------------------------------------------

/*
گام پنجم

نمایش تعداد سفارشات ثبت‌شده‌ی بیش از 100 مورد که توسط
.کارمندان تهرانی (منظور شهر است) انجام شده است

EmployeeID     LastName
-----------    --------
1               تقوی
3               پایدار

(2 row(s) affected)

*/

-- Subquery (EXISTS)
SELECT
	E.EmployeeID,
	E.LastName
FROM dbo.Employees AS E
	WHERE EXISTS (SELECT 1 FROM dbo.Orders AS O
					WHERE O.EmployeeID = E.EmployeeID
					HAVING COUNT(O.OrderID) > 100)
	AND E.City = N'تهران';
GO

-- Subquery (EXISTS) جابجایی شرط 
SELECT
	E.EmployeeID,
	E.LastName
FROM dbo.Employees AS E
	WHERE EXISTS (SELECT COUNT(O.OrderID) FROM dbo.Orders AS O
					WHERE O.EmployeeID = E.EmployeeID
					AND E.City = N'تهران'
					HAVING COUNT(O.OrderID) > 100);
GO

-- Subquery (IN)
SELECT
	E.EmployeeID,
	E.LastName
FROM dbo.Employees AS E
	WHERE E.EmployeeID IN (SELECT O.EmployeeID FROM dbo.Orders AS O
						   GROUP BY O.EmployeeID
							HAVING COUNT(O.OrderID) > 100)
	AND E.City = N'تهران';
GO