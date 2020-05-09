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
SELF JOIN
*/

-- ترکیب دو تایی از نام و نام‌خانوادگی کارمندان
SELECT * FROM dbo.Employees;
GO

SELECT
	E1.FirstName, E1.LastName,
	E2.FirstName, E2.LastName
FROM dbo.Employees AS E1
CROSS JOIN dbo.Employees AS E2
ORDER BY E1.FirstName, E1.LastName;
GO

/*
ایراد کوئری بالا
Self      Pairs:	بهزاد فکری 		بهزاد فکری	
Mirrored  Pairs:    بهزاد فکری 	پیمان سلامی    		پیمان سلامی		بهزاد فکری
*/