-- Lab 3
--  3.1

-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE datarealizacji BETWEEN '2013-11-12' AND '2013-11-20';

-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE datarealizacji BETWEEN '2013-12-01' AND '2013-12-06' 
--  OR datarealizacji BETWEEN '2013-12-15' AND '2013-12-20';


-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE datarealizacji BETWEEN '2013-12-1' AND '2013-12-31';


-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE date_part('month', datarealizacji) = 11
--  AND date_part('year', datarealizacji) = 2013;


-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE date_part('month', datarealizacji) IN (11, 12) 
--  AND date_part('year', datarealizacji) = 2013;

-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE date_part('day', datarealizacji) IN (17, 18, 19);


-- SELECT idzamowienia, datarealizacji FROM zamowienia
--  WHERE date_part('week', datarealizacji) IN (46, 47);

--  3.2

