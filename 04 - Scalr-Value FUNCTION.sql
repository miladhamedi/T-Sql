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
Scalar-Value FUNCTION

CREATE FUNCTION FUNCTION_Name
	({@Parameter [AS] type[=default]}[,...n])
	RETURNS Type
AS
BEGIN
	Function_Body
	RETURN Expression
END
*/

DROP FUNCTION IF EXISTS dbo.Abbreviation;
GO

-- تعریف تابع
CREATE FUNCTION dbo.Abbreviation (@FirstName NVARCHAR(50), @LastName NVARCHAR(50))
RETURNS NCHAR(3)
AS
BEGIN
	DECLARE @Out NCHAR(3)
	SET @Out = LEFT(@FirstName,1) + '.' + LEFT(@LastName,1)
	RETURN @Out
	/*
	معادل سه خط بالا
	RETURN LEFT(@FirstName,1) + '.' + LEFT(@LastName,1)
	*/
END
GO

-- استفاده از تابع در حالت عادی
SELECT dbo.Abbreviation(N'مجید',N'حمیدی');
GO

/*
استفاده از تابع برای بازیابی رکوردهای جداول

ترکیب نام و نام‌خانوادگی کارمندان
*/
SELECT
	FirstName,
	LastName,
	dbo.Abbreviation(FirstName, LastName) AS Abbreviation
FROM dbo.Employees;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
.تابعی بنویسید که سن کارمندان را نمایش دهد

EmployeeID    Age
----------   -----
   1          60
   2          56
   3          45
   4          71
   5          53
   6          45
   7          48
   8          50
   9          42

(9 rows affected)

*/

DROP FUNCTION IF EXISTS dbo.GetAge;
GO

CREATE FUNCTION dbo.GetAge (@Birthdate DATETIME)
RETURNS TINYINT
AS
BEGIN
	RETURN DATEDIFF(YEAR,@Birthdate,GETDATE())
END
GO

SELECT
	EmployeeID,
	dbo.GetAge(Birthdate) AS Age
FROM Employees;
GO



