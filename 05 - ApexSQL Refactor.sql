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
Qualify object names
درج اسکیمای آبجکت
*/

SELECT *
FROM Orders;
GO

SELECT OrderID, 
       EmployeeID, 
       CustomerID, 
       OrderDate
FROM Orders AS O;
GO
--------------------------------------------------------------------

/*
Wildcard expansion
تبدیل * به نام ستون‌های آبجکت
*/

SELECT Orders.OrderID, 
       Orders.CustomerID, 
       Orders.EmployeeID, 
       Orders.OrderDate, 
       Orders.ShipperID, 
       Orders.Freight
FROM Orders;
GO

SELECT O.OrderID, 
       O.CustomerID, 
       O.EmployeeID, 
       O.OrderDate, 
       O.ShipperID, 
       O.Freight
FROM dbo.Orders AS O;
GO
--------------------------------------------------------------------

/*
Unused variables and parameters
تشخیص متغیرها و پارمترهای استفاده‌نشده
*/

CREATE PROC Test_Procedure
    @Cid INT,
    @EID INT,
    @OD DATE
AS
    BEGIN
	   SELECT * FROM dbo.Orders
		  WHERE CustomerID = @Cid
			 AND OrderDate > @OD
    END
GO

DECLARE @Var1 INT;
DECLARE @Var INT = 1;
GO
--------------------------------------------------------------------

/*
Change Parameters
تغییر نام و نوع‌داده پارامتر
حذف و یا اضافه کردن پارامتر
*/

DROP FUNCTION IF EXISTS dbo.Top_Orders;
GO

CREATE FUNCTION dbo.Top_Orders(@CustID AS INT, @n AS TINYINT)
RETURNS TABLE
AS
RETURN
	SELECT
		TOP (@n) OrderID, CustomerID, OrderDate
	FROM dbo.Orders
		WHERE CustomerID = @CustID
	ORDER BY OrderDate DESC, OrderID DESC;
GO
--------------------------------------------------------------------

/*
Format SQL
تنظیمات مربوط به الگوی اسکریپت‌نویسی
.این قابلیت برای فایل حاوی اسکریپت و یا یک آبجکت هم امکان‌پذیر است
*/
SELECT OrderID, 
       OrderDate
FROM dbo.Orders
WHERE OrderID BETWEEN 1 AND 100;
GO
