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

-- فهرست تمامی‌سفارشات، مرتب‌شده بر اساس جدید‌ترین تاریخ
SELECT
	OrderID, OrderDate
FROM dbo.Orders
ORDER BY OrderDate DESC;
GO

-- مشاهده جدیدترین 5 سفارش ثبت‌شده
SELECT
	TOP (5) OrderID, OrderDate
FROM dbo.Orders
ORDER BY OrderDate DESC;
GO

-- مشاهده قدیمی‌ترین 5 سفارش ثبت‌شده
SELECT
	TOP (5) OrderID, OrderDate
FROM dbo.Orders
ORDER BY OrderDate;
GO

-- انتخاب پنج درصد از جدیدترین سفارش‌های ثبت‌شده
SELECT
	TOP (5) PERCENT OrderID, OrderDate
FROM dbo.Orders
ORDER BY OrderDate DESC;
GO

-- ORDER BY بدون استفاده از TOP فیلتر
SELECT
	TOP (5) OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders;
GO

--  انتخاب جدیدترین پنج سفارش ثبت‌شده با درنظر گرفتن سایر مقادیر برابر
SELECT
	TOP (5) WITH TIES OrderID, OrderDate, CustomerID, EmployeeID
FROM dbo.Orders
ORDER BY OrderDate DESC;
GO