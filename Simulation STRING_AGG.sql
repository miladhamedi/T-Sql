--------------------------------------------------------------------
/*
SQL Server 2019 دوره آموزشی کوئری‌نویسی در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebori 
*/
--------------------------------------------------------------------

USE Northwind
GO

SELECT * FROM Products
ORDER BY CategoryID;
GO

/*
لیست محصولات مشابه در قالب یک رشته نمایش داده شود CategoryID می‌خواهیم به‌ازای هر
 
Chai,Chang,...
Original Frankfurter grüne Soße,Sirop d'érable,...
...
KonbuCarnarvon Tigers,...
*/

-- Recursive CTE
WITH CTE ( CategoryId, product_list, product_name, length ) 
          AS ( SELECT CategoryId, CAST( '' AS VARCHAR(8000) ), CAST( '' AS VARCHAR(8000) ), 0
                 FROM Northwind..Products
                GROUP BY CategoryId
                UNION ALL
               SELECT p.CategoryId, CAST( product_list + 
                      CASE WHEN length = 0 THEN '' ELSE ', ' END + ProductName AS VARCHAR(8000) ), 
                      CAST( ProductName AS VARCHAR(8000)), length + 1
                 FROM CTE c
                INNER JOIN Northwind..Products p
                   ON c.CategoryId = p.CategoryId
                WHERE p.ProductName > c.product_name )
SELECT CategoryId, product_list 
      FROM ( SELECT CategoryId, product_list, 
                    RANK() OVER ( PARTITION BY CategoryId ORDER BY length DESC )
               FROM CTE ) D ( CategoryId, product_list, RANK )
     WHERE RANK = 1 ;
GO

-- FOR XML PATH
SELECT categoryid,
STUFF(
(
    SELECT ','+ productname FROM products WHERE CategoryID = t.categoryid FOR XML PATH('')
),1,1,'') AS ProductName
FROM (SELECT DISTINCT categoryid FROM  products ) t
ORDER BY ProductName;
GO

-- STRING_AGG
SELECT
    CategoryID, STRING_AGG (ProductName, ',') WITHIN GROUP (ORDER BY Products.productName ASC) AS ProductName
FROM Products       
GROUP BY CategoryID;
GO