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
CROSS JOIN: ANSI SQL-92

CROSS JOIN
ANSI SQL-92

SELECT 
	<SELECT list>
FROM <table1>
CROSS JOIN <table2> 
*/

-- Customers\Employees تمامی ترکیبات دو تایی میان مشتریان و کارمندان
-- !کوئری توجه کنید Plan به
SELECT
	CustomerID, EmployeeID
FROM dbo.Customers
CROSS JOIN dbo.Employees;
GO

-- Customers\Orders تمامی ترکیبات دو تایی میان کدهای مشتریان و کارمندان
/*
.ابهام در انتخاب فیلد مورد‌نظر چرا که در هر دو جدول وجود دارد
.استفاده کنید TableObject.FieldName برای جلوگیری از ابهام در تشابه نام ستون‌ها از الگوی
*/
SELECT
	CustomerID, EmployeeID
FROM dbo.Customers
CROSS JOIN dbo.Orders;
GO

-- Alias رفع مشکل کوئری بالا با استفاده از
SELECT
	C.CustomerID, EmployeeID
FROM dbo.Customers AS C
CROSS JOIN dbo.Orders AS O;
GO

SELECT
	C.CustomerID , Orders.EmployeeID -- O.EmployeeID
FROM dbo.Customers AS C
CROSS JOIN dbo.Orders AS O; -- توجه به نام دوبخشی
GO
--------------------------------------------------------------------

/*
CROSS JOIN: ANSI SQL-89

SELECT 
	<SELECT list>
FROM <table1> , <table2>

*/
-- تمامی ترکیبات دو تایی میان مشتریان و کارمندان
SELECT
	CustomerID, EmployeeID
FROM dbo.Customers, dbo.Employees;
GO
--------------------------------------------------------------------

-- CROSS JOIN استفاده از فیلترینگ در
SELECT
	CustomerID, EmployeeID
FROM dbo.Customers
CROSS JOIN dbo.Employees
	WHERE CustomerID > 90;
GO

SELECT
	CustomerID, EmployeeID
FROM dbo.Customers, dbo.Employees
	WHERE CustomerID > 90;
GO