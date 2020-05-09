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
OUTPUT مروری بر
*/

USE NikamoozDB;
GO

DROP TABLE IF EXISTS dbo.Persons;
GO

CREATE TABLE dbo.Persons
(
	Code INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
)
GO

--INSERT
INSERT INTO dbo.Persons(Code, FirstName) 
	OUTPUT inserted.*	
VALUES (1,N'مهدی');
GO

INSERT INTO dbo.Persons(Code, FirstName, LastName) 
	OUTPUT inserted.*	
VALUES (2,N'امید',N'سعادتی');
GO

--UPDATE
UPDATE dbo.Persons
	SET LastName = N'احمدی' 
	OUTPUT 
		deleted.Code AS [Old_Code],
		deleted.FirstName AS [Old_FirstName],
		deleted.LastName AS [Old_LastName],
		inserted.Code AS [New_Code],
		inserted.FirstName AS [New_FirstName],
		inserted.LastName AS [New_LastName]
WHERE Code = 1;
GO

--DELETE
DELETE FROM dbo.Persons 
	OUTPUT deleted.*	
WHERE Code = 2;
GO

--نمایش رکوردهای جدول
SELECT * FROM dbo.Persons
GO
--------------------------------------------------------------------

/*
CREATE TRIGGER [ schema_name . ]trigger_name   
ON { table | view }   
{ AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] }   
AS { sql_statement  [ ; ] [ ,...n ] }  
*/

DROP TABLE IF EXISTS dbo.Persons;
GO

CREATE TABLE dbo.Persons
(
	Code INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
)
GO

DROP TRIGGER IF EXISTS InsertTrg_Persons;
GO

/*
dbo.Persons بر روی جدول AFTER ایجاد یک تریگر از نوع
*/
CREATE TRIGGER InsertTrg_Persons ON dbo.Persons
AFTER INSERT
AS
	SELECT * FROM inserted;
GO

--مشاهده اطلاعاتی درباره تریگرها
SP_HELPTRIGGER 'dbo.Persons';
SELECT * FROM SYS.triggers;
GO

--تریگر Source مشاهده
SP_HELPTEXT 'InsertTrg_Persons';
GO

INSERT INTO dbo.Persons
	VALUES (1,N'مهدی',N'احمدی'),
		   (2,N'امید',N'سعادتی');
GO

SELECT * FROM dbo.Persons;
GO

-- تغییر تریگر
ALTER TRIGGER InsertTrg_Persons ON dbo.Persons
AFTER INSERT, UPDATE, DELETE
AS
	ROLLBACK TRANSACTION;
GO

INSERT INTO dbo.Persons
	VALUES (1,N'سعید',N'پرتوی');
GO

DELETE FROM dbo.Persons;
GO

UPDATE dbo.Persons
	SET Code = 100
		WHERE Code = 1;
GO

SELECT * FROM dbo.Persons;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
.ایجاد کنید Customers ابتدا یک نمونه کپی از جدول

تریگری ایجاد کنید dbo.Customers2 اکنون بر روی جدول
.که از حذف مشتریانی که بیش از 10 سفارش داشته‌اند جلوگیری کند
*/

DROP TABLE IF EXISTS dbo.Customers2;
GO

SELECT * INTO dbo.Customers2 FROM dbo.Customers;
GO

DROP TRIGGER IF EXISTS dbo.Customers_Trg;
GO

CREATE TRIGGER dbo.Customers_Trg ON dbo.Customers2
AFTER DELETE
AS
    DECLARE @C_ID INT
    SELECT @C_ID = CustomerID FROM deleted -- تشخیص مشتری
    IF (SELECT COUNT(OrderID) FROM dbo.Orders WHERE CustomerID = @C_ID) > 10
	   BEGIN
		  PRINT N'!امکان حذف این مشتری وجود ندارد'
		  ROLLBACK TRAN --لغو عمليات
	    END
GO

SELECT
    CustomerID, COUNT(OrderID) AS Num
FROM dbo.Orders
GROUP BY CustomerID;
GO

DELETE dbo.Customers2
    WHERE  CustomerID = 4;
GO

DELETE dbo.Customers2
    WHERE  CustomerID = 1;
GO

SELECT * FROM dbo.Customers2
ORDER BY CustomerID;
GO
--------------------------------------------------------------------

/*
.یکی از کاربردهای تریگر ذخیره سوابق تغییرات رکوردها است
*/

DROP TABLE IF EXISTS dbo.Persons, dbo.History_Persons;
GO

CREATE TABLE dbo.Persons
(
	Code INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50)
)
GO

CREATE TABLE dbo.History_Persons
(
	Code INT,
	FirstName NVARCHAR(50),
	LastName NVARCHAR(50),
	Action_Type VARCHAR(10),
	Action_Date DATE
)
GO

DROP TRIGGER IF EXISTS Trg_Persons_Insert, Trg_Persons_Update, Trg_Persons_Delete;
GO

