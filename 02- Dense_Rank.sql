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
DENSE_RANK() OVER(ORDER BY Clause)
*/

/*Dense_Rank اعمال تابع*/
SELECT
	DENSE_RANK() OVER(ORDER BY City) AS Ranking,
	CustomerID, City
FROM dbo.Customers;
GO

/*.است Row_Number بر روی مقادیر منحصر به‌فرد همانند استفاده از تابع*/
SELECT
	DENSE_RANK() OVER(ORDER BY CustomerID) AS Ranking,
	CustomerID, City
FROM dbo.Customers;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

Row_Num  Ranking  CustomerID   City
-------  -------  ----------  -------
 1        1        31          اردبیل
 2        1        48          اردبیل
 3        1        66          اردبیل
 4        2        60          ارومیه
 5        2        24          ارومیه
 ...	    		 			 
 87       28       41          یزد
 88       28       25          یزد
 89       28       7           یزد
 90       28       77          یزد
 91       28       90          یزد

(91 row(s) affected)
*/
SELECT
	ROW_NUMBER() OVER(ORDER BY City) AS City,
	DENSE_RANK() OVER(ORDER BY City) AS Ranking,
	CustomerID, City
FROM dbo.Customers;
GO