﻿--------------------------------------------------------------------
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
.مشاهده فهرست کارمندانی که با مشتری 71 ثبت سفارش داشته‌اند
.طبیعی است که یک کارمند برای یک مشتری چندین ثبت سفارش را انجام داده باشد
*/
SELECT 
	EmployeeID
FROM dbo.Orders
	WHERE CustomerID = 71;
GO

/*
DISTINCT
عدم درنظر گرفتن مقادیر تکراری
*/
SELECT 
	DISTINCT EmployeeID 
FROM dbo.Orders
	WHERE CustomerID = 71;
GO

/*
مشاهده فهرست کارمندانی که با مشتری 71
.ثبت سفارش داشته‌اند به‌همراه سال ثبت سفارش
تکرار رکوردها
*/ 
SELECT 
	EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71
ORDER BY EmployeeID;
GO

-- بر روی بیش از یک ستون DISTINCT عملیات
SELECT 
	DISTINCT EmployeeID, YEAR(OrderDate) AS OrderYear
FROM dbo.Orders
	WHERE CustomerID = 71 -- Plan بررسی
ORDER BY EmployeeID;
GO

-- ORDER BY و DISTINCT چالش
SELECT 
	DISTINCT State
FROM dbo.Employees;
GO

SELECT 
	  DISTINCT State
FROM dbo.Employees
ORDER BY EmployeeID;
GO