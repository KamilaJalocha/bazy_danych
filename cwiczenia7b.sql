--ZADANIA 7B

--Zad 1. 
--Napisz procedur� wypisuj�c� do konsoli ci�g Fibonacciego. Procedura musi przyjmowa� jako argument wyj�ciowy liczb� n.
--Generowanie ci�gu Fibonacciego musi zosta� zaimplementowane jako osobna funkcja, wywowa�ana przez procedur�. 

CREATE FUNCTION fib (@n INT) 
RETURNS INT
AS
BEGIN
    DECLARE @temp INT = 1
	DECLARE @f1 INT  = 1
	DECLARE @f2 INT  = 1
	DECLARE @c INT  = 2

	WHILE @c < @n
	BEGIN
	    SET @temp = @f1;
		SET @f1 = @f2 + @f1;
		SET @f2 = @temp;

		SET @c = @c + 1;
	END
	RETURN @f1
END;


CREATE PROCEDURE Fibo @n INT
AS
BEGIN
	DECLARE
		@c INT = 1,
		@final INT
	
	WHILE @c <= @n
	BEGIN
		SET @final = dbo.fib(@c)
		PRINT CONVERT(VARCHAR,@c) + 'wyraz ci�gu: ' + CONVERT(VARCHAR,@final)
		SET @c = @c + 1
	END
END


EXEC Fibo 10

DROP FUNCTION dbo.fib
DROP PROCEDURE dbo.Fibo


--Zad 2. 
-- Napisz trigger DML, kt�ry po wprowadzeniu danych do tabeli Persons zmodyfikuje nazwisko, tak aby by�o napisane du�ymi literami. 

CREATE TRIGGER 
	TriggerLastName
ON 
	Person.Person
AFTER INSERT
AS
BEGIN
UPDATE Person.Person SET LastName =  UPPER([Person].[Person].[LastName]) 
FROM Person.Person 
JOIN Inserted
  ON [Person].[Person].[LastName] = [Inserted].[LastName];
END

DROP TRIGGER Person.TriggerLastName


--sprawdzenie 
INSERT INTO Person.Person (BusinessEntityID, PersonType, FirstName, LastName) 
VALUES (20778, 'IN', 'Jola', 'Kowalska')

SELECT * FROM Person.Person
DELETE FROM Person.Person WHERE BusinessEntityID = 20778;

--dodanie nowego id
INSERT INTO Person.BusinessEntity(rowguid)
VALUES(NewID())
SELECT * FROM Person.BusinessEntity


--Zad 3. 
-- Przygotuj trigger'taxRateMonitoring', kt�ry wy�wietli komunikat o b��dzie, je�eli nast�pi zmiana warto�ci w polu 'TaxRate' o wi�cej ni� 30%

CREATE TRIGGER 
	taxRateMonitoring
ON 
	Sales.SalesTaxRate
AFTER UPDATE
AS
    DECLARE @tax FLOAT;
	DECLARE @tax_sec FLOAT;

	SELECT @tax_sec = TaxRate FROM Inserted
	SELECT @tax= TaxRate FROM  Deleted 

       BEGIN 
	    IF (@tax*1.3 < @tax_sec)
        begin
             print 'An error occured. TaxRates increased by more than 30%.'
        end

		ELSE IF (@tax*0.7 > @tax_sec)
		begin 
		     print 'An error occured. TaxRates decreased by more than 30%.'
        end 
END    

DROP TRIGGER Sales.taxRateMonitoring

UPDATE Sales.SalesTaxRate SET TaxRate = 14 WHERE SalesTaxRateID = 1
select * from Sales.SalesTaxRate


