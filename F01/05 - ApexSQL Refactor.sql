--------------------------------------------------------------------
/*
SQL Server 2017 دوره آموزشی کوئری‌نویسی در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebori 
*/
--------------------------------------------------------------------

USE NikamoozDB2017;
GO

/*
Qualify object names
درج اسکیمای آبجکت
*/

SELECT * FROM Orders;
GO

SELECT
    OrderID, EmployeeID, CustomerID, OrderDate 
FROM Orders AS O;
GO
--------------------------------------------------------------------

/*
Wildcard expansion
تبدیل * به نام ستون‌های آبجکت
*/

SELECT * FROM Orders;
GO

SELECT * FROM Orders;
GO
--------------------------------------------------------------------

/*
Unused variables and parameters
تشخیص متغیرها و پارمترهای بی‌فایده
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
Encapsulate
تبدیل اسکریپت به یکی از آبجکت‌های زیر
SP, VIEW, Scalar Function, TVF
*/

SELECT
    OrderID, CustomerID, EmployeeID
FROM dbo.Orders
    WHERE OrderID BETWEEN @Min AND @Max; /*In new query window*/

--------------------------------------------------------------------

/*
Format SQL
تنظیمات مربوط به الگوی اسکریپت‌نویسی
.این قابلیت برای فایل حاوی اسکریپت و یا یک آبجکت هم امکان‌پذیر است
*/