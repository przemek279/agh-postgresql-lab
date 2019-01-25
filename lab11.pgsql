-- Lab 11

-- 11.1

-- Napisz funkcję masaPudelka wyznaczającą masę pudełka jako sumę masy czekoladek w nim 
-- zawartych. Funkcja jako argument przyjmuje identyfikator pudełka. 
-- Przetestuj działanie funkcji na podstawie prostej instrukcji select.

create or replace function masapudelka(id char(4))
returns numeric(7,2) as
$$
declare
    waga numeric(7,2);
begin
    select SUM(c.masa * z.sztuk) INTO waga FROM zawartosc z
    NATURAL JOIN czekoladki c
    WHERE z.idpudelka = id;

    return waga;
end;
$$
language plpgsql;


-- Napisz funkcję liczbaCzekoladek wyznaczającą liczbę czekoladek znajdujących się w pudełku.
--  Funkcja jako argument przyjmuje identyfikator pudełka. 
-- Przetestuj działanie funkcji na podstawie prostej instrukcji select. 


create or replace function liczbaCzekoladek(id char(4))
returns int as
$$
declare
    tmp int;
begin

    SELECT SUM(sztuk) into tmp FROM zawartosc
    WHERE idpudelka = id;

    return tmp;
end;
$$
language plpgsql;


-- 11.2


-- Napisz funkcję zysk obliczającą zysk jaki cukiernia uzyskuje ze sprzedaży jednego pudełka 
-- czekoladek, zakładając, że zysk ten jest różnicą między ceną pudełka, a kosztem wytworzenia
--  zawartych w nim czekoladek i kosztem opakowania (0,90 zł dla każdego pudełka).
--   Funkcja jako argument przyjmuje identyfikator pudełka. 
-- Przetestuj działanie funkcji na podstawie prostej instrukcji select.


create or replace function zysk(id char(4))
returns numeric(7,2) as
$$
declare
    cenaa numeric(7,2);
    koszt numeric(7,2);
begin

    SELECT cena into cenaa FROM pudelka
    WHERE idpudelka = id;

    SELECT SUM(c.koszt * z.sztuk) into koszt FROM zawartosc z
    NATURAL JOIN czekoladki c
    WHERE idpudelka = id;

    return (cenaa - koszt - 0.90);
end;
$$
language plpgsql;

-- Napisz instrukcję select obliczającą zysk jaki cukiernia uzyska ze 
-- sprzedaży pudełek zamówionych w wybranym dniu.
SELECT sum(zysk(a.idpudelka)) from artykuly a
NATURAL JOIN zamowienia
WHERE datarealizacji = '12-11-2013';

-- 11.3

-- Napisz funkcję sumaZamowien obliczającą łączną wartość zamówień złożonych przez klienta,
--  które czekają na realizację (są w tabeli Zamowienia). 
-- Funkcja jako argument przyjmuje identyfikator klienta. Przetestuj działanie funkcji.

create or replace function sumaZamowien(idK int)
returns numeric(7,2) as
$$
declare
    tmp numeric(7,2);
begin
    SELECT SUM(a.sztuk * p.cena) into tmp from zamowienia z
    NATURAL JOIN artykuly a
    NATURAL JOIN pudelka p
    WHERE z.idklienta = idK;

    return tmp;
end;
$$
language plpgsql;

--  Napisz funkcję rabat obliczającą rabat jaki otrzymuje klient składający zamówienie. 
-- Funkcja jako argument przyjmuje identyfikator klienta. Rabat wyliczany jest na podstawie
--  wcześniej złożonych zamówień w sposób następujący:

--     4 % jeśli wartość zamówień jest z przedziału 101-200 zł;
--     7 % jeśli wartość zamówień jest z przedziału 201-400 zł;
--     8 % jeśli wartość zamówień jest większa od 400 zł.


create or replace function rabat(id int)
returns numeric(7,2) as
$$
declare
    zam numeric(7,2);
begin
    zam := sumaZamowien(id);

    if zam > 400.0 then return 8;
    elseif zam > 200 then return 7;
    elseif zam > 100 then return 4;
    else return 0;
    end if;
end;
$$
language plpgsql;


