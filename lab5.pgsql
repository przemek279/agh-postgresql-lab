-- Lab 5 

-- 5.1

SELECT count(*) FROM czekoladki;

SELECT count(*) FROM czekoladki
WHERE nadzienie IS NOT NULL;

-- or

SELECT count(nadzienie) FROM czekoladki;

SELECT p.idpudelka, p.nazwa, sum(z.sztuk) from zawartosc z
JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka
ORDER BY 3 DESC
LIMIT 1;

SELECT p.nazwa, p.idpudelka, sum(z.sztuk) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka
ORDER BY 3 DESC;


SELECT p.nazwa, p.idpudelka, sum(z.sztuk) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY p.idpudelka
ORDER BY 3 DESC;

SELECT p.nazwa, p.idpudelka, sum(z.sztuk) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.czekolada ILIKE '%mleczna%'
GROUP BY p.idpudelka
ORDER BY 3 DESC;

-- 5.2

SELECT p.nazwa, p.idpudelka, sum(z.sztuk * c.masa) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 3 DESC;


SELECT p.nazwa, p.idpudelka, sum(z.sztuk * c.masa) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 3 DESC
LIMIT 1;


SELECT sum(z.sztuk * c.masa) / count(DISTINCT p.idpudelka) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki);


SELECT p.nazwa, sum(z.sztuk * c.masa) / sum(z.sztuk) FROM zawartosc z
JOIN pudelka p USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY p.idpudelka
ORDER BY 2 DESC;


-- 5.3

SELECT count(idzamowienia), datarealizacji FROM zamowienia
GROUP BY datarealizacji
ORDER BY 2;


SELECT count(*) FROM zamowienia;


SELECT sum(p.cena * a.sztuk) FROM pudelka p
JOIN artykuly a USING(idpudelka)
JOIN zamowienia z USING(idzamowienia);


SELECT k.idklienta, k.nazwa, count(z.idzamowienia), sum(p.cena * a.sztuk) FROM klienci k
JOIN zamowienia z USING(idklienta)
JOIN artykuly a USING(idzamowienia)
JOIN pudelka p USING(idpudelka)
GROUP BY k.idklienta
ORDER BY 4 DESC;



-- 5.4


SELECT c.idczekoladki, c.nazwa, count(c.idczekoladki) FROM czekoladki c
JOIN zawartosc z USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY 3 DESC;



SELECT p.idpudelka, p.nazwa, count(c.idczekoladki) FROM pudelka p
JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
WHERE c.orzechy IS NULL
GROUP BY p.idpudelka
ORDER BY 3 DESC;


SELECT c.idczekoladki, c.nazwa, count(p.idpudelka) FROM pudelka p
JOIN zawartosc z USING(idpudelka)
JOIN czekoladki c USING(idczekoladki)
GROUP BY c.idczekoladki
ORDER BY 3;


SELECT p.idpudelka, p.nazwa, count(p.idpudelka) FROM pudelka p
JOIN artykuly a USING(idpudelka)
JOIN zamowienia z USING(idzamowienia)
GROUP BY p.idpudelka
ORDER BY 3 DESC;


-- 5.5

SELECT count(*), date_part('Quarter', datarealizacji), date_part('Year', datarealizacji) FROM zamowienia
GROUP BY 3, 2;


SELECT count(*), date_part('Month', datarealizacji), date_part('Year', datarealizacji) FROM zamowienia
GROUP BY 3, 2;


SELECT count(*), date_part('week', datarealizacji), date_part('Year', datarealizacji) FROM zamowienia
WHERE datarealizacji IS NULL
GROUP BY 3, 2;

-- or jeśli chodzi o zreaizowane

SELECT count(*), date_part('week', datarealizacji), date_part('Year', datarealizacji) FROM zamowienia
GROUP BY 3, 2;


SELECT k.miejscowosc, count(z.idzamowienia) FROM zamowienia z
JOIN klienci k USING(idklienta)
GROUP BY k.miejscowosc
ORDER BY 2;

-- 5.6

SELECT p.nazwa, sum(c.masa * z.sztuk) * p.stan from czekoladki c
JOIN zawartosc z USING(idczekoladki)
JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka;

SELECT sum(cena * stan) FROM pudelka;

-- 5.7

SELECT p.nazwa, p.cena - sum(c.koszt * z.sztuk)  from czekoladki c
JOIN zawartosc z USING(idczekoladki)
JOIN pudelka p USING(idpudelka)
GROUP BY p.idpudelka;



SELECT  sum(Zysk.zysk * a.sztuk) FROM artykuly a
JOIN (
    SELECT p.idpudelka, p.cena - sum(c.koszt * z.sztuk) AS zysk
    FROM    pudelka p
            JOIN zawartosc z USING(idpudelka)
            JOIN czekoladki c USING(idczekoladki)
    GROUP BY p.idpudelka
) AS Zysk USING(idpudelka);


SELECT SUM(Zysk.zysk)
FROM (
    SELECT (p.cena - sum(c.koszt * z.sztuk)) * p.stan AS zysk
    FROM    pudelka p
            JOIN zawartosc z USING(idpudelka)
            JOIN czekoladki c USING(idczekoladki)
    GROUP BY p.idpudelka
) AS Zysk;


-- 5.8

SELECT row_number() OVER (ORDER BY idpudelka), idpudelka FROM pudelka;