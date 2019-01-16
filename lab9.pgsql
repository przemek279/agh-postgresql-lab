-- 9.1

CREATE SCHEMA kwiaciarnia;
set search_path to kwiaciarnia;

CREATE TABLE klienci(
    idklienta varchar(10) PRIMARY KEY,
    haslo varchar(10) CHECK(length(haslo) >= 4) NOT NULL,
    nazwa varchar(40) NOT NULL,
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(40) NOT NULL,
    email varchar(40),
    telefon varchar(16),
    fax varchar(16),
    nip char(13),
    regon char(9)
);

CREATE TABLE kompozycje(
    idkompozycji  char(5) PRIMARY KEY,
    nazwa varchar(40) NOT NULL,
    opis varchar(100),
    cena numeric(7,2) CHECK(cena >= 40.00),
    minimum int,
    stan int
);

CREATE TABLE odbiorcy(
    idodbiorcy serial PRIMARY KEY,
    nazwa varchar(40) NOT NULL,
    miasto varchar(40) NOT NULL,
    kod char(6) NOT NULL,
    adres varchar(40) NOT NULL
);


CREATE TABLE zamowienia(
    idzamowienia int PRIMARY KEY,
    idklienta varchar(10) references klienci(idklienta) NOT NULL,
    idodbiorcy int references odbiorcy(idodbiorcy) NOT NULL,
    idkompozycji char(5) references kompozycje(idkompozycji) NOT NULl,
    termin date NOT NULL,
    cena numeric(7,2),
    zaplacone boolean,
    uwagi varchar(200)
);

CREATE TABLE historia(
    idzamowienia int PRIMARY KEY,
    idklienta varchar(10),
    idkompozycji char(5),
    cena numeric(7,2),
    termin date
);

CREATE TABLE zapotrzebowanie(
    idkompozycji char(5) PRIMARY KEY references kompozycje(idkompozycji),
    data date
);