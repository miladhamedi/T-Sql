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
TRIM ( [ characters FROM ] string )  
*/

SELECT TRIM('  test    ') AS Result;
SELECT LTRIM(RTRIM('  test    ')) AS Result;
GO
--------------------------------------------------------------------

-- حذف الگوی خاص از ابتدای رشته
SELECT	   TRIM( '#' FROM  '#test') AS Result;
SELECT LEN(TRIM( '#' FROM  '#test')) AS Result;
GO

SELECT	   TRIM( '# ' FROM  '  #test') AS Result;
SELECT LEN(TRIM( '# ' FROM  '  #test')) AS Result;
GO

SELECT	   TRIM( '# ' FROM  '#  test') AS Result;
SELECT LEN(TRIM( '# ' FROM  '#  test')) AS Result;
GO

--------------------------------------------------------------------

-- حذف الگوی خاص از انتهای رشته
SELECT	   TRIM( '.' FROM  'test.') AS Result;
SELECT LEN(TRIM( '.' FROM  'test.')) AS Result;
GO

SELECT	   TRIM( '. ' FROM  'test  .') AS Result;
SELECT LEN(TRIM( '. ' FROM  'test  .')) AS Result;
GO

SELECT	   TRIM( '. ' FROM  'test.  ') AS Result;
SELECT LEN(TRIM( '. ' FROM  'test.  ')) AS Result;
GO
--------------------------------------------------------------------

-- حذف الگو
SELECT	   TRIM( '.,#' FROM  '  #test  .') AS Result;
SELECT LEN(TRIM( '.,#' FROM  '  #test  .')) AS Result;
GO

SELECT	   TRIM( '!,.' FROM  '!  test  .') AS Result;
SELECT LEN(TRIM( '!,.' FROM  '!  test  .')) AS Result;
GO

SELECT TRIM( '!,.,a,#' FROM  'atest  !#') AS Result;
SELECT LEN(TRIM( '!,.,a,#' FROM  'atest  !#')) AS Result;
GO

SELECT TRIM( 'X' FROM  'X  test  X') AS Result;
SELECT LEN(TRIM( 'X' FROM  'X  test  X')) AS Result;
GO

DECLARE @Var VARCHAR(10) = 'xyz';
SELECT TRIM( SUBSTRING(@Var,1,2) FROM  'XytestXz') AS Result;
SELECT TRIM( SUBSTRING(@Var,1,2) FROM  'XytestXyz') AS Result;
GO

SELECT CHAR(88);
SELECT TRIM( CHAR(88) FROM  'XytestXy') AS Result;
GO
--------------------------------------------------------------------

-- مثال کاربردی
DROP TABLE IF EXISTS Digit_Trim;
GO

CREATE TABLE Digit_Trim
(
	Num VARCHAR(20)
);
GO

INSERT INTO Digit_Trim
    VALUES ('_one'),('_two'),('three_ok'),('four_ok');
GO

/*
:انتظار داریم پس از اجرای کوئری زیر، خروجی به این ‌صورت باشد

four-ok
one
three-ok
two
*/
SELECT Num FROM Digit_Trim 
ORDER BY Num;
GO

-- TRIM حل مشکل کوئری بالا با استفاده از تابع
SELECT
    TRIM( '_' FROM  Num) AS Result
FROM dbo.Digit_Trim 
ORDER BY Result;
GO