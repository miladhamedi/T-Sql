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
NTILE(integer_expression) OVER(ORDER BY Clause)
*/

/*
NTILE اعمال تابع

:نحوه محاسبه دسته‌ها به صورت زیر است
ابتدا تعداد رکوردها بر عدد آرگومان تقسیم می‌شود
.اگر باقی‌مانده برابر با صفر نبود رکوردهای اضافی را از اولین گروه‌های ایجاد‌شده و به‌صورت مساوی میان آن‌ها تقسیم می‌کند

   |  3
77 |_____ 
75    25
___
2

*/

SELECT
	NTILE(3) OVER (ORDER BY UnitPrice) AS Ranking,
	ProductName,UnitPrice
FROM dbo.Products;
GO
--------------------------------------------------------------------

DROP TABLE IF EXISTS dbo.Price;
GO

CREATE TABLE dbo.Price
(
	Pname NVARCHAR(20),
	Price INT
);
GO

INSERT INTO dbo.Price
	VALUES (N'کالای 1',100),(N'کالای 2',200),(N'کالای 3',300),(N'کالای 4',200),(N'کالای 5',250),
		  (N'کالای 6',200),(N'کالای 7',100),(N'کالای 8',400),(N'کالای 9',450),(N'کالای 10',100);
GO

/*
10 / 3 = 3
10 % 3 = 1
ابتدا 3 دسته 3 ‌رکوردی می سازد
چون باقی مانده 1 شده آن 1 رکورد را به اولین دسته می‌دهد
*/
SELECT
	NTILE(3) OVER (ORDER BY Price)
		AS Ranking,
	Pname,
	Price
FROM dbo.Price;
GO

/*
10 / 6 = 1
10 % 6 = 4
ابتدا 6 دسته 1 رکوردی می سازد
چون باقی مانده 4 شده آن‌ها را به 4 دسته ابتدایی می‌دهد
*/
SELECT
	NTILE(6) OVER (ORDER BY Price)
		AS Ranking,
	Pname,
	Price
FROM dbo.Price;
GO

SELECT * FROM dbo.Price;
GO

-- آیا کوئری زیر ایراد دارد؟
SELECT
	CASE NTILE(3) OVER (ORDER BY Price)
		WHEN 1 THEN 'Cheap'
		WHEN 2 THEN 'Normal'
		ELSE 'Expensive' END AS Ranking,
	Pname,
	Price
FROM dbo.Price;
GO