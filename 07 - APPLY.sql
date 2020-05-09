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

SELECT
	E1.EmployeeID AS E1_Emp, E2.EmployeeID AS E2_Emp
FROM dbo.Employees AS E1
CROSS APPLY
	 dbo.Employees AS E2; -- .را دارد CROSS JOIN همان کارکرد
GO
--------------------------------------------------------------------

/*
APPLY & Derived Table
*/

-- نمایش 3 سفارش اخیر مشتری 1 
SELECT
	TOP (3) O.CustomerID, O.OrderID, o.OrderDate
FROM dbo.Orders AS O
	WHERE O.CustomerID = 1 -- 1 ... 91
ORDER BY O.OrderDate DESC;
GO

/*
نمایش 3 سفارش اخیر هر مشتری 
APPLY در سمت راست عملگر Derived Table با استفاده از
*/
SELECT
	C.CustomerID, Tmp.*
FROM dbo.Customers AS C
CROSS APPLY
(SELECT
	TOP (3) O.OrderID, o.OrderDate
FROM dbo.Orders AS O
	WHERE O.CustomerID = C.CustomerID
ORDER BY O.OrderDate DESC) AS Tmp
ORDER BY C.CustomerID;
GO

/*
نمایش سه سفارش اخیر هر مشتری حتی مشتریان فاقد سفارش 
APPLY در سمت راست عملگر Derived Table با استفاده از
*/
SELECT
	C.CustomerID, Tmp.*
FROM dbo.Customers AS C
OUTER APPLY
(SELECT
	TOP (3) O.OrderID, o.OrderDate
FROM dbo.Orders AS O
	WHERE O.CustomerID = C.CustomerID
ORDER BY O.OrderDate DESC) AS Tmp
ORDER BY C.CustomerID;
GO
--------------------------------------------------------------------

/*
APPLY & TVF
*/

/*
تابعی که قبلا به عنوان تمرین کلاسی نوشته بودید

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
*/

-- فراخوانی تابع
SELECT * FROM dbo.Top_Orders(1,5);
GO

/*
نمایش سه سفارش اخیر هر مشتری 
APPLY در سمت راست عملگر TVF با استفاده از
*/
SELECT
	C.CustomerID, Top_Orders.CustomerID, Top_Orders.OrderDate
FROM dbo.Customers AS C
OUTER APPLY dbo.Top_Orders(C.CustomerID,5);-- TVF
GO





	