/*
Insert ایجاد تریگر برای حالت
*/
CREATE TRIGGER Trg_Persons_Insert ON dbo.Persons
AFTER INSERT
AS
INSERT INTO dbo.History_Persons(Code,FirstName,LastName,Action_Type,Action_Date)
	SELECT
		Code, FirstName, LastName, 'Insert', GETDATE()
	FROM inserted
GO

/*
Update ایجاد تریگر برای حالت
*/
CREATE TRIGGER Trg_Persons_Update ON dbo.Persons
AFTER UPDATE
AS
--مقدار قبل از به‌روزرسانی
INSERT INTO dbo.History_Persons(Code,FirstName,LastName,Action_Type,Action_Date)
	SELECT
		Code, FirstName, LastName, 'Old_Value', GETDATE()
	FROM deleted
--مقدار پس از به‌روزرسانی
INSERT INTO dbo.History_Persons(Code,FirstName,LastName,Action_Type,Action_Date)
	SELECT
		Code, FirstName, LastName, 'New_Value', GETDATE()
	FROM inserted
GO

/*
Delete ایجاد تریگر برای حالت
*/
CREATE TRIGGER Trg_Persons_Delete ON dbo.Persons
AFTER DELETE
AS
INSERT INTO dbo.History_Persons(Code,FirstName,LastName,Action_Type,Action_Date)
	SELECT
		Code, FirstName, LastName, 'Delete', GETDATE()
	FROM deleted
GO

-- dbo.Persons درج رکورد در جدول
INSERT INTO dbo.Persons
	VALUES (1,N'مهدی',N'احمدی'),
	       (2,N'امید',N'سعادتی'),
		   (3,N'سپیده',N'کریمی');
GO

-- مشاهده رکوردهای جدول اصلی و جدول سوابق آن
SELECT * FROM dbo.Persons;
SELECT * FROM History_Persons;
GO

-- dbo.Persons به‌روزرسانی رکورد در جدول
UPDATE dbo.Persons
	SET Code = 100
		WHERE Code = 1;
GO

-- مشاهده رکوردهای جدول اصلی و جدول سوابق آن
SELECT * FROM dbo.Persons;
SELECT * FROM History_Persons;
GO

-- dbo.Persons حذف رکورد از جدول
DELETE FROM dbo.Persons
	WHERE Code = 100;
GO

-- مشاهده رکوردهای جدول اصلی و جدول سوابق آن
SELECT * FROM dbo.Persons;
SELECT * FROM History_Persons;
GO
--------------------------------------------------------------------

/*
CONTEXT_INFO
*/
SELECT 
	session_id,host_name,
	program_name,context_info 
FROM sys.dm_exec_sessions
	WHERE session_id >= 51;
GO

-- SQL Server 2016 تا قبل از Session_Context روش قدیمی برای تنظیم
DECLARE @Ctx VARBINARY(128);
SELECT @Ctx = CAST(N'User01, Tehran' AS VARBINARY(128));
SET CONTEXT_INFO @Ctx;
GO

SELECT CONTEXT_INFO();
GO

-- Session_Context مشاهده محتوای
SELECT CAST(CONTEXT_INFO() AS NVARCHAR(128));
GO

-- به‌بعد SQL Server 2016 از Session_Context روش جدید برای تنظیم
DECLARE @ID INT = 123456;
DECLARE @FullName NVARCHAR(128) = N'علی بهبودی';
EXEC sys.sp_set_session_context @key = N'ID', @value = @ID;
EXEC sys.sp_set_session_context @key = N'FullName', @value = @FullName;
GO

SELECT SESSION_CONTEXT(N'ID'),SESSION_CONTEXT(N'FullName');
GO
--------------------------------------------------------------------

/*
Persons می‌خواهیم در جدول سوابق مربوط به جدول
کاربری Bussines User فیلدی را اضافه کنیم که نام
.را که باعث حذف رکوردها می‌شود، ثبت کند
*/

ALTER TABLE dbo.History_Persons
	ADD Users NVARCHAR(100);
GO

SELECT * FROM dbo.History_Persons;
GO

DECLARE @FullName NVARCHAR(100) = N'علی بهبودی';
EXEC sys.sp_set_session_context @key = N'FullName', @value = @FullName;
GO

-- ایجاد تغییر در تریگر حذف رکوردها
ALTER TRIGGER Trg_Persons_Delete ON dbo.Persons
AFTER DELETE
AS
    INSERT INTO dbo.History_Persons(Code,FirstName,LastName,Action_Type,Action_Date,Users)
	   SELECT
		  Code, FirstName, LastName, 'Delete', 
		  GETDATE(), CAST(SESSION_CONTEXT(N'FullName') AS NVARCHAR(100))
	   FROM deleted;
GO

DELETE FROM dbo.Persons
	WHERE Code = 2;
GO

SELECT * FROM dbo.Persons;
SELECT * FROM dbo.History_Persons;
GO