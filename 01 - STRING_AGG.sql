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
STRING_AGG ( expression, separator [ <order_clause> ] )
<order_clause> ::=   
    WITHIN GROUP ( ORDER BY <order_by_expression_list> [ ASC | DESC ] ) 
*/

DROP TABLE IF EXISTS dbo.City,dbo.States;
GO

CREATE TABLE dbo.States
(
	StateID INT IDENTITY PRIMARY KEY,
	StateName NVARCHAR(50)
);
GO

INSERT INTO dbo.States
    VALUES (N'تهران'),(N'اصفهان'),(N'خراسان رضوی');
GO

CREATE TABLE dbo.City
(
	StateID INT FOREIGN KEY REFERENCES dbo.States(StateID),
	CityName NVARCHAR(100)
);
GO

INSERT INTO dbo.City 
    VALUES (1,N'تهران'),(1,N'پردیس'),(1,N'شهریار'),(1,N'ورامین'),
	       (2,N'اصفهان'),(2,N'کاشان'),
		   (3,N'مشهد'),(3,N'نیشابور'),(3,N'سبزوار');
GO

-- JOIN لیست شهرهای هر استان با روش
SELECT
	S.StateId,
	S.StateName,
	STRING_AGG (C.CityName, ',') AS City 
FROM dbo.States AS S       
INNER JOIN dbo.City AS C 
	ON S.StateId = C.StateId 
GROUP BY S.StateId, S.StateName;
GO

-- Subquery لیست شهرهای هر استان با روش
SELECT
	S.StateId,
	S.StateName,
	(SELECT STRING_AGG (C.CityName, ',') FROM dbo.City AS C
		WHERE S.StateId = C.StateId ) AS City 
FROM dbo.States AS S       
GROUP BY S.StateId, S.StateName;
GO

-- مرتب‌سازی بر اساس لیست شهرهای هر استان   
SELECT
	S.StateId,
	S.StateName,
	STRING_AGG (C.CityName, ',') WITHIN GROUP (ORDER BY C.CityName) AS City 
FROM dbo.States AS S       
INNER JOIN dbo.City AS C 
	ON S.StateId = C.StateId 
GROUP BY S.StateId, S.StateName;
GO