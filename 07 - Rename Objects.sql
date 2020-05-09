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

USE master;
GO

DROP DATABASE IF EXISTS Test;
GO

CREATE DATABASE	Test;
GO

USE Test;
GO

DROP TABLE IF EXISTS dbo.Lesson_STD;
DROP TABLE IF EXISTS dbo.Lesson;
DROP TABLE IF EXISTS dbo.STD;
GO

-- ایجاد جدول دانشجو
CREATE TABLE dbo.STD
(
    ID VARCHAR(10) PRIMARY KEY,
    Family NVARCHAR(100),
    City NVARCHAR(50)
);
GO

-- جدول درس
CREATE TABLE dbo.Lesson
(
    Code INT PRIMARY KEY,
    Title NVARCHAR(50)
);
GO

-- جدول درس-دانشجو
CREATE TABLE dbo.Lesson_STD
(
    Row_ID INT IDENTITY,
    ID VARCHAR(10) REFERENCES STD(ID),
    Code INT REFERENCES Lesson(Code),
    Date_Reg DATE DEFAULT GETDATE(),
);
GO

-- درج رکورد در جدول دانشجو
INSERT INTO dbo.STD (ID,Family,City)
    VALUES ('96-01',N'احمدی', N'تهران'),
		 ('96-02',N'سعادت', N'اصفهان'),
		 ('96-03',N'پرتوی', N'شیراز');
GO

-- درج رکورد در جدول درس
INSERT INTO dbo.Lesson (Code,Title)
    VALUES (1,N'فیزیک'),(2,N'هندسه'),(3,N'زبان'),
		 (4,N'شیمی'),(5,N'ادبیات');
GO

-- درج رکورد در جدول درس-دانشجو
INSERT INTO dbo.Lesson_STD (ID,Code)
    VALUES ('96-01',1),('96-01',2),('96-01',5),
		 ('96-02',2),('96-02',4),
		 ('96-03',3);
GO

CREATE VIEW dbo.Students_List
AS
    SELECT * FROM STD;
GO

CREATE PROC Students_Lessons
    @ID VARCHAR(10)
AS
    BEGIN
	   SELECT * FROM STD AS S
		  WHERE EXISTS (SELECT 1 FROM Lesson_STD AS LS
						  WHERE S.ID = LS.id)
			 AND S.ID = @ID;
    END
GO

 