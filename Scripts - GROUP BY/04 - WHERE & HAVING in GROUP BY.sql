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
GROUP BY در WHERE بررسی
*/

-- تعداد همه سفارشات کارمندان به‌جز سفارشات ثبت شده توسط کارمند شماره 9 
SELECT
	EmployeeID,
	COUNT(OrderID)
FROM dbo.Orders
	WHERE EmployeeID <> 9
GROUP BY EmployeeID;
GO
--------------------------------------------------------------------

/*
GROUP BY در HAVING بررسی
*/

-- .نمایش تمامی مشتریانی که بیش از 20 سفارش داشته‌اند
SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
	WHERE COUNT(OrderID) > 20
GROUP BY CustomerID;
GO

SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY CustomerID
	HAVING COUNT(OrderID) > 20;
GO
--------------------------------------------------------------------

/*
GROUP BY در WHERE و HAVING بررسی
*/

-- .تعداد سفارشات بالای 70 و سفارشاتی که توسط کارمند شماره 8 ثبت نشده است
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
	WHERE EmployeeID <> 8
GROUP BY EmployeeID
	HAVING COUNT(OrderID) > 70;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
فهرست تمامی سفارشات مشتری شماره 71 به تفکیک هر سال 
.که شامل تعداد سفارش و مجموع هزینه‌های ارسال باشد

CustomerID   OrderYear  NumOrders  TotalFreight
-----------  ---------  ---------  ------------
  71           2014       3          429.99
  71           2015       17         3113.50
  71           2016       11         3140.21

(3 rows affected)

*/
SELECT
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS NumOrders,
	SUM(Freight) AS TotalFreight
FROM dbo.Orders
	WHERE CustomerID = 71
GROUP BY CustomerID, YEAR(OrderDate);
GO
--------------------------------------------------------------------
  
/*
تمرین کلاسی
.فهرست 5 تا از مشتریان که بیشترین سفارش را داشته اند

CustomerID      Num
-----------    ----
  71            31
  20            30
  63            28
  24            19
  37            19

(5 rows affected)

*/
SELECT
	TOP 5 CustomerID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY CustomerID
ORDER BY Num DESC;
GO
--------------------------------------------------------------------

-- .نیامده باشد SELECT شرکت داده شود اما در بخش WHERE یک فیلد می‌تواند در بخش
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM dbo.Orders
	WHERE CustomerID < 50
GROUP BY EmployeeID;
GO

-- .نیامده باشد SELECT شرکت داده شود اما در بخش HAVING یک فیلد می‌تواند در بخش
SELECT
	EmployeeID,
	CustomerID
FROM dbo.Orders
GROUP BY EmployeeID, CustomerID
	HAVING COUNT(OrderID) > 5;
GO

-- یک فیلد در 2 نقش
SELECT
	C.City,
	COUNT(C.City) AS Num
FROM dbo.Customers AS C
GROUP BY C.City;
GO

-- GROUP BY عدم نیاز به
SELECT
	COUNT(C.City) AS Num
FROM dbo.Customers AS C
	WHERE C.State IN (N'یزد', N'کرمان');
GO

-- GROUP BY اجبار به استفاده از
SELECT
	C.CustomerID
FROM dbo.Customers AS C
GROUP BY C.CustomerID
	HAVING COUNT(C.State) > 0;
GO
--------------------------------------------------------------------

/*
GROUP BY ALL
.فیلتر شده‌اند WHERE نمایش نتایجی که در شرط
*/ 

SELECT 
	EmployeeID, 
	COUNT(OrderID) AS Num
FROM dbo.Orders
	WHERE EmployeeID BETWEEN 1 AND 3
GROUP BY ALL EmployeeID
ORDER BY EmployeeID;
GO

-- GROUP BY ALL بر روی HAVING تاثیر
SELECT 
	EmployeeID, 
	COUNT(OrderID) AS Num
FROM dbo.Orders
	WHERE EmployeeID BETWEEN 1 AND 3
GROUP BY ALL EmployeeID
	HAVING COUNT(OrderID) > 100
ORDER BY EmployeeID;
GO