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
INNER JOIN: ANSI SQL-92

SELECT 
	<SELECT list>
FROM <table1>
[INNER] JOIN <table2>
	ON ...

*/

-- .نمایش نام و نام‌خانوادگی هر کارمند و کد سفارشاتی که ثبت‌ کرده است 
SELECT
	E.FirstName, E.LastName, O.OrderID
FROM dbo.Employees AS E
JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID;
GO

-- .کوئری بالا با شرط این‌که نام‌خانوادگی با حرف الف شروع نشده باشد
SELECT
	E.FirstName, E.LastName, O.OrderID
FROM dbo.Employees AS E
JOIN dbo.Orders AS O
	ON E.EmployeeID = O.EmployeeID
	WHERE E.LastName NOT LIKE N'ا%'; -- LIKE N'[^ا]%'
GO
--------------------------------------------------------------------

/*
INNER JOIN: ANSI SQL-89

SELECT 
	<SELECT list>
FROM <table1>, <table2>
	WHERE ...

*/

-- .نمایش نام و نام‌خانوادگی هر کارمند و سفارشاتی که ثبت‌ کرده است 
SELECT
	E.FirstName, E.LastName, O.OrderID
FROM dbo.Employees AS E, dbo.Orders AS O
	WHERE E.EmployeeID = O.EmployeeID;
GO
--------------------------------------------------------------------

/*
AN SI SQL-92 دلیل استفاده از استاندارد
*/

-- Query With ANSI SQL-92
SELECT
	E.EmployeeID, E.FirstName, E.LastName, O.orderid
FROM dbo.Employees AS E
JOIN dbo.Orders AS O; -- ON فاقد بخش
GO

-- Query With ANSI SQL-89
SELECT
	E.EmployeeID, E.FirstName, E.LastName, O.orderid
FROM dbo.Employees AS E, dbo.Orders AS O
	 WHERE E.EmployeeID = O.EmployeeID; -- نوشته‌ایم CROSS JOIN کوئری اجرا خواهد شد چرا که انگار به‌صورت WHERE در صورت نادیده گرفتن بخش
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

کوئری‌ای بنویسید که شامل فهرست شهرهای مشتریانی باشد
.که بیش از 50 سفارش در سیستم ثبت کرده باشند

City		Num
-----		----
تهران		 139
یزد			51
مشهد		56
اصفهان		57
تبریز		52
شیراز		60

(6 rows affected)

*/
SELECT
	C.City,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.City
	HAVING COUNT(O.OrderID) > 50;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

از کدام شهر کمترین ثبت سفارش را داشته‌ایم؟ 
.در خروجی تعداد سفارش آن‌ هم نمایش داده شود

 City	    Num
------	   -----
زنجان		  2

(1 row affected)

*/
SELECT
	TOP (1) WITH TIES C.City,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.City
ORDER BY Num;
GO

--------------------------------------------------------------------

/*
تمرین کلاسی

کوئری‌ای بنویسید تا 3 محصولی که بیشترین فروش
.را از آن‌ها داشته‌ایم در خروجی نمایش دهد
.استفاده کنید OrderDetails و Products برای حل این تمرین از دو جدول

ProductName     Sum_Total
------------    -----
پنیر خامه‌ای		1577
کره				1469
سرشیر			1477

(3 rows affected)

*/
SELECT
	TOP (3) P.ProductName,
	SUM(OD.Qty) AS Sum_Total
FROM dbo.OrderDetails AS OD
JOIN dbO.Products AS P
	ON OD.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY Sum_Total DESC;
GO