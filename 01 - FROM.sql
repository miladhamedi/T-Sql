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
SELECT select_list [ INTO new_table ]
[ FROM table_source ] [ WHERE search_condition ]
[ GROUP BY group_by_expression ]
[ HAVING search_condition ]
[ ORDER BY order_expression [ ASC | DESC ] ]
*/

USE NikamoozDB;
GO

-- Orders مشاهده برخی از فیلدهای جدول
SELECT
	OrderID, OrderDate
FROM dbo.Orders;
GO

-- FROM در بخش Alias استفاده از
SELECT
	O.OrderID, O.EmployeeID
FROM dbo.Orders AS O;
GO
--------------------------------------------------------------------

/* استفاده از [] برای جداول با نام‌های دوبخشی */

IF OBJECT_ID('[Order Details]', 'U') IS NOT NULL 
	DROP TABLE dbo.[Order Details];
GO

-- به‌بعد SQL Server 2016 معادل دستور بالا از
DROP TABLE IF EXISTS [Order Details]; --DIE
GO

-- Order Details ایجاد جدول
CREATE TABLE dbo.[Order Details]
(
	ID INT
);
GO

-- Order Details مشاهده رکوردهای جدول
SELECT * FROM dbo.[Order Details];
GO

-- Order Details حذف جدول
DROP TABLE IF EXISTS dbo.[Order Details];
GO