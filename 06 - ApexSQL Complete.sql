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
auto-complete
نمایش آبجکت‌ها و اجزای آن در هنگام کوئری‌نویسی

!حتما قبل از استفاده از این قابلیت فعال شده باشد
ApexSQL\ApexSQL Complete\Enable auto-complete
*/
SELECT * FROM Sales.Orders o

-- Hint & Option

--------------------------------------------------------------------

/*
auto-replacements
جایگزینی کلمات در کوئری‌ها

!حتما قبل از استفاده از این قابلیت فعال شده باشد
ApexSQL\ApexSQL Complete\Enable auto-replacements

برای استفاده از این قابلیت می‌بایست ابتدا در قسمت
کلمات مورد‌نظر و جایگزین را ایجاد کرد Manage auto-replacements

.این قابلیت با کلیک بر روی آبجکت‌ها نیز امکان‌پذیر است
(Asign auto-replacements)
*/
-- od = OrderDetails
-- OD = OrderDetails
SELECT * FROM OrderDetails
--------------------------------------------------------------------

/*
snippet
استفاده از الگوی کدهای آماده

.توسط کاربر امکان‌پذیر است Snippet در این ابزار قابلیت ساخت
*/

/*
Snippet نحوه استفاده از

1) کلیک راست / Insert Snippet
2) در هنگام کوئری‌نویسی
*/
SELECT CASE /*expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    ELSE /*result_expression*/
END

/*
snippet نحوه تعریف

1) New Snippet
2) کلیک راست / انتخاب کوئری نوشته‌شده / New Snippet
*/
SELECT CASE /*expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    ELSE /*result_expression*/
END


-- ؟؟؟ snippet روش ساده‌تر برای ساخت 
SELECT CASE /*expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    WHEN /*expression*/ THEN /*result_expression*/
    ELSE /*result_expression*/
END
--------------------------------------------------------------------

/*
Executed queries
مدیریت کوئری‌های اجرا‌شده، جستجو در محتوای آن‌ها و قابلیت استفاده مجدد از آن‌ها

.تمامی کوئری‌های اجرا‌شده لاگ می‌شوند
*/


