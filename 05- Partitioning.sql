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
Ranking_Function_Name() OVER (<partition_by_clause> <order_by_clause>)
*/

USE NikamoozDB;
GO

SELECT
	ROW_NUMBER() OVER(ORDER BY City) AS Ranking,
	CustomerID,
	City
FROM dbo.Customers;
GO

/*
ORDER BY ابتدا گروه‌بندی انجام می‌شود و سپس بر‌اساس فیلد جلو 
.مرتب‌سازی به‌ازای هر گروه و متناسب با تابع آن انجام می‌شود
*/
SELECT
	ROW_NUMBER() OVER(PARTITION BY City ORDER BY CustomerID) AS Ranking,
	CustomerID,
	City
FROM dbo.Customers;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

.تمامی محصولات بر‌اساس نوع کالا، دسته‌بندی شده و رتبه‌بندی براساس قیمت واحد و صعودی باشد

Ranking   ProductID   CategoryID  UnitPrice  ProductName
--------  ----------  ----------  ---------  --------------
  1         24          1           4.50       نوشابه رژیمی
  2         75          1           7.75       آب انگور
  3         67          1           14.00      آب آناناس
  3         34          1           14.00      ماءالشعیر
  4         70          1           15.00      آب انبه
  5         39          1           18.00      آب میوه طبیعی
  5         35          1           18.00      نکتار
  5         1           1           18.00      آب پرتقال
  5         76          1           18.00      آب سیب
  6         2           1           19.00      نوشابه گازدار
  7         43          1           46.00      آب میوه رژیمی
  8         38          1           263.50     آب میوه گازدار
  ...	  			  		   		   
  1         13          8           6.00       کالاماری
  2         45          8           9.50       ماهی قزل آلا
  3         41          8           9.65       ماهی سنگسر
  4         46          8           12.00      ماهی شیر
  5         58          8           13.25      ماهی حلوا
  6         73          8           15.00      ماهی سلمون
  7         40          8           18.40      ماهی کیلکا
  8         36          8           19.00      ماهی حلوا سیاه
  9         30          8           25.89      ماهی زبیدی
  10        37          8           26.00      ماهی حلوا سفید
  11        10          8           31.00      میگو
  12        18          8           62.50      ماهی سوف

(77 rows affected)

*/
SELECT
	DENSE_RANK() OVER(PARTITION BY CategoryID ORDER BY UnitPrice) AS Ranking,
	ProductID,CategoryID,UnitPrice,ProductName
FROM dbo.Products;
GO
--------------------------------------------------------------------

/*
Window_Aggregate_Function_Name(Aggregate Column) OVER(<partition_by_clause>)  
*/


SELECT * FROM dbo.Products
ORDER BY CategoryID;
GO

/*
Category بیشترین و کمترین قیمت از هر
*/

-- Query1
SELECT
	CategoryID, 
	ProductName,
	MIN(UnitPrice) AS MIN_Price,
	MAX(UnitPrice) AS MAX_Price
FROM dbo.products
GROUP BY CategoryID, ProductName
ORDER BY CategoryID;
GO

-- Subquery به‌روش Query1 رفع مشکل
SELECT
	CategoryID,
	ProductName,
	(SELECT MIN(UnitPrice) FROM Products P2
		WHERE p2.CategoryID = P1.CategoryID) AS MIN_Price,
	(SELECT MAX(UnitPrice) FROM Products P2
		WHERE p2.CategoryID = P1.CategoryID) AS MAX_Price
FROM dbo.Products AS P1
ORDER BY Categoryid;
GO

-- Partitioning به‌روش Query1 رفع مشکل
SELECT
	CategoryID,
	ProductName,
	MIN(UnitPrice) OVER(PARTITION BY CategoryID) AS MIN_Price,
	MAX(UnitPrice) OVER(PARTITION BY CategoryID) AS MAX_Price
FROM dbo.Products;
GO
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.TestTable;
GO

CREATE TABLE dbo.TestTable (ID INT , Val INT)
GO

--درج تعدادی رکورد تستی در جدول
INSERT INTO dbo.TestTable (ID, Val)
	VALUES (1,10),(2,20),(3,30),(4,40),(5,50),(6,60),(7,70);
GO

--مشاهده رکوردهای تستی درج شده در جدول
SELECT
    ID, Val FROM dbo.TestTable
GO

/*
Running Total

 ID    Value   RunningTotal
----  ------  -------------
 1      10        10
 2      20        30
 3      30        60
 4      40        100
 5      50        150
 6      60        210
 7      70        280

(7 row(s) affected)

*/


SELECT
	T1.ID, T1.Val, SUM(T2.Val) AS RunningTotal
FROM dbo.TestTable AS T1
JOIN dbo.TestTable AS T2
	ON T2.ID <= T1.ID
GROUP BY T1.ID, T1.Val;
GO

SELECT 
	ID, Val, (SELECT SUM(Val) FROM dbo.TestTable T2
				WHERE T2.ID <= T1.ID) AS RunningTotal
FROM dbo.TestTable AS T1
GO

-- !!!به‌بعد قابل اجرا است SQL 2012 این کوئری در
SELECT 
	ID, Val,
	SUM(Val) OVER(ORDER BY ID) AS RunningTotal -- (ROWS | RANGE UNBOUNDED PRECEDING AND CURRENT ROW)
FROM dbo.TestTable;
GO

-- TestTable_ID جدول ID ایندکس‌گذاری بر روی فیلد
CREATE CLUSTERED INDEX TestTable_ID ON dbo.TestTable (ID);
GO

/*
مقایسه 3 کوئری بالا پس از ایندکس‌گذاری
*/

SELECT
	T1.ID, T1.Val, SUM(T2.Val)
FROM dbo.TestTable AS T1
	JOIN dbo.TestTable AS T2
		ON T2.ID <= T1.ID
GROUP BY T1.ID, T1.Val;
GO

SELECT 
	ID, Val, (SELECT SUM(Val) FROM dbo.TestTable T2
				WHERE T2.ID <= T1.ID) AS RunningTotal
FROM dbo.TestTable T1
GO

SELECT 
	ID, Val, SUM(Val) OVER(ORDER BY ID) AS RunningTotal
FROM dbo.TestTable;
GO