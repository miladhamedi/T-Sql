--------------------------------------------------------------------
/*
SQL Server 2019 دوره آموزشی کوئری‌نویسی در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebori 
*/
--------------------------------------------------------------------

/*
TVP: Table Value Parameter
*/

USE NikamoozDB;
GO

DROP TABLE IF EXISTS dbo.Std, dbo.Std_Lessons;
GO

CREATE TABLE dbo.Std
(
	Code INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
);
GO

CREATE TABLE dbo.Std_Lessons
(
	Code INT,
	Lesson_Code INT,
	Lesson_Name NVARCHAR(50)
);
GO

DROP TYPE IF EXISTS dbo.Std_LessonsType;
GO

CREATE TYPE dbo.Std_LessonsType AS TABLE
(
   Code INT,
   Lesson_Code INT,
   Lesson_Name NVARCHAR(50)
)
GO

DROP PROC IF EXISTS Insert_Std_Lesson;
GO

CREATE PROC Insert_Std_Lesson 
(
	@Code INT,
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@T dbo.Std_LessonsType READONLY
)
AS
BEGIN
	INSERT INTO dbo.Std (Code, FirstName ,LastName)
		VALUES (@Code, @FirstName, @LastName)

	INSERT INTO dbo.Std_Lessons (Code, Lesson_Code, Lesson_Name)
		SELECT Code,Lesson_Code,Lesson_Name FROM @T
END
GO

--تست برای درج دیتا
DECLARE @Code INT = 1;
DECLARE @FirstName NVARCHAR(50) = N'پریسا';
DECLARE @LastName NVARCHAR(50) = N'فاطمی';
DECLARE @T AS dbo.Std_LessonsType;
INSERT @T  
    VALUES (1, 100, N'فیزیک'), 
		 (1, 200, N'شیمی'), 
		 (1, 300, N'هندسه'), 
		 (1, 400, N'زبان'), 
		 (1, 500, N'ادبیات');
EXEC Insert_Std_Lesson @Code, @FirstName, @LastName, @T;
GO

SELECT * FROM dbo.Std;
SELECT * FROM dbO.Std_Lessons;
GO

