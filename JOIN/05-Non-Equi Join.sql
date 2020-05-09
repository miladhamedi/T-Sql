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
Non-Equi Join
*/

-- ترکیب دو تایی از نام و نام‌خانوادگی کارمندان
SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM dbo.Employees AS E1
CROSS JOIN dbo.Employees AS E2
ORDER BY E1.FirstName, E1.LastName;
GO

-- Equi Join
SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM dbo.Employees AS E1
JOIN dbo.Employees AS E2
	ON E1.EmployeeID = E2.EmployeeID;
GO

-- Non-Equi Join
-- تمامی ترکیبات دو تایی غیر‌تکراری از نام و نام‌خانوادگی کارمندان
SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM dbo.Employees AS E1
JOIN dbo.Employees AS E2
		ON E1.EmployeeID < E2.EmployeeID
ORDER BY E1.EmployeeID;
GO

/*
تمرین کلاسی

کوئری‌ای بنویسید که تمامی ترکیبات دو تایی از نام و نام‌خانوادگی کارمندان
.به‌جز حالت تشابه میان یک کارمند با خودش را در خروجی نمایش دهد

EmployeeID   FirstName  LastName  EmployeeID  FirstName  LastName
-----------  ---------- --------- -------     ---------  --------
1            فکری        بهزاد         2        تقوی        سحر
1            پایدار        علی         3        تقوی        سحر
1            تهرانی       زهره         4        تقوی        سحر
1            اسماعیلی     کامران         5        تقوی        سحر
1            دهقان       سعید         6        تقوی        سحر
1            سلامی      پیمان         7        تقوی        سحر
1            یکتا       زهرا         8        تقوی        سحر
1            زنده دل     محمد رضا        9        تقوی        سحر 

2           تقوی        سحر         1        فکری        بهزاد
2           پایدار        علی         3        فکری        بهزاد
2           تهرانی       زهره         4        فکری        بهزاد
2           اسماعیلی     کامران         5        فکری        بهزاد
2           دهقان       سعید         6        فکری        بهزاد
2           سلامی      پیمان         7        فکری        بهزاد
2           یکتا       زهرا         8        فکری        بهزاد
2           زنده دل    محمد رضا         9        فکری        بهزاد
...								 

(72 rows affected)

*/

SELECT
	E1.EmployeeID, E1.FirstName, E1.LastName,
	E2.EmployeeID, E2.FirstName, E2.LastName
FROM dbo.Employees AS E1
JOIN dbo.Employees AS E2
		ON E1.EmployeeID <> E2.EmployeeID
ORDER BY E1.EmployeeID;
GO

/*
SQL تفسیر کوئری بالا به زبان
.آن فیلتر شده است INNER JOIN ای است که بخشCROSS JOIN
*/