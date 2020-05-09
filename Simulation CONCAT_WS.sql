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

-- ادغام ستون‌های یک جدول

-- CASE
SELECT CAST(database_id AS VARCHAR(10))
    + CASE WHEN database_id IS NOT NULL THEN ', ' ELSE '' END
		+ recovery_model_desc
    + CASE WHEN recovery_model_desc IS NOT NULL THEN ', ' ELSE '' END
		+ containment_desc
    + CASE WHEN containment_desc IS NOT NULL THEN '' ELSE '' END AS Result
FROM sys.databases;
GO

-- COALESCE
SELECT  COALESCE(NULLIF(CAST(database_id AS VARCHAR(10)), '') + ',', '') + 
        COALESCE(NULLIF(recovery_model_desc, '') + ',', '') + 
        COALESCE(NULLIF(containment_desc, '') , '' ) AS Result
FROM sys.databases;
GO

-- ISNULL
SELECT
	ISNULL(CAST(database_id AS VARCHAR(10)) + '','') +
	ISNULL(recovery_model_desc + ',','') + 
	ISNULL(containment_desc ,'') AS Result
FROM sys.databases;
GO

-- CONCAT
SELECT CONCAT( database_id,',',recovery_model_desc , ',' , containment_desc) AS Result
FROM sys.databases;
GO

-- CONCAT_WS
SELECT 
	CONCAT_WS( ' , ', database_id , recovery_model_desc,containment_desc)  AS Result
FROM sys.databases;
GO