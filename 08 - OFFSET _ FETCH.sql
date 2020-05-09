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

/*
OFFSET [integer_constant | offset_row_count_expression] ROWS|ROW 
FETCH NEXT|FIRST [integer_constant | offset_row_count_expression] ROWS|ROW ONLY
*/

-- نمایش 10 سفارش ثبت‌شده اخیر
SELECT 
	TOP (10) OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC;
GO

-- OFFSET FETCH شبیه‌سازی کوئری بالا با استفاده از 
SELECT
	OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC
OFFSET 0 ROWS FETCH NEXT 10 ROWS ONLY;
GO

/*
جدیدترین 5 سفارش پس از 10 سفارش اخیر
یعنی سفارش‌های 11 تا 15
*/
SELECT
	OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC
OFFSET 10 ROWS FETCH NEXT 5 ROWS ONLY;
GO

/*
FETCH بدون OFFSET
نادیده گرفتن 10 سفارش ابتدایی از لیست رکوردها بر اساس نوع مرتب‌سازی و نمایش سایر رکوردها
*/
SELECT 
	OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC, OrderID DESC
OFFSET 10 ROWS;
GO

-- !!!قابل اجرا نیست OFFSET بدون FETCH
SELECT 
	OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC, OrderID DESC
FETCH NEXT 5 ROWS ONLY;
GO

/*
:نکته مهم
OFFSET FETCH در PERCENT و WITH TIES عدم پشتیبانی از  
*/
--------------------------------------------------------------------

/* Logical Order
-- SELECT ترتیب اجرای منطقی بخش‌های مخالف دستور

1- FROM
2- WHERE
3- GROUP BY
4- HAVING
5- SELECT
	5-1 Expressions
	5-2 DISTINCT
6- ORDER BY
7- TOP / OFFSET-FETCH

*/