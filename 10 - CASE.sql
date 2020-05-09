﻿/*
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

-- لیست تمامی محصولات
SELECT
	ProductID, ProductName, CategoryID
FROM dbo.Products;
GO

-- Simple CASE
SELECT 
	ProductID, ProductName, CategoryID,
	CASE CategoryID
		WHEN 1 THEN N'نوشیدنی'
		WHEN 2 THEN N'ادویه‌جات'
		WHEN 3 THEN N'مرباجات'
		WHEN 4 THEN N'محصولات لبنی'
		WHEN 5 THEN N'حبوبات'
		WHEN 6 THEN N'گوشت و مرغ'
		WHEN 7 THEN N'ارگانیک'
		WHEN 8 THEN N'دریایی'
		ELSE N'متفرقه'
	END AS CategoryName
FROM dbo.Products
ORDER BY CategoryName;
GO
--------------------------------------------------------------------

-- محصولات براساس قیمت پایه
SELECT
	ProductID, UnitPrice
FROM dbo.OrderDetails;
GO

-- Searched CASE
SELECT ProductID, UnitPrice,
	CASE
		WHEN UnitPrice < 50 THEN N'کمتر از 50'
		WHEN UnitPrice BETWEEN 50 AND 100 THEN N'بین 50 تا 100'
		WHEN UnitPrice > 100 THEN N'بیشتر از 100'
	ELSE N'نامشخص'
	END AS UnitPriceCategory
FROM dbo.OrderDetails
ORDER BY UnitPrice;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
.نوشته شده است Simple CASE کوئری زیر به‌صورت
.بازنویسی کنید Searched CASE اکنون آن را به‌صورت
*/

SELECT 
	EmployeeID, FirstName, TitleofCourtesy,
	CASE TitleofCourtesy
		WHEN 'Ms.'  THEN 'Female'
		WHEN 'Mrs.' THEN 'Female'
		WHEN 'Mr.'  THEN 'Male'
		ELSE 'Unknown'
	END AS Gender
FROM dbo.Employees;
GO

SELECT
	EmployeeID, FirstName, TitleofCourtesy,
	CASE
		WHEN TitleofCourtesy IN ('Ms.','Mrs.') THEN 'Female'
		WHEN TitleofCourtesy = 'Mr.' THEN 'Male'
		ELSE 'Unknown'
	END AS Gender
FROM dbo.Employees;
GO


--------------------------------------------------------------------

--- ???
-- .خواهند شد NULL باشد آن‌گاه سایر مقادیر که در شرط صدق نکنند در خروجی ELSE فاقد CASE اگر
SELECT
	City,
	CASE City
		WHEN N'تهران' THEN N'پایتخت' 
	END AS N'نوع شهر'
FROM dbo.Customers;
GO

--------------------------------------------------------------------

/*
و مرتب‌سازی رکوردها NULL
*/

-- .در ابتدای فهرست مرتب می‌شوند NULL در مرتب‌سازی صعودی، مقادیر
SELECT 
	CustomerID, Region
FROM dbo.Customers 
ORDER BY Region;
GO

-- .در انتهای فهرست مرتب می‌شوند NULL در مرتب‌سازی نزولی، مقادیر
SELECT 
	CustomerID, Region
FROM dbo.Customers 
ORDER BY Region DESC;
GO

-- CASE رفع مشکل مرتب‌سازی با استفاده از 
SELECT CustomerID, Region
FROM dbo.Customers
ORDER BY 
	CASE WHEN Region IS NULL THEN 1 ELSE 0 END,Region;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
.کوئری زیر را به‌گونه‌ای بازنویسی کنید که خروجی آن به‌صورت زیر باشد
در انتها بیاید NULL انجام شود اما مقادیر Region در واقع مرتب‌سازی صعودی و براساس فیلد
.به‌صورت نزولی باشد CustomerID مرتب‌سازی فیلد Region ضمنا در صورت وجود مقادیر تکراری در فیلد

CustomerID    Region
----------- ---------------
67          جنوب
88          شمال
82          شمال
75          شمال
48          شمال
35          شمال
31          شمال
10          شمال
65          غرب
47          غرب
...
91          NULL
90          NULL
87          NULL
...
3           NULL
2           NULL
1           NULL

(91 rows affected)
*/

SELECT 
	CustomerID, Region
FROM dbo.Customers
ORDER BY Region;
GO

SELECT 
	CustomerID, Region
FROM dbo.Customers
ORDER BY
	CASE WHEN Region IS NULL THEN 1 ELSE 0 END,Region,CustomerID DESC;
GO