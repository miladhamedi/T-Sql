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
Multi Statement Table-Value FUNCTION
*/

--CREATE FUNCTION Statement (Multi Statement Table Valued)
/*
CREATE FUNCTION [owner_name.] function_name 
    ({@parameter [AS] type [= default]}[,...n ]) 
	RETURNS @return_variable TABLE < table_type_definition > 
AS
	BEGIN 
	    function_body 
	    RETURN
	END
*/

DROP FUNCTION IF EXISTS dbo.Multi_Statement_Table_Valued;
GO

CREATE FUNCTION dbo.Multi_Statement_Table_Valued()
RETURNS @Tbl TABLE (Col1 INT, Col2 NVARCHAR(100))
AS
	BEGIN
		INSERT @Tbl 
		VALUES (1,'HELLO'),(2,'SQL')
		RETURN;
	END
GO

SELECT * FROM dbo.Multi_Statement_Table_Valued();
GO