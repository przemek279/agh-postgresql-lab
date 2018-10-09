-- Lab 2

-- 2.1
-- SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY nazwa;
-- SELECT nazwa, ulica, miejscowosc FROM klienci ORDER BY miejscowosc DESC, nazwa ASC ;

-- SELECT nazwa, ulica, miejscowosc FROM klienci
--  WHERE miejscowosc IN ('Kraków', 'Warszawa') 
--  ORDER BY miejscowosc DESC, nazwa ASC ;

-- SELECT nazwa, ulica, miejscowosc FROM klienci
--  WHERE miejscowosc = 'Kraków' 
--  OR miejscowosc =  'Warszawa' 
--  ORDER BY miejscowosc DESC, nazwa ASC ;


-- SELECT nazwa, ulica, miejscowosc FROM klienci
-- ORDER BY miejscowosc DESC;

-- SELECT nazwa, ulica, miejscowosc FROM klienci
-- WHERE miejscowosc = 'Kraków'
-- ORDER BY nazwa;

-- --  2.2
-- SELECT nazwa, masa FROM czekoladki WHERE masa > 20;

-- SELECT nazwa, masa, koszt FROM czekoladki WHERE masa > 20 AND koszt > 0.25;

-- SELECT nazwa, czekolada, nadzienie, orzechy FROM czekoladki
--  WHERE (czekolada = 'mleczna' AND nadzienie = 'maliny') 
--  OR (orzechy = 'laskowe' AND czekolada != 'gorzka');

-- SELECT nazwa, koszt FROM czekoladki WHERE koszt > 0.25;

-- SELECT nazwa, czekolada FROM czekoladki WHERE czekolada IN('biała', 'mleczna');

-- -- 2.3 

-- SELECT 124 * 7 + 45;
-- SELECT 2 ^ 20;
-- SELECT |/3;
-- SELECT Pi();

-- 2.4

-- SELECT idczekoladki AS "IDCzekoladki", nazwa AS "Nazwa", masa AS "Masa", koszt AS "Koszt" 
-- FROM czekoladki
-- WHERE masa BETWEEN 15 AND 24;

-- SELECT idczekoladki AS "IDCzekoladki", nazwa AS "Nazwa", masa AS "Masa", koszt AS "Koszt" 
-- FROM czekoladki
-- WHERE koszt BETWEEN 0.25 AND 0.35;

-- SELECT idczekoladki AS "IDCzekoladki", nazwa AS "Nazwa", masa AS "Masa", koszt AS "Koszt" 
-- FROM czekoladki
-- WHERE (masa BETWEEN 25 AND 35) OR (koszt BETWEEN 0.15 AND 0.24);


-- 2.5

-- SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE orzechy IS NOT NULL;

-- SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie
--  FROM czekoladki WHERE orzechy IS NULL;

-- SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE orzechy IS NOT NULL 
--  OR nadzienie IS NOT NULL;

-- SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE czekolada IN('mleczna', 'biała')  
--  AND orzechy IS NOT NULL;

--  SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE czekolada NOT IN('mleczna', 'biała')  
--  AND (orzechy IS NOT NULL OR nadzienie IS NOT NULL);

--  SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE nadzienie IS NOT NULL;

--  SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE nadzienie IS NULL;

--   SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE nadzienie IS NULL AND orzechy IS NULL;


--   SELECT idczekoladki, nazwa, czekolada, orzechy, nadzienie FROM czekoladki
--  WHERE nadzienie IS NULL AND czekolada IN ('biała', 'mleczna');

-- -- 2.6

-- SELECT * FROM czekoladki WHERE masa BETWEEN 15 AND 24 OR koszt BETWEEN 0.15 AND 0.24;
-- SELECT * FROM czekoladki 
--     WHERE (masa BETWEEN 15 AND 24) 
--     AND (koszt BETWEEN 0.15 AND 0.24)
--     OR (masa BETWEEN 25 AND 35)
--     AND (koszt BETWEEN 0.25 AND 0.35);

-- SELECT * FROM czekoladki 
--  WHERE masa BETWEEN 15 AND 24 
--  AND koszt BETWEEN 0.15 AND 0.24;

-- SELECT * FROM czekoladki 
--  WHERE masa BETWEEN 25 AND 35 
--  AND koszt NOT BETWEEN 0.25 AND 0.35;

-- SELECT * FROM czekoladki 
--  WHERE masa BETWEEN 25 AND 35
--  AND koszt NOT BETWEEN 0.15 AND 0.24
--  AND koszt NOT BETWEEN 0.25 AND 0.35;

--  OR 

-- SELECT * FROM czekoladki
--  WHERE masa BETWEEN 25 AND 35
--  AND koszt NOT BETWEEN 0.15 AND 0.35;

-- -- 2.7

-- SELECT * FROM klienci;

-- 2.8

-- SELECT idczekoladki, nazwa, opis  FROM czekoladki;

\o zapytanie1.html
\H
SELECT idczekoladki, nazwa, opis  FROM czekoladki;