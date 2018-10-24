-- Lab 3
--  3.1

SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE datarealizacji BETWEEN '2013-11-12' AND '2013-11-20';

SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE datarealizacji BETWEEN '2013-12-01' AND '2013-12-06' 
 OR datarealizacji BETWEEN '2013-12-15' AND '2013-12-20';


SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE datarealizacji BETWEEN '2013-12-1' AND '2013-12-31';


SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE date_part('month', datarealizacji) = 11
 AND date_part('year', datarealizacji) = 2013;


SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE date_part('month', datarealizacji) IN (11, 12) 
 AND date_part('year', datarealizacji) = 2013;

SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE date_part('day', datarealizacji) IN (17, 18, 19);


SELECT idzamowienia, datarealizacji FROM zamowienia
 WHERE date_part('week', datarealizacji) IN (46, 47);

--  3.2

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa LIKE 'S%';

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa LIKE 'S%i';

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa LIKE 'S% m%';

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  LIKE 'A%' OR nazwa  LIKE 'B%' OR nazwa  LIKE 'C%';


SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  LIKE 'Orzech%' OR nazwa  LIKE '%orzech%';

    -- OR
SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  ILIKE '%orzech%';


SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  LIKE 'S%m%_';

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  LIKE '%maliny%' OR nazwa LIKE '%truskawki%';


SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa NOT SIMILAR TO '(D-K|S|T)%';


SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  LIKE 'Słod%';

SELECT idczekoladki, nazwa, czekolada,orzechy, nadzienie FROM czekoladki
    WHERE nazwa  NOT LIKE '_% %_';

-- 3.3

SELECT miejscowosc FROM klienci
    WHERE miejscowosc LIKE '_% %_';

SELECT nazwa, telefon FROM klienci
    WHERE telefon LIKE '0%';

SELECT nazwa, telefon FROM klienci
    WHERE telefon NOT LIKE '0%';

-- 3.4

(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24)
    UNION
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 AND 0.24);



(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 25 AND 35)
    EXCEPT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.25 AND 0.35);


((SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24)
    INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 AND 0.24))
    UNION
((SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 25 AND 35)
    INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.25 AND 0.35));



(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 15 AND 24)
    INTERSECT
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 AND 0.24);



(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE masa BETWEEN 25 AND 35)
    EXCEPT
((SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.15 AND 0.24)
    UNION
(SELECT idczekoladki, nazwa, masa, koszt
FROM czekoladki
WHERE koszt BETWEEN 0.29 AND 0.35));



-- 3.5

(SELECT idklienta FROM klienci)
    EXCEPT
(SELECT idklienta FROM zamowienia);


(SELECT idpudelka FROM pudelka)
    EXCEPT
(SELECT idpudelka FROM artykuly
WHERE idzamowienia IS NOT NULL);


SELECT nazwa FROM klienci 
WHERE nazwa ILIKE '%rz%'
    UNION
SELECT nazwa FROM czekoladki 
WHERE nazwa ILIKE '%rz%'
    UNION
SELECT nazwa FROM pudelka 
WHERE nazwa ILIKE '%rz%';


SELECT idczekoladki FROM czekoladki
    EXCEPT
SELECT idczekoladki FROM zawartosc
WHERE idpudelka IS NOT NULL;

3.6