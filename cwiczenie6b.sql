-- Database: firma

DROP DATABASE IF EXISTS firma;

--utworzenie bazy danych
CREATE DATABASE firma
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
--utworzenie schematu 
CREATE SCHEMA ksiegowosc

--dodanie tabel do schematu oraz dodanie do nich komentarzy 
CREATE TABLE ksiegowosc.pracownicy (
id_pracownika INT PRIMARY KEY NOT NULL,
imie VARCHAR(30),
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(50), 
telefon VARCHAR(25)
);

COMMENT ON TABLE ksiegowosc.pracownicy IS 'Tabela, która zawiera niezbędne informacje o pracownikach';

CREATE TABLE ksiegowosc.godziny (
id_godziny INT PRIMARY KEY NOT NULL,
data DATE, 
liczba_godzin INT NOT NULL,
id_pracownika INT NOT NULL
);

COMMENT ON TABLE ksiegowosc.godziny IS 'Tabela, która zawiera informacje dotyczące przepracowanych godzin przez pracowików';

CREATE TABLE ksiegowosc.premia (
id_premii INT PRIMARY KEY NOT NULL,
rodzaj VARCHAR(50),
kwota MONEY 
);

COMMENT ON TABLE ksiegowosc.premia IS 'Tabela, która zawiera informacje uzyskanych przez pracowników premiach';

CREATE TABLE ksiegowosc.pensja (
id_pensji INT PRIMARY KEY NOT NULL,
stanowiska VARCHAR(40) NOT NULL,
kwota MONEY
);

COMMENT ON TABLE ksiegowosc.pensja IS 'Tabela, która zawiera informacje o pensjach, które uzyskali pracownicy';

CREATE TABLE ksiegowosc.wynagrodzenie (
id_wynagrodzenia INT PRIMARY KEY NOT NULL,
data DATE NOT NULL,
id_pracownika INT NOT NULL,	
id_godziny INT NOT NULL,
id_pensji INT NOT NULL,
id_premii INT 
);

COMMENT ON TABLE ksiegowosc.wynagrodzenie IS 'Tabela, która zawiera informacje o wynagrodzeniu pracownika';

--wyswietlenie komentarzy 
SELECT obj_description(oid)
FROM pg_class
WHERE relkind = 'r';

