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

SELECT datarealizacji, idzamowienia FROM zamowienia 
WHERE idklienta IN (
  SELECT idklienta FROM klienci 
  WHERE nazwa iLike '%Antoni%'
  );

SELECT datarealizacji, idzamowienia FROM zamowienia 
WHERE idklienta IN (
  SELECT idklienta FROM klienci 
  WHERE ulica iLike '%/%'
  );

SELECT datarealizacji, idzamowienia FROM zamowienia 
WHERE idklienta IN (
  SELECT idklienta FROM klienci 
  WHERE miejscowosc iLike 'Kraków'
  )
AND date_part('month', datarealizacji) = 11
AND date_part('year', datarealizacji) = 2013;


-- 10.3

SELECT nazwa, ulica, miejscowosc FROM klienci
WHERE idklienta IN (
  SELECT idklienta FROM zamowienia
  WHERE datarealizacji = '2013-11-12'
);

--  złożyli zamówienia z datą realizacji w listopadzie 2013,

SELECT nazwa, ulica, miejscowosc FROM klienci
WHERE idklienta IN (
  SELECT idklienta from zamowienia
  WHERE date_part('month', datarealizacji) = 11
  AND date_part('year', datarealizacji) = 2013
);

-- zamówili pudełko Kremowa fantazja lub Kolekcja jesienna,
SELECT nazwa, ulica, miejscowosc FROM klienci k
WHERE k.idklienta IN (
  SELECT z.idklienta FROM zamowienia z
  NATURAL JOIN artykuly
  NATURAL JOIN pudelka p
  WHERE p.nazwa = 'Kremowa fantazja' 
  OR p.nazwa = 'Kolekcja jesienna'
);


--  zamówili co najmniej 2 sztuki pudełek Kremowa fantazja
--  lub Kolekcja jesienna w ramach jednego zamówienia,
SELECT nazwa, ulica, miejscowosc FROM klienci k
WHERE k.idklienta IN (
  SELECT z.idklienta FROM zamowienia z
  NATURAL JOIN artykuly a
  NATURAL JOIN pudelka p
  WHERE (p.nazwa = 'Kremowa fantazja' AND a.sztuk >= 2)
  OR (p.nazwa = 'Kolekcja jesienna' AND a.sztuk >= 2)
);

SELECT nazwa, opism cena FROM czekoladki
WHERE koszt > 0;

10.5
-- Wyświetl wartości kluczy głównych oraz nazwy czekoladek,
--  których koszt jest większy od czekoladki o wartości klucza głównego równej D08.

SELECT idczekoladki, nazwa FROM czekoladki c
WHERE c.koszt > all (
  SELECT koszt FROM czekoladki 
  WHERE idczekoladki = 'd08'
  );

--  Kto (nazwa klienta) złożył zamówienia na takie same czekoladki (pudełka) jak zamawiała Gorka Alicja.

SELECT DISTINCT klienci.nazwa FROM klienci
NATURAL JOIN zamowienia
NATURAL JOIN artykuly
JOIN pudelka p USING (idpudelka)
WHERE p.idpudelka IN (
  SELECT p.idpudelka FROM klienci k
  NATURAL JOIN zamowienia
  NATURAL JOIN artykuly
  JOIN pudelka p USING (idpudelka)
  WHERE k.nazwa = 'Górka Alicja'
);

-- 10.6

--  Wyświetl nazwę pudełka oraz ilość czekoladek, dla:
--  pudełka o największej liczbie czekoladek (bez użycia klauzuli limit),


SELECT SUM(z.sztuk), p.nazwa FROM pudelka p
NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING SUM(z.sztuk) >= ALL (
  SELECT SUM(z.sztuk) FROM pudelka p
  NATURAL JOIN zawartosc z
  GROUP BY p.idpudelka
);

SELECT SUM(z.sztuk), p.nazwa FROM zawartosc z
NATURAL JOIN pudelka p
GROUP BY z.idpudelka, p.idpudelka
HAVING SUM(z.sztuk) >= ALL (
  SELECT SUM(z.sztuk) FROM zawartosc z
  GROUP BY z.idpudelka
);


SELECT p.nazwa, SUM(z.sztuk)
FROM
    pudelka p
    NATURAL JOIN zawartosc z
GROUP BY p.idpudelka, p.nazwa
HAVING SUM(z.sztuk) >= ALL (
    SELECT SUM(z.sztuk)
    FROM
        pudelka p
        NATURAL JOIN zawartosc z
    GROUP BY p.idpudelka
);

-- pudełka o najmniejszej liczbie czekoladek (bez użycia klauzuli limit),

SELECT SUM(z.sztuk), p.nazwa FROM zawartosc z
NATURAL JOIN pudelka p
GROUP BY z.idpudelka, p.idpudelka
HAVING SUM(z.sztuk) <= ALL (
  SELECT SUM(z.sztuk) FROM zawartosc z
  GROUP BY z.idpudelka
);

SELECT SUM(z.sztuk), p.nazwa FROM zawartosc z
NATURAL JOIN pudelka p
GROUP BY z.idpudelka, p.idpudelka
HAVING SUM(z.sztuk) > (
  SELECT AVG((ff.f)) FROM (
    SELECT SUM(z.sztuk) as f FROM zawartosc z
    GROUP BY z.idpudelka
  ) as ff
);
