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

/*
Self-Contained Scalar-Valued Subquery
*/

USE NikamoozDB;
GO

/*
WHERE مستقل در بخش Subquery
*/

-- TOP جدید‌ترین سفارش ثبت‌شده با استفاده از فیلتر
SELECT 
	TOP (1) EmployeeID,
	CustomerID,
	OrderID,
	MAX(OrderDate) AS NewOrders
FROM dbo.Orders
GROUP BY OrderID, OrderDate, EmployeeID, CustomerID
ORDER BY OrderID DESC;
GO

-- OFFSET جدید‌ترین سفارش ثبت‌شده با استفاده از فیلتر
SELECT
	EmployeeID,
	CustomerID,
	OrderID,
	MAX(OrderDate) AS NewOrders
FROM dbo.Orders
GROUP BY OrderID, OrderDate, EmployeeID, CustomerID
ORDER BY OrderID DESC
OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY;
GO

-- جدید‌ترین سفارش ثبت‌شده با استفاده از متغیر
DECLARE @MaxID AS INT = (SELECT MAX(OrderID) FROM dbo.Orders);
SELECT
	EmployeeID, CustomerID, OrderID
FROM dbo.Orders
	WHERE OrderID = @MaxID;
GO

-- مستقل Subquery جدید‌ترین سفارش ثبت‌شده با استفاده از
SELECT
	EmployeeID, CustomerID, OrderID
FROM dbo.Orders
	WHERE OrderID = (SELECT MAX(OrderID) FROM dbo.Orders);
GO
--------------------------------------------------------------------

/*
SELECT مستقل در بخش Subquery
*/

-- تعداد سفارش مشتریانی که درخواست سفارش داشته‌اند
SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- ???
-- تعداد سفارش هر مشتری به‌همراه تعداد کل سفارشات موجود
SELECT
	CustomerID,
	COUNT(OrderID) AS Num,
	COUNT(COUNT(OrderID)) AS Total -- Cannot perform an aggregate function on an expression containing an aggregate or a subquery.
FROM dbo.Orders
GROUP BY CustomerID;
GO 

/*
نمایش تعداد سفارش‌های هر مشتری به‌همراه تعداد کل سفارشات تمامی مشتریان

CustomerID   Num   Total
----------   ---   -----
   1          6     830
   2          4     830
   3          7     830
   4          13    830
   5          18    830
   ...		      
   90         7     830
   91         7     830

(89 row(s) affected)
*/
DECLARE @Num INT = (SELECT COUNT(OrderID) FROM dbo.Orders);
SELECT
	CustomerID,
	COUNT(OrderID) AS Num,
	@Num AS Total
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- مستقل Subquery تعداد سفارش هر مشتری به‌همراه تعداد کل سفارش ثبت‌شده با استفاده از
SELECT
	CustomerID,
	COUNT(OrderID) AS Num,
	(SELECT COUNT(OrderID) FROM dbo.Orders) AS Total
FROM dbo.Orders
GROUP BY CustomerID;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
کوئری‌ای بنویسید که علاوه بر تعداد سفارش ثبت‌شده
توسط هر کارمند، جدید‌ترین و قدیمی‌ترین سفارش ثبت‌شده در میان
.تمامی سفارشات از تمامی کارمندان را هم نمایش دهد

EmployeeID  Num          MaxOrders                 MinOrders
----------- ----   -----------------------   -----------------------
    9       43     2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    3       127    2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    6       67     2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    7       72     2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    1       123    2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    4       156    2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    5       42     2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    2       96     2016-05-06 00:00:00.000   2014-07-04 00:00:00.000
    8       104    2016-05-06 00:00:00.000   2014-07-04 00:00:00.000

(9 row(s) affected)

*/
SELECT
	EmployeeID,
	COUNT(OrderID) AS NUM,
	(SELECT MAX(OrderDate) FROM Orders) AS MaxOrders,
	(SELECT MIN(OrderDate) FROM Orders) AS MinOrders
FROM dbo.Orders
GROUP BY EmployeeID;
GO

-- بررسی تفاوت این کوئری با کوئری بالا
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num,
	MAX(OrderDate) AS MaxOrders,
	MIN(OrderDate) AS MinOrders
FROM dbo.Orders
GROUP BY EmployeeID;
GO
--------------------------------------------------------------------

/*
:نکته بسیار مهم
.مستقل تک‌مقدار می‌بایست همواره فقط یک مقدار را برگرداند Subquery
*/

-- .کارمندانی که نام‌خانوادگی آن‌ها با حرف پ آغاز می‌شود
SELECT * FROM dbo.Employees
	WHERE LastName LIKE N'پ%';
GO

/*
تمامی سفارشات ثبت‌شده توسط کارمندانی که
.نام‌خانوادگی آن‌ها با کاراکتر 'پ' شروع شده باشد
JOIN با استفاده از
*/
SELECT
	O.OrderID, E.EmployeeID
FROM dbo.Orders AS O
JOIN dbo.Employees AS E
	ON O.EmployeeID = E.EmployeeID
	WHERE E.LastName LIKE N'پ%';
GO

/*
تمامی سفارشات ثبت‌شده توسط کارمندانی که
.نام‌خانوادگی آن‌ها با کاراکتر 'پ' شروع شده باشد
مستقل تک‌مقدار Subquery با استفاده از
*/
SELECT
	OrderID, EmployeeID
FROM dbo.Orders
	WHERE EmployeeID = (SELECT EmployeeID FROM dbo.Employees
							WHERE LastName LIKE N'پ%');
GO

-- .کارمندانی که نام‌خانوادگی آن‌ها با حرف ت آغاز می‌شود
SELECT * FROM dbo.Employees
	WHERE LastName LIKE N'ت%';
GO

/*
تمامی سفارشات ثبت‌شده توسط کارمندانی که
.نام‌خانوادگی آن‌ها با کاراکتر 'ت' شروع شده باشد
*/
SELECT
	OrderID, EmployeeID
FROM dbo.Orders
	WHERE EmployeeID = (SELECT EmployeeID FROM dbo.Employees
							WHERE LastName LIKE N'ت%');
GO