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
CONCAT_WS ( separator, argument1, argument1 [, argumentN]… )
separator: any char,string, digit
min At least two argument ( null or string or digit ...)
*/

DECLARE @Str1 CHAR(1) = 'a', @Str2 CHAR(1) = 'b';
SELECT CONCAT_WS (',', @Str1, @Str2);
GO
--------------------------------------------------------------------

/*
NULL با مقادیر CONCAT_WS و CONCAT مقایسه رفتار توابع
*/
-- NULL نادیده گرفتن مقادیر
SELECT CONCAT_WS('**', 'String1', 2, NULL, NULL, 'String3', 'String4');
GO

-- NULL عدم نادیده گرفتن مقادیر
SELECT CONCAT('String1', '**', 2, '**', NULL, '**',
			   NULL, '**', 'String3', '**', 'String4', '**');
GO
--------------------------------------------------------------------

SELECT 
	CONCAT_WS( ' , ', database_id, recovery_model_desc,containment_desc) AS Result
FROM sys.databases;
GO

-- CONCAT_WS with STRING_AGG (CSV Format)
SELECT 
	STRING_AGG(CONCAT_WS( ',', database_id, recovery_model_desc, containment_desc), CHAR(13)) AS DatabaseInfo
FROM sys.databases;
GO