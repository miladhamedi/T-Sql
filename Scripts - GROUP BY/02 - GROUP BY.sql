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

-- GROUP BY و DISTINCT تشابه عملیات

-- DISTINCT
SELECT
	DISTINCT EmployeeID, CustomerID
FROM dbo.Orders;
GO

-- GROUP BY
SELECT
	EmployeeID, CustomerID
FROM dbo.Orders
GROUP BY EmployeeID, CustomerID;
GO

-- شرکت داشته باشند GROUP BY استفاده می‌شوند می‌بایست حتما در SELECT فیلدهایی که در بخش
SELECT
	EmployeeID, CustomerID
FROM dbo.Orders
GROUP BY EmployeeID;--, CustomerID
GO

-- ظاهر نشده‌اند، استفاده کرد SELECT می‌توان از فیلدهایی که در بخش GROUP BY در بخش
SELECT
	EmployeeID
FROM dbo.Orders
GROUP BY EmployeeID, CustomerID;
GO

-- شرکت کنند ORDER BY شرکت نکرده‌اند نمی‌توانند در بخش GROUP BY فیلدی که در
SELECT
	EmployeeID
FROM dbo.Orders
GROUP BY EmployeeID, CustomerID
ORDER BY OrderID;
GO

-- ???
SELECT COUNT(City) FROM dbo.Customers
	WHERE City IN(N'تهران' , N'اصفهان');
GO