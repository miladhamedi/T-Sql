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
Inline Table-Value FUNCTION
*/

--CREATE FUNCTION Statement (Inline Table Valued Function)
-- Parameterized View
/*
CREATE FUNCTION  function_name 
    ( [ { @parameter_name [AS] scalar_parameter_data_type [ = default ] } [ ,...n ] ] ) 
RETURNS TABLE 
[ WITH < function_option > [ [,] ...n ] ] 
[ AS ] 
RETURN [ ( ] select-stmt [ ) ] 
*/

DROP VIEW IF EXISTS dbo.Customers_Info;
GO

--.ای كه اطلاعات شرکت و سفارش‌هاي مشتريان را نمايش مي‌دهد VIEW ایجاد
CREATE VIEW dbo.Customers_Info
AS
	SELECT
		C.CompanyName, C.City ,O.OrderID, O.OrderDate    
	FROM dbo.Customers AS C
	JOIN dbo.Orders AS O
		ON C.CustomerID=O.CustomerID; 
GO

--نمايش سفارش هاي مشتريان تهرانی
SELECT * FROM dbo.Customers_Info
	WHERE City= N'تهران';
GO

/*
Inline Table Valued Function
FUNCTION بالا با استفاده از VIEW ایجاد
*/

DROP FUNCTION IF EXISTS dbo.Func_Customers_Info;
GO

CREATE FUNCTION dbo.Func_Customers_Info (@City NVARCHAR(50))
RETURNS TABLE
AS
RETURN
	SELECT
		C.CompanyName, C.City ,O.OrderID, O.OrderDate    
	FROM dbo.Customers AS C
	JOIN dbo.Orders AS O
		ON C.CustomerID=O.CustomerID
		WHERE C.City = @City;
GO

-- فراخوانی تابع
SELECT * FROM Func_Customers_Info(N'تهران');
GO

/*
JOIN مشاهده جزئیات سفارش کارمندان از طریق
OrderDetails با جدول Func_Customers_Info میان تابع
*/
SELECT * FROM dbo.Func_Customers_Info (N'تهران') AS F
JOIN dbo.OrderDetails AS OD
	ON F.OrderID = OD.OrderID;
GO
--------------------------------------------------------------------

--تمرین کلاسی

/*
.تابعی بنویسید که تعداد مشخصی از جدیدترین سفارش یک مشتری را نمایش دهد
پارامترهای ورودی: کد مشتری - عدد مربوط به تعداد سفارشات جدید

OrderID   CustomerID            OrderDate
-------   -----------    -----------------------
 11011       1            2016-04-09 00:00:00.000
 10952       1            2016-03-16 00:00:00.000
 10835       1            2016-01-15 00:00:00.000
 10702       1            2015-10-13 00:00:00.000
 10692       1            2015-10-03 00:00:00.000

(5 row(s) affected)
*/

DROP FUNCTION IF EXISTS dbo.Top_Orders;
GO

-- ایجاد تابع
CREATE FUNCTION dbo.Top_Orders (@Cust_ID INT, @Num INT)
RETURNS TABLE
AS
RETURN
	SELECT
		TOP (@Num) OrderID,
		CustomerID,
		OrderDate
	FROM dbo.Orders
		WHERE CustomerID = @Cust_ID
	ORDER BY OrderDate DESC;
GO

-- فراخوانی تابع
SELECT * FROM dbo.Top_Orders(1,5);
GO