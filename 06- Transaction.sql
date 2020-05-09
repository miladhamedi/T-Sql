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
Auto Commit Transaction 
*/

DROP TABLE IF EXISTS dbo.Transact;
GO

CREATE TABLE dbo.Transact
(
	ID TINYINT,
	Family NVARCHAR(50)
);
GO

INSERT INTO dbo.Transact
	VALUES (1,N'پویا');
GO

SELECT * FROM sys.fn_dblog(NULL, NULL)
WHERE PartitionId IN
(
	SELECT partition_id FROM sys.partitions
	WHERE object_id = OBJECT_ID('Transact')
)
GO

SELECT * FROM sys.fn_dblog(NULL, NULL)
	WHERE [Transaction ID]='0000:0001a4d7'
GO

SELECT * FROM dbo.Transact;
GO

INSERT INTO dbo.Transact
	VALUES (2,N'تقوی'),(300,N'کریمی'),(4,N'محمدی');
GO

SELECT * FROM dbo.Transact;
GO
--------------------------------------------------------------------

/*
Explicit Transaction
*/

BEGIN TRAN -- BEGIN TRANSACTION
UPDATE dbo.Customers
	SET City = N'طهران'
		WHERE City = N'تهران';
COMMIT; -- COMMIT TRANSACTION یا COMMIT TRANS
GO

SELECT * FROM dbo.Customers
	WHERE City = N'طهران';
GO

BEGIN TRAN
UPDATE dbo.Customers
	SET City = N'تهران'
		WHERE City = N'طهران';
ROLLBACK;
GO

SELECT * FROM dbo.Customers
	WHERE City = N'طهران';
GO

BEGIN TRAN
UPDATE dbo.Customers
	SET City = N'تهران'
		WHERE City = N'طهران';
COMMIT;
GO

SELECT * FROM dbo.Customers
	WHERE City = N'تهران';
GO