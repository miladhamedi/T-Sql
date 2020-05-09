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
Multi-Join Queries
*/

/*
سفارش هر مشتری به‌همراه عنوان شرکتش، کد سفارش، کد محصول و تعداد سفارش
JOIN جداول شرکت‌کننده در: Customers\Orders\OrderDetails
*/
SELECT
	C.CustomerID, C.CompanyName, O.OrderID, OD.ProductID, OD.Qty
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

نمایش تمامی سفارشات درخواست‌شده به‌همراه مجموع تمامی کالاهای هر سفارش 
.که مربوط به شرکت‌هایی باشند که در استان تهران هستند

JOIN جداول شرکت‌کننده در: Customers\Orders\OrderDetails

CustomerID  CompanyName     OrderID   Quantity
----------  -------------   -------   --------
1           شرکت IR- AA     10643     38
1           شرکت IR- AA     10692     20
1           شرکت IR- AA     10702     21
1           شرکت IR- AA     10835     17
1           شرکت IR- AA     10952     18
1           شرکت IR- AA     11011     60
2           شرکت IR- AB     10308     6
2           شرکت IR- AB     10625     18
2           شرکت IR- AB     10759     10
2           شرکت IR- AB     10926     29
...
89          شرکت IR- DK     10904     50
89          شرکت IR- DK     11032     90
89          شرکت IR- DK     11066     80

(132 rows affected)

*/

SELECT * FROM dbo.OrderDetails
	WHERE OrderID = 10643;
GO

SELECT
	C.CustomerID, C.CompanyName, O.OrderID, 
	SUM(OD.Qty) AS Quantity
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
	WHERE C.State = N'تهران'
GROUP BY C.CustomerID, C.CompanyName, O.OrderID;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی 

نمایش تعداد سفارشات به‌همراه مجموع کل محصولات سفارشات شرکت‌هایی که در استان تهران هستند

Tables: Customers\Orders\OrderDetails

CustomerID    CompanyName     NumOrders     TotalQuantity
-----------   ------------    ---------     -------------
1             شرکت IR- AA     6             174
2             شرکت IR- AB     4             63
12            شرکت IR- AL     6             115
15            شرکت IR- AO     5             133
27            شرکت IR- BA     6             54
37            شرکت IR- BK     19            1684
44            شرکت IR- BR     15            794
50            شرکت IR- BX     7             320
61            شرکت IR- CI     9             394
71            شرکت IR- CS     31            4958
74            شرکت IR- CV     4             48
79            شرکت IR- DA     6             253
89            شرکت IR- DK     14            1063

(13 rows affected)

*/
SELECT
	C.CustomerID, C.CompanyName,
	COUNT(O.OrderID) AS NumOrders,
	SUM(OD.Qty) AS TotalQuantity
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
	WHERE C.State = N'تهران'
GROUP BY C.CustomerID, C.CompanyName;
GO

SELECT
	C.CustomerID, C.CompanyName,
	COUNT(DISTINCT O.OrderID) AS NumOrders,
	SUM(OD.Qty) AS TotalQuantity
FROM dbo.Customers AS C
JOIN dbo.Orders AS O
	ON C.CustomerID = O.CustomerID
JOIN dbo.OrderDetails AS OD
	ON O.OrderID = OD.OrderID
	WHERE C.State = N'تهران'
GROUP BY C.CustomerID, C.CompanyName;
GO