-- 11.4



-- Napisz bezargumentową funkcję podwyzka, która dokonuje podwyżki kosztów produkcji czekoladek o:

--     3 gr dla czekoladek, których koszt produkcji jest mniejszy od 20 gr;
--     4 gr dla czekoladek, których koszt produkcji jest z przedziału 20-29 gr;
--     5 gr dla pozostałych.

-- Funkcja powinna ponadto podnieść cenę pudełek o tyle o ile zmienił się koszt produkcji
--  zawartych w nich czekoladek.

-- Przed testowaniem działania funkcji wykonaj zapytania, które umieszczą w plikach dane na temat 
-- kosztów czekoladek i cen pudełek tak, aby można było później sprawdzić poprawność działania 
-- funkcji podwyzka. Przetestuj działanie funkcji.


create or replace function podwyzka()
returns void as
$$
declare
    c czekoladki%rowtype;
    z zawartosc%rowtype;
    podwyzka numeric(7,2);
begin
    for c in (SELECT * FROM czekoladki)
    loop
        if c.koszt < 0.20 then podwyzka := 0.03;
        elseif c.koszt <= 0.29 then podwyzka := 0.04;
        else podwyzka := 0.05;
        end if;

        UPDATE czekoladki SET koszt = koszt + podwyzka
        WHERE idczekoladki = c.idczekoladki;

        for z in (SELECT * from zawartosc)
        loop
            UPDATE pudelka SET cena = cena + (z.sztuk * podwyzka)
            WHERE idpudelka = z.idpudelka 
            AND z.idczekoladki = c.idczekoladki;
        end loop;
    end loop;
            
end;
$$
language plpgsql;

-- 11.5



-- Napisz funkcję obnizka odwracająca zmiany wprowadzone w poprzedniej funkcji.
--  Przetestuj działanie funkcji.

create or replace function obnizka()
returns void as
$$
declare
    c czekoladki%rowtype;
    z zawartosc%rowtype;
    obnizka numeric(7,2);
begin
    for c in(SELECT * from czekoladki)
    loop
        if c.koszt < 0.23 then obnizka := 0.03;
        elseif c.koszt <= 0.33 then obnizka := 0.04;
        else obnizka := 0.05;
        end if;

        UPDATE czekoladki SET koszt = koszt - obizka
        WHERE idczekoladki = c.idczekoladki;

        for z in(SELECT * from zawartosc)
        loop
            UPDATE pudelka SET cena = cena - (z.sztuk * obnizka)
            WHERE idpudelka = z.idpudelka
            AND z.idczekoladki = c.idczekoladki;
        end loop;
    end loop;

end;
$$
language plpgsql;

-- 11.6


-- Napisz funkcję zwracającą informacje o zamówieniach złożonych przez klienta,
--  którego identyfikator podawany jest jako argument wywołania funkcji.
--   W/w informacje muszą zawierać: idzamowienia, idpudelka, datarealizacji. 
--   Przetestuj działanie funkcji.
--  Uwaga: Funkcja zwraca więcej niż 1 wiersz!

create temporary table zamowieniaKlientaType(
    zamowienia int,
    pudelka char(4),
    data_realizacji date
); 

create or replace function zamowieniaKlienta(id int)
returns setof zamowieniaKlientaType as
$$
declare
begin
    return query
    SELECT  z.idzamowienia, a.idpudelka, z.datarealizacji FROM zamowienia z
    NATURAL JOIN artykuly a
    WHERE z.idklienta = id;
end;
$$
language plpgsql;

-- Napisz funkcję zwracającą listę klientów z miejscowości, której nazwa podawana jest 
-- jako argument wywołania funkcji. 
-- Lista powinna zawierać: nazwę klienta i adres. Przetestuj działanie funkcji.

create or replace function listaKientow(miejs varchar(15))
returns table (
    nazwa varchar(130),
    ulica varchar(30),
    miejscowości varchar(15),
    kod char(6)
) as
$$
begin
    return query
    SELECT k.nazwa, k.ulica, k.miejscowosc, k.kod FROM klienci k
    Where k.miejscowosc = miejs;
end;
$$
language plpgsql;