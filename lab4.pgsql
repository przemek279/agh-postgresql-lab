-- 4.1

-- Tylko klienci
SELECT k.nazwa FROM klienci k;

-- Iloczyn kartezjański,każdy klient z każdym zamówieniem
SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z;


SELECT k.nazwa, z.idzamowienia FROM klienci k, zamowienia z  
WHERE z.idklienta = k.idklienta;

-- To samo co wyżej tylko inna forma definiowania relacji, łączy tak samo nazwane 
-- pola o zgodnych typach
SELECT k.nazwa, z.idzamowienia FROM klienci k NATURAL JOIN zamowienia z;

-- To samo za pomocą podania jakie pola ma łączyć 
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
ON z.idklienta=k.idklienta;


-- To samo za pomocą join usign - podanie pola po jakich ma łączy
SELECT k.nazwa, z.idzamowienia FROM klienci k JOIN zamowienia z
USING (idklienta);


-- 4.2

SELECT z.datarealizacji, z.idzamowienia, k.nazwa FROM zamowienia z JOIN klienci k
USING(idklienta)
WHERE k.nazwa LIKE '% Antoni';


SELECT z.datarealizacji, z.idzamowienia, k.ulica FROM zamowienia z JOIN klienci k
USING(idklienta)
WHERE k.ulica LIKE '%_/_%';


SELECT z.datarealizacji, z.idzamowienia, k.miejscowosc FROM zamowienia z JOIN klienci k
USING(idklienta)
WHERE k.miejscowosc = 'Kraków'
AND date_part('month', z.datarealizacji) = 11;


-- 4.3

SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k
JOIN zamowienia z USING(idklienta)
WHERE date_part('year', z.datarealizacji) > (date_part('year', CURRENT_DATE) - 5);



SELECT DISTINCT k.nazwa, k.ulica, k.miejscowosc, p.nazwa FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
WHERE p.nazwa IN('Kremowa fantazja','Kolekcja jesienna');


SELECT  DISTINCT k.nazwa, k.ulica, k.miejscowosc FROM klienci k
JOIN zamowienia z USING(idklienta);

-- or  

SELECT  k.nazwa, k.ulica, k.miejscowosc, z.idzamowienia FROM klienci k
JOIN zamowienia z USING(idklienta);


SELECT k.nazwa, k.ulica, k.miejscowosc, z.idklienta FROM klienci k
LEFT JOIN zamowienia z USING(idklienta)
WHERE z.idklienta is NULL;


SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k
JOIN zamowienia z USING(idklienta)
WHERE z.datarealizacji BETWEEN '2013-11-1' AND '2013-11-30';


SELECT k.nazwa, k.ulica, k.miejscowosc, z.datarealizacji FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
WHERE p.nazwa IN('Kremowa fantazja','Kolekcja jesienna')
AND a.sztuk >= 2;

SELECT k.nazwa, k.ulica, k.miejscowosc, c.orzechy FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
JOIN zawartosc zaz USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE orzechy = 'migdały';


-- 4.4

SELECT p.nazwa, p.opis, c.nazwa, c.opis FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki);


SELECT p.nazwa, p.opis, p.idpudelka, c.nazwa, c.opis FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE p.idpudelka = 'heav';

SELECT p.nazwa, p.opis, c.nazwa, c.opis FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE p.nazwa ILIKE '%kolekcja%';



-- 4.5

SELECT p.nazwa, p.opis, p.cena, c.idczekoladki FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.idczekoladki = 'd09';


SELECT p.nazwa, p.opis, p.cena, c.nazwa FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.nazwa LIKE 'S%';

-- or 

SELECT DISTINCT p.nazwa, p.opis, p.cena  FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.nazwa LIKE 'S%';


SELECT DISTINCT p.nazwa, p.opis, p.cena, za.sztuk FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE za.sztuk >= 4;

SELECT DISTINCT p.nazwa, p.opis, p.cena, c.nadzienie FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.nadzienie = 'truskawki';

-- Do poprawy  !!BŁĘDNE!!
SELECT DISTINCT p.nazwa, p.opis, p.cena, c.czekolada FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada != 'gorzka';

-- Poprawione
(SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada != 'gorzka')
    EXCEPT
(SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada = 'gorzka');


SELECT DISTINCT p.nazwa, p.opis, p.cena, za.sztuk, c.nazwa FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE za.sztuk >= 3
AND c.nazwa = 'Gorzka truskawkowa';

-- Do poprawy !!BŁĘDNE!!
SELECT DISTINCT p.nazwa, p.opis, p.cena, c.orzechy FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy is NULL;

-- POPRAWIONE
(SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy is NULL)
    EXCEPT
(SELECT DISTINCT p.nazwa, p.opis, p.cena FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy is not NULL);


SELECT DISTINCT p.nazwa, p.opis, p.cena, c.nazwa FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
where c.nazwa = 'Gorzka truskawkowa';


SELECT DISTINCT p.nazwa, p.opis, p.cena, c.nadzienie FROM pudelka p
JOIN zawartosc za USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
where c.nadzienie is NULL;

-- 4.6 

SELECT c.idczekoladki, c.nazwa, c.koszt FROM czekoladki c
JOIN czekoladki c1 ON c.koszt > c1.koszt 
AND c1.idczekoladki = 'd08';


SELECT DISTINCT k.nazwa FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
JOIN
(klienci k1 JOIN zamowienia z1 USING(idklienta)
JOIN artykuly a1 USING(idzamowienia)
JOIN pudelka p1 USING(idpudelka))
ON p.idpudelka = p1.idpudelka 
AND k1.nazwa = 'Górka Alicja';

