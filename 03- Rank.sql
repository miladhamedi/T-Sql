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
RANK() OVER(ORDER BY Clause)
*/

/*Rank اعمال تابع*/
SELECT
	RANK() OVER(ORDER BY City) AS Ranking,
	CustomerID, City
FROM dbo.Customers;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

رنکینگ بر‌اساس بیشترین تعداد سفارش از هر شرکت

Ranking    CompanyName     Num
-------   -------------   ----
  1        شرکت IR- CS     31
  2        شرکت IR- AT     30
  3        شرکت IR- CK     28
  4        شرکت IR- AX     19
  4        شرکت IR- BK     19
  ...    		    
  87       شرکت IR- BG     2
  87       شرکت IR- BQ     2
  89       شرکت IR- AM     1

(89 rows affected)

*/

-- JOIN
SELECT
	RANK() OVER(ORDER BY COUNT(O.OrderID) DESC) AS Ranking,
	C.CompanyName,
	COUNT(O.OrderID) AS Num
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.CompanyName;
GO

-- Subquery
SELECT
	RANK() OVER(ORDER BY COUNT(O.OrderID) DESC) AS Ranking,
	(SELECT C.CompanyName FROM dbo.Customers AS C
		WHERE C.CustomerID = O.CustomerID) AS CompanyName,
	COUNT(O.OrderID) AS Num
FROM dbo.Orders AS O
GROUP BY O.CustomerID;
GO