--utworzenie kluczy obcych 
ALTER TABLE ksiegowosc.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY(id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY(id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY(id_pensji) REFERENCES ksiegowosc.pensja(id_pensji);

ALTER TABLE ksiegowosc.wynagrodzenie 
ADD FOREIGN KEY(id_premii) REFERENCES ksiegowosc.premia(id_premii);

--wypełnienie tabel rekordami 
--tabla pracownicy 
INSERT INTO ksiegowosc.pracownicy VALUES(1, 'Anna', 'Marynarczuk', 'Akacjowa 3,Borki,92-111','777001001');
INSERT INTO ksiegowosc.pracownicy VALUES(2, 'Helena', 'Miszak', 'Kasztanowa 23, Siedlce, 10-001','333000100');
INSERT INTO ksiegowosc.pracownicy VALUES(3, 'Julia', 'Nów', 'Maki 22, Warszawa, 22-005','754901111');
INSERT INTO ksiegowosc.pracownicy VALUES(4, 'Andrzej', 'Góra', 'Stefanowska 35, Gdańsk, 11-788','767820121');
INSERT INTO ksiegowosc.pracownicy VALUES(5, 'Helena', 'Fisiak', 'Wolna 12, Pomiechówek, 92-143','504021724');
INSERT INTO ksiegowosc.pracownicy VALUES(6, 'Robert', 'Miszak', 'Krucza 12, Katowice, 70-746','733922034');
INSERT INTO ksiegowosc.pracownicy VALUES(7, 'Karolina', 'Drabek', 'Krótka 56, Kraków, 31-098','883950903');
INSERT INTO ksiegowosc.pracownicy VALUES(8, 'Maria', 'Skowronek', 'Polna 121, Gdańsk, 54-545','765945234');
INSERT INTO ksiegowosc.pracownicy VALUES(9, 'Jerzy', 'Nowak', 'Kuryłowicza 16, Kraków, 30-698','789675342');
INSERT INTO ksiegowosc.pracownicy VALUES(10, 'Jakub', 'Wojak', 'Rzeczna 44, Siedlce, 11-373','693100946');

SELECT * FROM ksiegowosc.pracownicy ORDER BY id_pracownika;

--tabela godziny
INSERT INTO ksiegowosc.godziny VALUES(1, '2019-03-10', '168', 1);
INSERT INTO ksiegowosc.godziny VALUES(2, '2019-04-22', '160', 2);
INSERT INTO ksiegowosc.godziny VALUES(3, '2020-10-15', '162', 3);
INSERT INTO ksiegowosc.godziny VALUES(4, '2020-09-05', '160', 4);
INSERT INTO ksiegowosc.godziny VALUES(5, '2019-05-09', '168', 5);
INSERT INTO ksiegowosc.godziny VALUES(6, '2021-01-12', '168', 6);
INSERT INTO ksiegowosc.godziny VALUES(7, '2021-06-17', '160', 7);
INSERT INTO ksiegowosc.godziny VALUES(8, '2021-07-18', '160', 8);
INSERT INTO ksiegowosc.godziny VALUES(9, '2022-02-04', '168', 9);
INSERT INTO ksiegowosc.godziny VALUES(10, '2022-03-11', '160', 10);

SELECT * FROM ksiegowosc.godziny ORDER BY id_godziny;

--tabela premia
INSERT INTO ksiegowosc.premia VALUES(0,'Pracownik miesiąca', '400'); 
INSERT INTO ksiegowosc.premia VALUES(1, 'Wyjątkowe osiągnięcia', '360');
INSERT INTO ksiegowosc.premia VALUES(2, 'Zawsze na stanowisku pracy', '200');
INSERT INTO ksiegowosc.premia VALUES(3, 'Motywacyjna', '100');
INSERT INTO ksiegowosc.premia VALUES(4, 'Efektywne zrealizowanie zadania', '250');
INSERT INTO ksiegowosc.premia VALUES(5, 'Przestrzeganie czasu pracy', '150');
INSERT INTO ksiegowosc.premia VALUES(6, 'Przestrzeganie regulaminu', '120');
INSERT INTO ksiegowosc.premia VALUES(7, 'Wydajność', '200');
INSERT INTO ksiegowosc.premia VALUES(8, 'Terminowe wykonywanie swoich obowiązków', '300');
INSERT INTO ksiegowosc.premia VALUES(9, 'Zaangażowanie w swoją pracę', '350');

SELECT * FROM ksiegowosc.premia ORDER BY id_premii;

--tabela pensja 
INSERT INTO ksiegowosc.pensja VALUES(1, 'Manager', '6200');
INSERT INTO ksiegowosc.pensja VALUES(2, 'Analityk biznesowy', '11200');
INSERT INTO ksiegowosc.pensja VALUES(3, 'Dyrektor', '10270');
INSERT INTO ksiegowosc.pensja VALUES(4, 'Asystent handlowy', '5730');
INSERT INTO ksiegowosc.pensja VALUES(5, 'Inżynier produkcji','6700');
INSERT INTO ksiegowosc.pensja VALUES(6, 'Sprzedawca', '1000');
INSERT INTO ksiegowosc.pensja VALUES(7, 'Sekretarka', '2500');
INSERT INTO ksiegowosc.pensja VALUES(8, 'Kierownik oddziału', '7300');
INSERT INTO ksiegowosc.pensja VALUES(9, 'Specjalista ds. produkcji', '7000');
INSERT INTO ksiegowosc.pensja VALUES(10, 'Specjalista ds. administracji', '1000');

SELECT * FROM ksiegowosc.pensja ORDER BY id_pensji;

--tabela wynagrodzenie 
INSERT INTO ksiegowosc.wynagrodzenie VALUES(1, '2019-02-13', 1, 1, 2);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(2, '2018-10-15', 2, 2, 4, 1);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(3, '2019-03-05', 3, 3, 3, 1);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(4, '2020-12-10', 4, 4, 1, 2);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(5, '2020-06-04', 5, 5, 6);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(6, '2021-09-12', 6, 6, 10);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(7, '2021-01-04', 7, 7, 9, 4);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(8, '2020-04-18', 8, 8, 7, 9);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(9, '2022-05-11', 9, 9, 5);
INSERT INTO ksiegowosc.wynagrodzenie VALUES(10,'2022-07-09', 10, 10, 8, 7);

SELECT * FROM ksiegowosc.wynagrodzenie ORDER BY id_wynagrodzenia;

-- wykonanie zapytan

--a)
SELECT  
        id_pracownika, 
		nazwisko 
FROM ksiegowosc.pracownicy 
ORDER BY id_pracownika;

--b)
SELECT 
       ksiegowosc.pracownicy.id_pracownika 
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensja
    ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
WHERE ksiegowosc.pensja.kwota > '1000,00'
ORDER BY ksiegowosc.pracownicy.id_pracownika;
	   
--c)
SELECT 
	   ksiegowosc.pracownicy.id_pracownika
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie 
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
    ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
