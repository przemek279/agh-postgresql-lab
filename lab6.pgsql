-- Lab 6 

-- 6.1

INSERT INTO czekoladki VALUES
('W98', 'Biały Kieł', 'biała', 'laskowe', 'marcepan', 'Rozpływające się w rękach i kieszeniach', 0.45, 20);


INSERT INTO klienci VALUES
(90, 'Matusiak Edward', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38');

INSERT INTO klienci VALUES
(91, 'Matusiak Alina', 'Kropiwnickiego 6/3', 'Leningrad', '31-471', '031 423 45 38');

INSERT INTO klienci VALUES
(92, 'Kimono Franek', 'Karateków 8', 'Mistrz', '30-029', '501 498 324');


INSERT INTO klienci 
    SELECT 93, 'Matusiak Iza', ulica, miejscowosc, kod, telefon FROM klienci 
    WHERE idklienta = 90;

SELECT * FROM klienci WHERE idklienta in(90,93);

-- 6.2

INSERT INTO czekoladki VALUES
('X91', 'Nieznana Nieznajoma', NULL,NULL, NULL, 'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0),
('M98', 'Mleczny Raj', 'Mleczna',NULL, NULL, 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

SELECT * FROM czekoladki WHERE idczekoladki IN ('X91','M98');


-- 6.3

DELETE FROM czekoladki WHERE idczekoladki IN ('X91','M98');

SELECT * FROM czekoladki WHERE idczekoladki IN ('X91','M98');

INSERT INTO czekoladki(idczekoladki, nazwa, opis, koszt, masa)
VALUES ('X91', 'Nieznana Nieznajoma', 'Niewidzialna czekoladka wspomagajaca odchudzanie.', 0.26, 0);

INSERT INTO czekoladki(idczekoladki, nazwa, czekolada, opis, koszt, masa)
VALUES ('M98', 'Mleczny Raj', 'Mleczna', 'Aksamitna mleczna czekolada w ksztalcie butelki z mlekiem.', 0.26, 36);

SELECT * FROM czekoladki WHERE idczekoladki IN ('X91','M98');


-- 6.4

UPDATE klienci SET nazwa = 'Nowak Iza' WHERE nazwa = 'Matusiak Iza';

SELECT * FROM klienci WHERE idklienta =93;


UPDATE czekoladki SET koszt = (koszt * 0.9)
WHERE idczekoladki IN('W98', 'M98', 'X91');

SELECT * FROM czekoladki
WHERE idczekoladki IN('W98', 'M98', 'X91');


UPDATE czekoladki SET koszt = (SELECT koszt FROM czekoladki WHERE idczekoladki = 'W98')
WHERE nazwa = 'Nieznana Nieznajoma';

SELECT * FROM czekoladki
WHERE idczekoladki = 'W98'
OR nazwa = 'Nieznana Nieznajoma';


UPDATE klienci set miejscowosc = 'Piotrograd'
WHERE miejscowosc = 'Leningrad';

SELECT * FROM klienci
WHERE miejscowosc = 'Piotrograd';


UPDATE czekoladki SET koszt = koszt + 0.15
WHERE idczekoladki LIKE '_9_' 
AND idczekoladki NOT LIKE '_90';

SELECT * FROM czekoladki 
WHERE idczekoladki LIKE '_9_' 
AND idczekoladki NOT LIKE '_90';



-- 6.5

DELETE FROM klienci
WHERE nazwa ILIKE 'Matusiak %';

DELETE FROM klienci
WHERE idklienta > 91;

DELETE FROM czekoladki
WHERE koszt >= 0.45
OR masa >= 36 
OR masa = 0;


-- 6.6


INSERT INTO pudelka VALUES
('new1', 'Wiśnia Mleczna', 'Wiśnie w czekoladzie.', 12.30, 300),
('new2', 'Malinowo', 'Maliny w każdedj możliwej postaci', 14.50,200);

INSERT INTO zawartosc VALUES
('new1', 'b01', 4),
('new1', 'b02', 3),
('new1', 'b03', 3),
('new1', 'b07', 1),
('new2', 'b04', 4),
('new2', 'b05', 4),
('new2', 'b06', 1),
('new2', 'b08', 4);


-- 6.6

DELETE FROM zawartosc
WHERE idpudelka IN ('new1', 'new2');
DELETE FROM pudelka
WHERE idpudelka IN ('new1', 'new2');

copy pudelka from stdin with (null '', delimiter '|');
new1|Wiśnia Mleczna|Wiśnie w czekoladzie.|12.30| 300
new2|Malinowo|Maliny w każdedj możliwej postaci|14.50|200
\.

copy zawartosc from stdin with (null '', delimiter '|');
new1|b01|4
new1|b02|3
new1|b03|3
new1|b07|1
new2|b04|4
new2|b05|4
new2|b06|1
new2|b08|4
\.


-- 6.8

UPDATE zawartosc SET sztuk = sztuk + 1
WHERE idpudelka in ('new1', 'new2');



UPDATE czekoladki SET czekolada = 'brak'
WHERE czekolada IS NULL;

UPDATE czekoladki SET orzechy = 'brak'
WHERE orzechy IS NULL;

UPDATE czekoladki SET nadzienie = 'brak'
WHERE nadzienie IS NULL;



UPDATE czekoladki SET czekolada = NULL
WHERE czekolada = 'brak';

UPDATE czekoladki SET orzechy = NULL
WHERE orzechy = 'brak';

UPDATE czekoladki SET nadzienie = NULL
WHERE nadzienie = 'brak';