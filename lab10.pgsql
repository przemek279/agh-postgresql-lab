-- Lab 10

-- 10.1

SELECT DISTINCT nazwa 
FROM pudelka NATURAL JOIN zawartosc 
WHERE idczekoladki 
  IN (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3);
 
SELECT nazwa 
FROM czekoladki 
WHERE koszt = (SELECT MAX(koszt) FROM czekoladki);


SELECT p.nazwa, idpudelka 
FROM (SELECT idczekoladki FROM czekoladki ORDER BY koszt LIMIT 3) 
  AS ulubioneczekoladki 
NATURAL JOIN zawartosc 
NATURAL JOIN pudelka p;
 
SELECT nazwa, koszt, (SELECT MAX(koszt) FROM czekoladki) AS MAX FROM czekoladki;




-- 10.2



-- 10.3

SELECT nazwa, ulica, miejscowosc FROM klienci


SELECT nazwa, opism cena FROM czekoladki
Where koszt > 0;