WHERE ksiegowosc.wynagrodzenie.id_premii IS NULL AND ksiegowosc.pensja.kwota > '2000';

--d)
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%' ORDER BY id_pracownika;

--e)
SELECT * FROM ksiegowosc.pracownicy WHERE imie LIKE '%a' AND nazwisko LIKE '%N%' OR nazwisko LIKE '%n%' 
ORDER BY id_pracownika;

--f)
ALTER TABLE ksiegowosc.godziny ADD liczba_nadgodzin INT;
UPDATE ksiegowosc.godziny SET liczba_nadgodzin = liczba_godzin - 160;
SELECT * FROM ksiegowosc.godziny ORDER BY id_godziny;

SELECT 
      ksiegowosc.pracownicy.imie, 
	  ksiegowosc.pracownicy.nazwisko, 
	  ksiegowosc.godziny.liczba_nadgodzin 
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie
     ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.godziny
     ON ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny
WHERE ksiegowosc.godziny.liczba_godzin >= '160';
	  
--g)
SELECT  
       ksiegowosc.pracownicy.imie, 
	   ksiegowosc.pracownicy.nazwisko 
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
    ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
WHERE ksiegowosc.pensja.kwota BETWEEN '1500' AND '3000';

--h)
SELECT
       ksiegowosc.pracownicy.imie, 
	   ksiegowosc.pracownicy.nazwisko 
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.godziny
    ON ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny
WHERE ksiegowosc.godziny.liczba_nadgodzin > 0 AND ksiegowosc.wynagrodzenie.id_premii IS NULL;

--i)
SELECT 
	   ksiegowosc.pracownicy.id_pracownika, 
	   ksiegowosc.pracownicy.imie, 
	   ksiegowosc.pracownicy.nazwisko, 
	   ksiegowosc.pracownicy.adres, 
	   ksiegowosc.pracownicy.telefon,
	   ksiegowosc.pensja.kwota
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie
     ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
     ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 
ORDER BY ksiegowosc.pensja.kwota;

--j)
SELECT
       ksiegowosc.pracownicy.id_pracownika,
       ksiegowosc.pracownicy.imie,
       ksiegowosc.pracownicy.nazwisko,
       ksiegowosc.pracownicy.adres,
       ksiegowosc.pracownicy.telefon,
       ksiegowosc.pensja.kwota,
       ksiegowosc.premia.kwota
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
    ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia
    ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pensja.kwota DESC, ksiegowosc.premia.kwota DESC;

--k)
SELECT 
       ksiegowosc.pensja.stanowiska, 
COUNT(ksiegowosc.pensja.stanowiska) AS "Ilosc osob zatrudnionych na stanowisku"
FROM ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
    ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
GROUP BY ksiegowosc.pensja.stanowiska;


--l)
--stworzenie selecta w selectcie o nazwie widok, podzapytanie
--coalesce bierze pierwszą wartość która nie jest nullem
SELECT
       AVG(widok.placa) AS srednia,
       MIN(widok.placa) AS minimalna,
       MAX(widok.placa) AS maksymalna
FROM (
    SELECT
           COALESCE(ksiegowosc.pensja.kwota::numeric, 0) + COALESCE(ksiegowosc.premia.kwota::numeric, 0) AS placa
    FROM ksiegowosc.pracownicy
    INNER JOIN ksiegowosc.wynagrodzenie
        ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
    INNER JOIN ksiegowosc.pensja
        ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
    LEFT JOIN ksiegowosc.premia
        ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
    WHERE ksiegowosc.pensja.stanowiska = 'Kierownik oddziału'
 ) widok;
 
 
--m)
SELECT 
SUM (ksiegowosc.pensja.kwota) AS "Suma wszystkich wynagrodzen" 
FROM ksiegowosc.pensja;

--n)
SELECT 
      ksiegowosc.pensja.stanowiska, 
SUM (ksiegowosc.pensja.kwota) AS "Suma wynagrodzen wedlug stanowiska"
FROM ksiegowosc.pensja
GROUP BY ksiegowosc.pensja.stanowiska;

--o)
SELECT  
      ksiegowosc.pensja.stanowiska, 
COUNT(ksiegowosc.premia.rodzaj) AS "Liczba przyznanych premii dla konkretnego stanowiska"
FROM ksiegowosc.premia 
INNER JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii
RIGHT JOIN ksiegowosc.pensja
    ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
GROUP BY ksiegowosc.pensja.stanowiska;

--p)
ALTER TABLE ksiegowosc.godziny DROP CONSTRAINT godziny_id_pracownika_fkey;
ALTER TABLE ksiegowosc.wynagrodzenie DROP CONSTRAINT wynagrodzenie_id_pracownika_fkey;

