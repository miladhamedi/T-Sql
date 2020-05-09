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

-- مشاهده اسکیمای پیش‌فرض
SELECT SCHEMA_NAME();
GO

-- مشاهده فهرستی از اسکیماهای دیتابیس
SELECT * FROM SYS.schemas;
GO

-- بررسی جهت وجود اسکیما و حذف آن  
DROP SCHEMA IF EXISTS MySchema;
GO

-- نحوه ایجاد اسکیما
CREATE SCHEMA MySchema;
GO

DROP TABLE IF EXISTS MySchema.Tbl1;
GO

-- MySchema در اسکیمای Tbl1 ایجاد جدول
CREATE TABLE MySchema.Tbl1
(
	ID INT
);
GO

-- دسترسی به اسکیمای یک جدول
SELECT * FROM INFORMATION_SCHEMA.TABLES   /* تمامی اسکیماهای مرتبط با جداول یک دیتابیس */
	WHERE TABLE_NAME = 'Tbl1';
GO

-- عدم نوشتن نام اسکیما و خطا
SELECT * FROM Tbl1;
GO

-- MySchema.Tbl1 درج رکورد در جدول
INSERT INTO MySchema.Tbl1
	VALUES (1),(2),(3),(4),(5);
GO

-- MySchema.Tbl1 مشاهده رکوردهای جدول
SELECT * FROM MySchema.Tbl1;
GO

DROP TABLE IF EXISTS Tbl1;
GO

--  در اسکیمای پیش‌فرض Tbl1 ایجاد جدول
CREATE TABLE Tbl1
(
	ID INT
);
GO

-- Tbl1 درج رکورد در جدول
INSERT INTO Tbl1
	VALUES (100),(200),(300),(400),(500);
GO

-- Tbl1 مشاهده رکوردهای جدول
SELECT * FROM Tbl1;
SELECT * FROM dbo.Tbl1;
GO

-- MySchema.Tbl1 مشاهده رکوردهای جدول
SELECT * FROM MySchema.Tbl1;
GO

-- از دیتابیس Tbl1 حذف هر دو جدول
DROP TABLE IF EXISTS  MySchema.Tbl1,Tbl1;
GO