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
EXISTS in Subquery

حداقل شامل یک EXISTS در صورتی‌که خروجی
.رکورد باشد آن‌گاه کوئری بیرونی اجرا خواهد شد

*/

-- Orders نمایش لیست تمامی سفارشات موجود در جدول
SELECT * FROM dbo.Orders
	WHERE EXISTS (SELECT 1 FROM dbo.Customers
					WHERE City = N'تهران');-- شامل چندین رکورد EXISTS خروجی
GO

-- Orders نمایش لیست تمامی سفارشات موجود در جدول
SELECT * FROM dbo.Orders
	WHERE EXISTS (SELECT 1 FROM dbo.Customers
					WHERE City = N'بیرجند');-- شامل 1 رکورد EXISTS خروجی
GO

-- Orders عدم نمایش حتی 1 رکورد از جدول
SELECT * FROM dbo.Orders
	WHERE EXISTS (SELECT 1 FROM dbo.Customers
					WHERE City = N'کرج');-- فاقد رکورد EXISTS خروجی
GO

-- Orders نمایش لیست تمامی سفارشات موجود در جدول
SELECT * FROM dbo.Orders
	WHERE NOT EXISTS (SELECT 1 FROM dbo.Customers
						WHERE City = N'کرج');-- فاقد رکورد EXISTS خروجی
GO
--------------------------------------------------------------------

-- نمایش اطلاعات تمامی مشتریان دارای سفارش
SELECT
	C.*
FROM dbo.Customers AS C
	WHERE EXISTS (SELECT * FROM dbo.Orders AS O
					WHERE O.CustomerID = C.CustomerID);
GO

-- نمایش اطلاعات تمامی مشتریان فاقد سفارش
SELECT
	C.*
FROM dbo.Customers AS C
	WHERE NOT EXISTS (SELECT * FROM dbo.Orders AS O
						WHERE O.CustomerID = C.CustomerID);
GO

--------------------------------------------------------------------

SELECT * FROM dbo.Orders
	WHERE CustomerID = 18
ORDER BY CustomerID;
GO

/*
تمرین کلاسی

نمایش نام و نام‌خانوادگی کارمندانی که
.با مشتری شماره 18 ثبت سفارش داشته‌اند

FirstName   LastName
---------   --------
تقوی          سحر
فکری         بهزاد
سلامی        پیمان

(3 rows affected)

*/

-- JOIN با استفاده از
SELECT
	E.FirstName, E.LastName
FROM dbo.Employees AS E
JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID
	AND O.CustomerID = 18;
GO


-- رفع ایراد کوئری بالا 
SELECT
	DISTINCT E.FirstName, E.LastName
FROM dbo.Employees AS E
JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID
	AND O.CustomerID = 18;
GO

-- IN با استفاده از
SELECT
	E.FirstName, E.LastName
FROM dbo.Employees AS E
	WHERE E.EmployeeID IN (SELECT EmployeeID FROM dbo.Orders
							WHERE CustomerID = 18);
GO

-- EXISTS با استفاده از
SELECT
	E.FirstName, E.LastName
FROM dbo.Employees AS E
	WHERE EXISTS (SELECT EmployeeID FROM dbo.Orders AS O
						WHERE CustomerID = 18
						AND O.EmployeeID = E.EmployeeID);
GO
--------------------------------------------------------------------

/*
EXISTS & 2VL
*/

SELECT * FROM dbo.Customers 
	WHERE EXISTS (SELECT Region FROM dbo.Customers
					WHERE Region IS NULL);
GO

SELECT * FROM dbo.Customers 
	WHERE NOT EXISTS (SELECT Region FROM dbo.customers
						WHERE Region IS NULL);
GO