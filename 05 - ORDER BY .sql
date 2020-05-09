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

USE NikamoozDB;
GO

-- EmployeeID عدم مرتب‌سازی روی ستون
SELECT
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71;
GO

-- EmployeeID مرتب‌سازی روی ستون
SELECT
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY EmployeeID DESC; -- ASC: صعودی  DESC: نزولی
GO

-- ORDER BY در SELECT استفاده از اسامی مستعار بخش
SELECT
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY OrderYear DESC;
GO

-- مرتب‌سازی بر روی بیش از یک ستون
SELECT 
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY  EmployeeID DESC, OrderYear;
GO

-- روشی دیگر برای مرتب‌سازی
SELECT 
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY  2,1; -- !!!روش جالبی نیست
GO
--------------------------------------------------------------------

/*
شرکت داده نشده‌اند SELECT مرتب‌سازی بر اساس ستونی که در بخش
*/
SELECT 
	EmployeeID, FirstName, LastName, State, City
FROM dbo.Employees;
GO

SELECT 
	EmployeeID, FirstName, LastName, State
FROM dbo.Employees
ORDER BY City;
GO