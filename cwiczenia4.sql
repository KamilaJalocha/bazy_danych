--utworzenie bazy danych
CREATE DATABASE firma;

--utworzenie schematu 
CREATE SCHEMA rozliczenia;

--dodanie tabel
CREATE TABLE rozliczenia.pracownicy (
id_pracownika INT PRIMARY KEY NOT NULL,
imie VARCHAR(30),
nazwisko VARCHAR(30) NOT NULL,
adres VARCHAR(50), 
telefon VARCHAR(10)
);

CREATE TABLE rozliczenia.godziny (
id_godziny INT PRIMARY KEY NOT NULL,
data DATE, 
liczba_godzin INT NOT NULL,
id_pracownika INT NOT NULL
);

CREATE TABLE rozliczenia.premie (
id_premii CHAR(3) PRIMARY KEY NOT NULL,
rodzaj VARCHAR(50),
kwota MONEY 
);

CREATE TABLE rozliczenia.pensje (
id_pensji INT PRIMARY KEY NOT NULL,
stanowiska VARCHAR(40),
kwota MONEY,
id_premii CHAR(3) NOT NULL
);


--utworzenie kluczy obcych 
ALTER TABLE rozliczenia.godziny 
ADD FOREIGN KEY (id_pracownika) REFERENCES rozliczenia.pracownicy(id_pracownika);

ALTER TABLE rozliczenia.pensje 
ADD FOREIGN KEY(id_premii) REFERENCES rozliczenia.premie(id_premii);


--wype³nienie tabel rekordami 
INSERT INTO rozliczenia.pracownicy VALUES(1, 'Anna', 'Witak', 'Akacjowa 3,Borki,92-111','777001001');
INSERT INTO rozliczenia.pracownicy VALUES(2, 'Helena', 'Miszak', 'Kasztanowa 23, Siedlce, 10-001','333000100');
INSERT INTO rozliczenia.pracownicy VALUES(3, 'Ewa', 'Koc', 'Maki 22, Warszawa, 22-005','754901111');
INSERT INTO rozliczenia.pracownicy VALUES(4, 'Andrzej', 'Góra', 'Stefanowska 35, Gdañsk, 11-788','767820121');
INSERT INTO rozliczenia.pracownicy VALUES(5, 'Helena', 'Fisiak', 'Wolna 12, Pomiechówek, 92-143','504021724');
INSERT INTO rozliczenia.pracownicy VALUES(6, 'Robert', 'Miszak', 'Krucza 12, Katowice, 70-746','733922034');
INSERT INTO rozliczenia.pracownicy VALUES(7, 'Karolina', 'Drabek', 'Krótka 56, Kraków, 31-098','883950903');
INSERT INTO rozliczenia.pracownicy VALUES(8, 'Maria', 'Skowronek', 'Polna 121, Gdañsk, 54-545','765945234');
INSERT INTO rozliczenia.pracownicy VALUES(9, 'Magdalena', 'Czu³owska', 'Kury³owicza 16, Kraków, 30-698','789675342');
INSERT INTO rozliczenia.pracownicy VALUES(10, 'Micha³', 'Wojak', 'Rzeczna 44, Siedlce, 11-373','693100946');

SELECT * FROM rozliczenia.pracownicy

INSERT INTO rozliczenia.godziny VALUES(1, '2019-03-10', '168', 1);
INSERT INTO rozliczenia.godziny VALUES(2, '2019-04-22', '152', 2);
INSERT INTO rozliczenia.godziny VALUES(3, '2020-10-15', '152', 3);
INSERT INTO rozliczenia.godziny VALUES(4, '2020-09-05', '184', 4);
INSERT INTO rozliczenia.godziny VALUES(5, '2019-05-09', '168', 5);
INSERT INTO rozliczenia.godziny VALUES(6, '2021-01-12', '168', 6);
INSERT INTO rozliczenia.godziny VALUES(7, '2021-06-17', '160', 7);
INSERT INTO rozliczenia.godziny VALUES(8, '2021-07-18', '150', 8);
INSERT INTO rozliczenia.godziny VALUES(9, '2022-02-04', '168', 9);
INSERT INTO rozliczenia.godziny VALUES(10, '2022-03-11', '184', 10);

SELECT * FROM rozliczenia.godziny

INSERT INTO rozliczenia.premie VALUES('P0','Pracownik miesi¹ca', '400'); 
INSERT INTO rozliczenia.premie VALUES('P1', 'Wyj¹tkowe osi¹gniêcia', '360');
INSERT INTO rozliczenia.premie VALUES('P2', 'Zawsze na stanowisku pracy', '200');
INSERT INTO rozliczenia.premie VALUES('P3', 'Motywacyjna', '100');
INSERT INTO rozliczenia.premie VALUES('P4', 'Efektywne zrealizowanie zadania', '250');
INSERT INTO rozliczenia.premie VALUES('P5', 'Przestrzeganie czasu pracy', '150');
INSERT INTO rozliczenia.premie VALUES('P6', 'Przestrzeganie regulaminu', '120');
INSERT INTO rozliczenia.premie VALUES('P7', 'Wydajnoœæ', '200');
INSERT INTO rozliczenia.premie VALUES('P8', 'Terminowe wykonywanie swoich obowi¹zków', '300');
INSERT INTO rozliczenia.premie VALUES('P9', 'Zaanga¿owanie w swoj¹ pracê', '350');

SELECT * FROM rozliczenia.premie

INSERT INTO rozliczenia.pensje VALUES(1, 'Manager', '6200', 'P0');
INSERT INTO rozliczenia.pensje VALUES(2, 'Analityk biznesowy', '11200', 'P1');
INSERT INTO rozliczenia.pensje VALUES(3, 'Dyrektor', '10270', 'P2');
INSERT INTO rozliczenia.pensje VALUES(4, 'Asystent handlowy', '5730', 'P3');
INSERT INTO rozliczenia.pensje VALUES(5, 'In¿ynier produkcji','6700', 'P4');
INSERT INTO rozliczenia.pensje VALUES(6, 'Kierownik biura', '4780', 'P5');
INSERT INTO rozliczenia.pensje VALUES(7, 'Sekretarka', '3700', 'P6');
INSERT INTO rozliczenia.pensje VALUES(8, 'Kierownik oddzia³u', '7300', 'P7');
INSERT INTO rozliczenia.pensje VALUES(9, 'Specjalista ds. produkcji', '5460', 'P8');
INSERT INTO rozliczenia.pensje VALUES(10, 'Specjalista ds. administracji', '4250', 'P9');

SELECT * FROM rozliczenia.pensje

--zadanie 5
SELECT nazwisko, adres FROM rozliczenia.pracownicy;

--zadanie 6 
--dzieñ tygodnia 
SELECT DATEPART (WEEKDAY, data) AS dzien_tygodnia FROM rozliczenia.godziny; 
--miesi¹c
SELECT DATEPART (MONTH, data) AS miesiac FROM rozliczenia.godziny;

--zadanie 7
EXEC sp_rename 'rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
ALTER TABLE rozliczenia.pensje ADD kwota_netto MONEY;
UPDATE rozliczenia.pensje SET kwota_netto = kwota_brutto * 0.81;
SELECT * FROM rozliczenia.pensje