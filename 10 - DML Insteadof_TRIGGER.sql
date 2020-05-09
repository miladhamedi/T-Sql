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
INSTEAD OF TRIGGER
*/

USE NikamoozDB;
GO

DROP TABLE IF EXISTS dbo.Valid_Persons, dbo.InValid_Persons;
GO

CREATE TABLE dbo.Valid_Persons
(
	Code INT,
	LastName NVARCHAR(50),
	Age TINYINT
)
GO

CREATE TABLE dbo.InValid_Persons
(
	Code INT,
	LastName NVARCHAR(50),
	Age TINYINT
)
GO

DROP TRIGGER IF EXISTS Valid_InsertTrigger;
GO

CREATE TRIGGER Valid_InsertTrigger ON dbo.Valid_Persons
INSTEAD OF INSERT
AS
	DECLARE @Age TINYINT;
	SELECT @Age = Age FROM inserted;
	IF @Age < 50
		INSERT INTO dbo.Valid_Persons
		SELECT * FROM inserted;
	ELSE
		INSERT INTO dbo.InValid_Persons
		SELECT * FROM inserted;
GO

INSERT dbo.Valid_Persons (Code,LastName,Age)
	VALUES(1,N'احمد',58);
GO

INSERT dbo.Valid_Persons (Code,LastName,Age)
	VALUES (2,N'سهیل',20);
GO

SELECT * FROM dbo.Valid_Persons;
SELECT * FROM dbo.InValid_Persons;
GO