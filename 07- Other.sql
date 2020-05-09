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
نکات تکمیلی در خصوص انواع عملیات دست‌کاری داده‌ها
*/


/*
DML روش‌های تشخیص داده‌های تاثیر پذیر قبل از عملیات

روش اول
جهت شناسایی رکوردها SELECT استفاده از دستور

روش دوم
Table Expression
*/

DROP TABLE IF EXISTS dbo.Odetails;
GO

SELECT * INTO dbo.Odetails FROM dbo.OrderDetails;
GO

UPDATE OD
	SET Discount += 0.05
FROM dbo.Odetails AS OD
	JOIN dbo.Orders AS O
		ON OD.OrderID = O.OrderID
	WHERE O.CustomerID = 1;
GO

-- CTE
WITH C AS
(
	SELECT
		o.CustomerID, OD.OrderID, Productid, Discount, Discount + 0.05 AS NewDiscount
	FROM dbo.Odetails AS OD
		JOIN dbo.Orders AS O
			ON OD.OrderID = O.OrderID
		WHERE O.CustomerID = 1
)
UPDATE C
	SET Discount = NewDiscount;
GO

-- Derived Table
UPDATE Tmp
	SET Discount = NewDiscount
FROM (SELECT
		CustomerID, OD.OrderID, Productid, Discount, Discount + 0.05 AS NewDiscount
	  FROM dbo.Odetails AS OD
		JOIN dbo.Orders AS O
			ON OD.OrderID = O.OrderID
		WHERE O.CustomerID = 1) AS Tmp;
GO
--------------------------------------------------------------------

/*
دست‌کاری داده‌های زیاد بر اساس دسته‌بندی

OFFSET و TOP عدم استفاده از قابلیت‌های
چرا که در عملیات دست‌کاری داده‌ها
.استفاده کرد ORDER BY نمی‌توان از
صرفا این عملیات براساس تعداد رکوردهایی که در 
.فرایند دست‌‌کاری تاثیر می‌پذیرند، انجام خواهد شد

Table Expression راه‌کار: استفاده از 
*/

DROP TABLE IF EXISTS dbo.Orders1;
GO

SELECT * INTO dbo.Orders1 FROM dbo.Orders;
GO

-- عملیات غیرمجاز
DELETE TOP(50) FROM dbo.Orders1
ORDER BY OrderID DESC;
GO

-- صرفا 50 رکورد حذف می‌شود
DELETE TOP(50) FROM dbo.Orders1;
GO

WITH CTE AS
(
	SELECT TOP(50) * FROM dbo.Orders1
	ORDER BY OrderID
)
DELETE FROM CTE;
GO

WITH CTE AS
(
	SELECT * FROM dbo.Orders1
	ORDER BY OrderID
	OFFSET 0 ROWS FETCH FIRST 50 ROWS ONLY
)
DELETE FROM CTE;
GO
