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

-- جهت تعیین ستون‌های دلخواه در کوئری SELECT عدم استفاده از متغیر در بخش
DECLARE @Col VARCHAR(50) = 'CustomerID';
SELECT @Col FROM dbo.Customers;
GO

-- جهت تعیین ستون‌ دلخواه جهت اعمال شرط WHERE عدم استفاده از متغیر در بخش
DECLARE @Col VARCHAR(50) = 'CustomerID';
SELECT * FROM dbo.Customers
	WHERE @Col > 80;
GO
--------------------------------------------------------------------

/*
EXEC یا EXECUTE
قابلیت استفاده با رشته‌های یونیکدی و غیر‌یونیکدی
*/

DECLARE @Col VARCHAR(50) = 'CustomerID';
DECLARE @Sql VARCHAR(200) = 'SELECT ' + @Col +' FROM dbo.Customers';
--PRINT @Sql
EXEC (@Sql); -- !پرانتز‌گذاری فراموش نشود
GO

DECLARE @City NVARCHAR(20) = N'تهران';
DECLARE @Sql NVARCHAR(200) = 'SELECT * FROM dbo.Customers WHERE City = N''' + @City +'''';
--PRINT @Sql
EXEC (@Sql); -- !پرانتز‌گذاری فراموش نشود
GO
--------------------------------------------------------------------

/*
sp_executesql
قابلیت استفاده فقط با رشته‌های یونیکدی
:فقط یکی از انواع‌داده زیر با این روش قابل استفاده است
NTEXT/NCHAR/NVARCHAR
*/

DECLARE @Col NVARCHAR(50) = 'CustomerID';
DECLARE @Sql NVARCHAR(200) = 'SELECT ' + @Col +' FROM dbo.Customers';
--PRINT @Sql;
EXEC sp_executesql @Sql;
GO

-- معادل کوئری بالا
EXEC sp_executesql N'SELECT CustomerID FROM dbo.Customers';
GO

-- !غلط است
EXEC sp_executesql 'SELECT @@VERSION'
GO

-- اصلاح کوئری بالا
EXEC sp_executesql N'SELECT @@VERSION'
GO

-- روش اول پارامتری
EXEC sp_executesql N'SELECT * FROM dbo.Orders WHERE CustomerID = @Customerid',
	N'@Customerid INT', @Customerid = 80;
GO

EXEC sp_executesql N'SELECT * FROM dbo.Orders WHERE OrderID = @OrderID AND CustomerID = @Customerid',
	N'@OrderID INT, @Customerid INT', @OrderID=10249 ,@Customerid=79;
GO

-- روش دوم پارامتری
DECLARE @Sql AS NVARCHAR(100);
SET @Sql = N'SELECT OrderID, CustomerID, EmployeeID, Orderdate FROM dbo.Orders
				WHERE OrderID = @OrderID ;';
EXEC sp_executesql
	@stmt = @sql,
	@params = N'@OrderID AS INT',
	@OrderID = 10250;
GO -- ترتیب پارامترها مهم است

-- ???
DECLARE @Sql AS NVARCHAR(100); /*DECLARE @Sql AS NVARCHAR(200)*/
SET @Sql = N'SELECT OrderID, CustomerID, EmployeeID, Orderdate FROM dbo.Orders
				WHERE OrderID BETWEEN @Min AND @Max';
EXEC sp_executesql
	@stmt = @Sql,
	@params = N'@Min AS INT, @MAX AS INT',
	@Min= 10248, @Max= 10250;
GO
