--CWICZENIA 8

--Zad 1. 
-- Wykorzystuj¹c wyra¿enie CTE zbuduj zapytanie, które znajdzie informacje na temat stawki pracownika oraz jego danych, 
-- a nastêpnie zapisze je do tabeli tymczasowej TempEmployeeInfo. Rozwi¹¿ w opraciu o AdventureWorks. 

WITH PersonInfo(Name, Address, City, Rate)
AS
(      SELECT CONCAT(p.FirstName, ' ', p.LastName), pa.AddressLine1, pa.City, eph.Rate
       FROM Person.Person AS p
       LEFT JOIN HumanResources.EmployeePayHistory AS eph
	        ON p.BusinessEntityID =  eph.BusinessEntityID
       INNER JOIN Person.BusinessEntityAddress AS bea 
	        ON eph.BusinessEntityID = bea.BusinessEntityID
       INNER JOIN Person.Address AS pa 
	        ON pa.AddressID = bea.AddressID
)  
SELECT Name, Address, City, Rate
INTO #TempEmployeeInfo
FROM PersonInfo

SELECT* FROM #TempEmployeeInfo
DROP TABLE #TempEmployeeInfo

--Zad 2. 
-- Uzyskaj informacje na temat przychodów ze sprzeda¿y wed³ug firmy i kontaktu (za pomoc¹ CTE i bazy AdventureWorksLT)

WITH SalesRevenue
AS
(      SELECT CONCAT(slc.CompanyName, 
              CONCAT(' (' + slc.FirstName + ' ', 
		      slc.LastName + ')')) AS 'CompanyContact', 
		      soh.TotalDue AS 'Sales'
       FROM SalesLT.SalesOrderHeader AS soh
       INNER JOIN SalesLT.Customer AS slc
            ON soh.CustomerID = slc.CustomerID
)
SELECT CompanyContact, SUM(Sales) AS Revenue
FROM SalesRevenue
GROUP BY CompanyContact;


--Zad 3.
-- Napisz zapytanie, które zwróci wartoœæ sprzeda¿y dla poszczególnych kategorii produktów. Wykorzystaj CTE i bazê AdventureWorksLT. 

 WITH CategorySales
 AS
 (      SELECT pc.Name AS 'Category', CAST(SUM(sod.LineTotal) AS numeric(8, 2)) AS 'SalesValue'
        FROM SalesLT.SalesOrderDetail AS sod
        INNER JOIN SalesLT.Product AS slp
           ON sod.ProductID = slp.ProductID
        INNER JOIN SalesLT.ProductCategory AS pc
           ON slp.ProductCategoryID = pc.ProductCategoryID
        GROUP BY pc.Name
 )
 SELECT Category, SalesValue
 FROM CategorySales
 ORDER BY Category;

