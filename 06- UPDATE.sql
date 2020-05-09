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
UPDATE <table_name>
	SET column1 = value1,
		column2 = value2, ...
WHERE condition;
*/

DROP TABLE IF EXISTS dbo.Customers1;
GO

SELECT * INTO dbo.Customers1
FROM dbo.Customers;
GO

SELECT * FROM dbo.Customers1;
GO

UPDATE dbo.Customers1
	SET CompanyName = CompanyName + '*';
GO

SELECT * FROM dbo.Customers1;
GO

UPDATE dbo.Customers1
	SET CompanyName = REPLACE(CompanyName,'*','');
GO

SELECT * FROM dbo.Customers1;
GO

UPDATE dbo.Customers1
	SET Region = N'مرکزی'
		WHERE Region = N'مرکز';
GO

SELECT * FROM dbo.Customers1;
GO

-- .فاقد شرط، تمامی رکوردها را به‌روزرسانی می‌کند UPDATE عملیات
UPDATE dbo.Customers1
	SET City = N'فاقد شهر',
		Region = N'فاقد شهر';
GO

SELECT * FROM dbo.Customers1;
GO
--------------------------------------------------------------------

/*
UPDATE & JOIN
*/

SELECT * FROM dbo.Customers1 AS C
	JOIN dbo.Orders AS O
		ON C.CustomerID = O.CustomerID;
GO

UPDATE C
	SET CompanyName = CompanyName + '+'
FROM dbo.Customers1 AS C -- اشاره به نام مستعار
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID;
GO

SELECT * FROM dbo.Customers1;
GO

/*
تمرین کلاسی
Subquery بازنویسی کوئری بالا با استفاده از
*/
UPDATE dbo.Customers1
	SET CompanyName = CompanyName + '+'
	WHERE EXISTS(SELECT 1 FROM dbo.Orders AS O
					WHERE O.CustomerID = dbo.Customers1.CustomerID);
GO
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.UPDATE_Test;
GO

CREATE TABLE dbo.UPDATE_Test
(
	Col1 INT,
	Col2 INT
)
GO

INSERT INTO dbo.UPDATE_Test
	VALUES (1,100);
GO

SELECT * FROM dbo.UPDATE_Test;
GO

UPDATE dbo.UPDATE_Test
	SET Col1 = Col1 + 10,
		Col2 = Col1 + 10;
GO

SELECT * FROM dbo.UPDATE_Test;
GO

DELETE FROM dbo.UPDATE_Test;
GO

INSERT INTO dbo.UPDATE_Test
	VALUES (1,100);
GO

SELECT * FROM dbo.UPDATE_Test;
GO

-- جابه‌جایی مقادیر ستون‌ها
UPDATE dbo.UPDATE_Test
	SET Col1 = Col2,
		Col2 = Col1;
GO

SELECT * FROM dbo.UPDATE_Test;
GO