DELETE FROM ksiegowosc.pracownicy
USING ksiegowosc.wynagrodzenie, ksiegowosc.pensja
WHERE ksiegowosc.wynagrodzenie.id_pracownika = ksiegowosc.pracownicy.id_pracownika
  AND ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
  AND ksiegowosc.pensja.kwota < '1200';
  
SELECT * FROM ksiegowosc.pracownicy 
ORDER BY ksiegowosc.pracownicy.id_pracownika;





--ĆWICZENIA 6B ZAPYTANIA 

--a)
UPDATE ksiegowosc.pracownicy SET telefon = '(+48)'|| telefon;          
SELECT * FROM ksiegowosc.pracownicy

--b)
UPDATE ksiegowosc.pracownicy 
SET telefon =
SUBSTR(telefon, 1, 8) || '-' ||
SUBSTR(telefon, 9, 3) || '-' ||
SUBSTR(telefon, 12, 3)

SELECT * FROM ksiegowosc.pracownicy

--c)
SELECT 
       ksiegowosc.pracownicy.id_pracownika,
	   UPPER(ksiegowosc.pracownicy.imie) AS imie,
	   UPPER(ksiegowosc.pracownicy.nazwisko) AS nazwisko, 
	   UPPER(ksiegowosc.pracownicy.adres) AS adres, 
	   ksiegowosc.pracownicy.telefon
FROM ksiegowosc.pracownicy
WHERE
    LENGTH(ksiegowosc.pracownicy.nazwisko) = 
(SELECT MAX(LENGTH(ksiegowosc.pracownicy.nazwisko)) FROM ksiegowosc.pracownicy)


--d)
SELECT 
	   MD5(ksiegowosc.pracownicy.id_pracownika::varchar(10)) AS id_pracownika, 
	   MD5(ksiegowosc.pracownicy.imie) AS imie, 
	   MD5(ksiegowosc.pracownicy.nazwisko) AS nazwisko, 
	   MD5(ksiegowosc.pracownicy.adres) AS adres, 
	   MD5(ksiegowosc.pracownicy.telefon) AS telefon,
	   MD5(ksiegowosc.pensja.kwota::varchar(10)) AS pensja
FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.wynagrodzenie
     ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
INNER JOIN ksiegowosc.pensja
     ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji 

--f)
SELECT
       ksiegowosc.pracownicy.id_pracownika,
       ksiegowosc.pracownicy.imie,
       ksiegowosc.pracownicy.nazwisko,
       ksiegowosc.pracownicy.adres,
       ksiegowosc.pracownicy.telefon,
       ksiegowosc.pensja.kwota AS pensja,
       ksiegowosc.premia.kwota AS premia
FROM ksiegowosc.pracownicy
LEFT JOIN ksiegowosc.wynagrodzenie
    ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensja
    ON ksiegowosc.wynagrodzenie.id_pensji = ksiegowosc.pensja.id_pensji
LEFT JOIN ksiegowosc.premia
    ON ksiegowosc.wynagrodzenie.id_premii = ksiegowosc.premia.id_premii
ORDER BY ksiegowosc.pracownicy.id_pracownika

--g)
SELECT 
CONCAT(
	'Pracownik ', 
     ksiegowosc.pracownicy.imie, ' ',
	 ksiegowosc.pracownicy.nazwisko, ' ',
	'w dniu ', 	ksiegowosc.godziny.data, ' ',
	'otrzymał pensję całkowitą na kwotę ',
	ksiegowosc.pensja.kwota::numeric + ksiegowosc.premia.kwota::numeric + ksiegowosc.godziny.liczba_nadgodzin*25,
	'zł, gdzie wynagrodzenie zasadnicze wynosiło: ',
	ksiegowosc.pensja.kwota, ', ',
	'premia: ', 
	ksiegowosc.premia.kwota, ', ',
    'nadgodziny: ', ksiegowosc.godziny.liczba_nadgodzin*25, 'zł')
	
FROM
     ksiegowosc.pracownicy
INNER JOIN ksiegowosc.wynagrodzenie 
     ON ksiegowosc.pracownicy.id_pracownika = ksiegowosc.wynagrodzenie.id_pracownika
LEFT JOIN ksiegowosc.pensja
     ON ksiegowosc.pensja.id_pensji = ksiegowosc.wynagrodzenie.id_pensji
LEFT JOIN ksiegowosc.premia
     ON ksiegowosc.premia.id_premii = ksiegowosc.wynagrodzenie.id_premii
LEFT JOIN ksiegowosc.godziny 
     ON ksiegowosc.godziny.id_godziny = ksiegowosc.wynagrodzenie.id_godziny	