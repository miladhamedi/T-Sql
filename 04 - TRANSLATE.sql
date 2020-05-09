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
TRANSLATE ( inputString, characters, translations)
*/

DECLARE @Str VARCHAR(MAX) = '2*[3+4]/{7-2}';
SELECT TRANSLATE(@Str, '[]{}', '()()');
GO

-- REPLACE نوشتن کوئری بالا با استفاده از تابع
DECLARE @Str VARCHAR(MAX) = '2*[3+4]/{7-2}';
SELECT REPLACE(REPLACE(REPLACE(REPLACE(@Str,'[','('), ']', ')'), '{', '('), '}', ')');
GO

DECLARE @Str VARCHAR(MAX)='2*[3+4]/{7-2}';
--SELECT TRANSLATE(@Str, '[]{', '()()'); -- عدم تطابق تعداد کاراکترها جهت جایگزینی
--SELECT TRANSLATE(@Str, '[]{}', '-'); -- عدم تطابق تعداد کاراکترها جهت جایگزینی
SELECT TRANSLATE(@Str, '[]{}', 'AAAA');
GO
