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

-- Orders مشاهده تمامی سفارشات مشتری کد 71 از جدول
SELECT
	CustomerID, EmployeeID, OrderID, OrderDate
FROM dbo.Orders
	WHERE CustomerID = 71;
GO
--------------------------------------------------------------------

/*
IN گزاره
نمایش رکوردها بر‌اساس لیستی مشخص
*/

-- Orders مشاهده مشخصات سفارش‌ها با یکی از کدهای 10248,10253,10320 از جدول
SELECT
	CustomerID, EmployeeID, OrderID, OrderDate
FROM dbo.Orders
	WHERE OrderID IN (10248,10253,10320);
GO

-- NOT IN
SELECT
	CustomerID, EmployeeID, OrderID, OrderDate
FROM dbo.Orders
	WHERE OrderID NOT IN (10248,10253,10320);
GO
--------------------------------------------------------------------

/*
BETWEEN اپراتور
نمایش رکوردها بر اساس محدوده‌ای مشخص
*/

-- Orders مشاهده سفارش‌های ثبت‌شده توسط یکی از کارمندانی که کد آن‌ها از 3 تا 7 است از جدول
SELECT
	EmployeeID, OrderID
FROM dbo.Orders
	WHERE EmployeeID BETWEEN 3 AND 7;
GO

-- IN معادل کوئری بالا با استفاده از
SELECT
	EmployeeID, OrderID
FROM dbo.Orders
	WHERE EmployeeID IN(3,4,5,6,7);
GO
--------------------------------------------------------------------

/*
LIKE اپراتور

match_expression [ NOT ] LIKE pattern [ ESCAPE escape_character ]

% : Any string of zero or more characters.
_ (underscore) : Any single character.
[ ] : Any single character within the specified range ([a-f]) or set ([abcdef]).
[^] : Any single character not within the specified range ([^a-f]) or set ([^abcdef]).
*/

-- .کارمندانی که نام‌خانوادگی‌شان با حرف الف شروع می‌شود
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName LIKE N'ا%';
GO

-- .کارمندانی که نام‌خانوادگی‌شان با حرف الف شروع نمی‌شود
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName LIKE N'[^ا]%';
GO

-- معادل کوئری بالا
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName NOT LIKE N'ا%';
GO

-- .کارمندانی که نام‌خانوادگی‌شان به حرف ی ختم می‌شود
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName LIKE N'%ی';
GO

-- .کارمندانی که نام‌خانوادگی‌شان با یکی از حرف الف تا پ شروع می‌شود
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName LIKE N'[ا ب پ]%';
GO

-- معادل کوئری بالا
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE LastName LIKE N'[ا-پ]%';
GO

-- .کارمندانی که نام‌ آن‌ها سه کاراکتری است و با حرف س شروع می‌شود
SELECT
	EmployeeID, FirstName, LastName
FROM dbo.Employees
	WHERE FirstName LIKE N'س__';
GO
--------------------------------------------------------------------

/* Comparison Operators:
	=   >   <   >=   <=   <>
*/

--  Orders مشاهده تمامی سفارش‌هااز یک تاریخ مشخص به‌بعد از جدول
SELECT 
	OrderID, EmployeeID, OrderDate
FROM dbo.Orders
	WHERE OrderDate >= '20160430';
GO
--------------------------------------------------------------------

/* Logical Operators:
	AND\OR\NOT\IN\LIKE\BETWEEN\ALL\SOME\ANY\EXISTS
*/

--  .که صرفا توسط کارمندان 1،2 یا 3 ثبت شده باشد Orders مشاهده تمامی سفارش‌هااز یک تاریخ مشخص به‌بعد از جدول
SELECT 
	OrderID, EmployeeID, OrderDate
FROM dbo.Orders
	WHERE OrderDate >= '20160430'
	AND EmployeeID IN (1, 2, 3);
GO

SELECT 
	OrderID, EmployeeID, OrderDate
FROM dbo.Orders
	WHERE OrderDate >= '20160430'
	OR EmployeeID IN (1, 2, 3);
GO
--------------------------------------------------------------------

/*
Arithmetic Operators:
	+   –   *   /   % 
*/

-- محاسبه تخفیف کل
SELECT 
	OrderID, productid, qty, unitprice, discount,
	qty * UnitPrice * (1 - discount) AS val
FROM dbo.OrderDetails;
GO
--------------------------------------------------------------------

/*
اولویت اجرای اپراتورها

1. ( ) (Parentheses)
2. * (Multiplication), / (Division), % (Modulo)
3. + (Positive), – (Negative), + (Addition), + (Concatenation), – (Subtraction)
4. =, >, <, >=, <=, <>, !=, !>, !< (Comparison operators)
5. NOT
6. AND
7. BETWEEN, IN, LIKE, OR
8. = (Assignment)

*/

SELECT 10 + 2 * 3;
GO

SELECT ( 10 + 2 ) * 3;
GO

SELECT 
	OrderID, CustomerID, EmployeeID, OrderDate
FROM dbo.Orders
	WHERE CustomerID = 1
	AND EmployeeID IN(1, 3, 5)
	OR CustomerID = 85
	AND EmployeeID IN(2, 4, 6);
GO

-- با استفاده از پرانتزگذاری خوانایی اسکریپت بالا بیشتر می‌شود
SELECT 
	OrderID, CustomerID, EmployeeID, OrderDate
FROM dbo.Orders
	WHERE
	(CustomerID = 1
	AND EmployeeID IN(1, 3, 5))
		OR
	(CustomerID = 85
	AND EmployeeID IN(2, 4, 6));
GO