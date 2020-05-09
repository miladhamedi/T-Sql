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
 
-- نمایش تمامی سفارشات مشتریان
SELECT
	CustomerID, OrderID
FROM dbo.Orders
ORDER BY CustomerID;
GO
--------------------------------------------------------------------

/*
 گروه‌بندی تک سطحی
*/

-- تعداد سفارش هر مشتری
-- GROUP BY Columns: CustomerID
-- Aggregate Columns: OrderID
SELECT
	CustomerID, COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY CustomerID;
GO

-- تعداد سفارش هر مشتری و جدیدترین سفارشش
-- GROUP BY Columns: CustomerID
-- Aggregate Columns: OrderID/OrderDate
SELECT
	CustomerID,
	COUNT(OrderID) AS Num,
	MAX(OrderDate) AS NewOrder
FROM dbo.Orders
GROUP BY CustomerID;
GO
--------------------------------------------------------------------

/*
گروه‌بندی چند سطحی
*/
-- از هر استان-شهر چه تعداد مشتری داریم
-- GROUP BY Columns: State/City
-- Aggregate Columns: CustomerID
SELECT
	State, City,
	COUNT(CustomerID) AS Num
FROM dbo.Customers
GROUP BY State, City;
GO
--------------------------------------------------------------------

/*تمرین کلاسی
سفارشات هر کارمند به تفکیک هر سال که شامل تعداد کل سفارش و مجموع کرایه‌های ثبت شده

EmployeeID   OrderYear   Num     Rate	    
----------   ----------  ----  -------- 
  1            2014       26    1871.04  
  1            2015       55    4584.47  
  1            2016       42    2381.13  
  ...			  		  		  		    
  9            2014       5     532.84   
  9            2015       19    1046.09  
  9            2016       19    1747.33  

(27 rows affected)

*/

SELECT
	EmployeeID, YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num,
	SUM(Freight) AS Rate
FROM dbo.Orders
GROUP BY EmployeeID, YEAR(OrderDate);
GO

