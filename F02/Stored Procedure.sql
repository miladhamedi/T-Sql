USE NikamoozDB2017;
GO

-- ساده SP ایجاد یک
DROP PROCEDURE IF EXISTS GetAllCustomers;
GO

CREATE PROCEDURE GetAllCustomers
AS
BEGIN	
	SELECT 
		CustomerID,City
	FROM dbo.Customers;
END
GO

-- SP روش‌های فراخوانی
EXEC GetAllCustomers;
GO