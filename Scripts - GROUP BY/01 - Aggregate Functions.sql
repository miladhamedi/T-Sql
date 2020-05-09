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

-- بررسی وجود جدول و حذف آن
DROP TABLE IF EXISTS GroupTable;
GO

-- GroupTable ساخت جدول
CREATE TABLE GroupTable
(
	Score INT
);
GO

-- GroupTable درج رکورد در جدول
INSERT INTO GroupTable
	VALUES (2),(3),(4),(10);
GO

-- GroupTable ها بر روی جدول Aggregate Function مشاهده تاثیر
SELECT
	COUNT(Score) AS Num,
	SUM(Score) AS Total ,
	MAX(Score) AS MaxVal,
	MIN(Score) MinVal,
	Avg(Score * 1.0) AS Avrg -- توضیح داده شود
FROM GroupTable;
GO

-- GroupTable در جدول NULL درج مقدار
INSERT INTO GroupTable
	VALUES (NULL);
GO

SELECT * FROM GroupTable;
GO

-- .است NULL که حاوی رکوردی با مقدار  GroupTable ها بر روی جدول Aggregate Function مشاهده تاثیر
SELECT
	COUNT(Score) AS Num,
	SUM(Score) AS Total,
	MAX(Score) AS MaxVal,
	MIN(Score) MinVal,
	Avg(Score * 1.00) AS Avrg
FROM GroupTable;
GO

-- در خروجی COUNT(*) تاثیر
SELECT
	COUNT(Score) AS Num
FROM GroupTable;
GO

SELECT
	COUNT(*) AS Num
FROM GroupTable;
GO