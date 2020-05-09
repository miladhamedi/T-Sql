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
LEN/DATALENGTH Function

LEN ( string_expression )
DATALENGTH ( expression )

طول رشته و تعداد بایت‌های تخصیص داده‌شده به رشته 
*/

-- های یونیکدی Data Type تفاوت عملکرد با
SELECT LEN(N'سلام');
SELECT DATALENGTH(N'سلام');

SELECT LEN('A');
SELECT DATALENGTH('A');
GO

-- پس از رشته Blank مقادیر
SELECT LEN(N'My String   ');
SELECT DATALENGTH(N'My String   ');
GO
--------------------------------------------------------------------

/*
LOWER/UPPER Functions

LOWER ( character_expression )
UPPER ( character_expression )

کوچک و بزرگ کردن کاراکترهای یک رشته
*/

SELECT UPPER('my sTRing');
SELECT LOWER('my sTRing');
GO
--------------------------------------------------------------------

/*
RTRIM/LTRIM Functions

RTRIM ( character_expression )
LTRIM ( character_expression )

حذف فضای خالی از ابتدا یا انتهای رشته
*/

SELECT RTRIM(' str '), LEN(RTRIM(' str '));
SELECT LTRIM(' str '), LEN(LTRIM(' str '));
SELECT RTRIM(LTRIM(' str ')), LEN(RTRIM(LTRIM(' str ')));
GO
--------------------------------------------------------------------

/*
LEFT/RIGHT Function

LEFT ( character_expression , integer_expression ) 
RIGHT ( character_expression , integer_expression ) 

استخراج بخشی از یک رشته از سمت راست یا چپ آن رشته
*/

SELECT LEFT(N'علی رضا', 3);
SELECT RIGHT(N'علی رضا', 3);
SELECT LEFT('ABCD', 3);
SELECT LEFT(N'ABCD', 3);
GO
--------------------------------------------------------------------

/*
SUBSTRING Function

SUBSTRING ( expression , start , length )

استخراج بخشی از یک رشته
*/

SELECT SUBSTRING('My String', 1, 2);
GO
--------------------------------------------------------------------

/*
CHARINDEX Function

CHARINDEX ( expressionToFind , expressionToSearch [ , start_location ] )

 اولین موقعیتِ کاراکترِ عین یک عبارت در رشته
*/

SELECT CHARINDEX(' ',N'امیر حسین سعیدی');
GO

SELECT CHARINDEX(N'ید',N'امیر حسین سعیدی');
GO

SELECT CHARINDEX(N'یک',N'امیر حسین سعیدی');
GO
--------------------------------------------------------------------

/*
PATINDEX Function

PATINDEX ( '%pattern%' , expression )  

 اولین موقعیتِ الگو در رشته
*/

SELECT PATINDEX('[0-9]%', '3ab12cd34ef56gh');
GO

SELECT PATINDEX('[0-9]%', 'a4b12cd34ef56gh');
GO
