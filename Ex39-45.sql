/*
BEFORE NEXT EXERCISES
Przeanalizuj strukturę plików zamowienia.csv i koszyk.csv. Przygotuj schematy tabel o nazwie zamowienia i koszyk, 
następnie wczytaj do nich wszystkie dane. Tabela zamowienia powinna posiadac klucz obcy do tabeli uzytkownicy,
a tabela koszyk dwa klucze obce, jeden do tabeli zamowienia a drugi do tabeli ksiazki.
*/

CREATE TABLE zamowienia
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    uzytkownicy_id INT,
	data_zamowienia TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (uzytkownicy_id) REFERENCES uzytkownicy(id)
);

CREATE TABLE koszyk
(
	zamowienia_id INT,
    ksiazki_id INT,
    FOREIGN KEY (zamowienia_id) REFERENCES zamowienia(id),
    FOREIGN KEY (ksiazki_id) REFERENCES ksiazki(id)
);

LOAD DATA INFILE '/usr/local/mysql/zamowienia.csv' -- tu podaj sciezke dostepu do pliku na swoim komputerze
INTO TABLE zamowienia
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(id, uzytkownicy_id); 

LOAD DATA INFILE '/usr/local/mysql/koszyk.csv' -- tu podaj sciezke dostepu do pliku na swoim komputerze
INTO TABLE koszyk
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(zamowienia_id, ksiazki_id);


/*
Ex39
Przy pomocy jednego zapytania wypisz numery zamówień i ilość książek
jakie zostały w ramach każdego zamówienia kupione.
*/

SELECT 
	zamowienia_id, 
	COUNT(*) AS ilosc_ksiazek
FROM ksiazki, koszyk 
WHERE ksiazki.id = ksiazki_id 
GROUP BY zamowienia_id;

/*
Ex40
Wypisz imię i nazwisko użytkowników oraz ksiązki jakie zamówili.
*/

SELECT
	uzytkownicy.imie,
	uzytkownicy.nazwisko,
	ksiazki.tytul 'tytuł książki'
FROM uzytkownicy
	JOIN zamowienia ON uzytkownicy.id = zamowienia.uzytkownicy_id
	JOIN koszyk ON zamowienia.id = koszyk.zamowienia_id
   	JOIN ksiazki ON koszyk.ksiazki_id = ksiazki.id;
    
/*
Ex41
Wylistuj numery zamówień i zamówione książki.
*/

 SELECT 
	zamowienia_id
	,tytul
FROM koszyk ko
JOIN ksiazki ks
ON ko.ksiazki_id = ks.id;

/*
Ex42
Znajdz numery zamówień w których zamówiono książkę o Harrym Potterze.
*/

SELECT
	zamowienia_id 'numer zamówienia'
	,tytul
FROM koszyk
JOIN ksiazki
ON ksiazki_id = ksiazki.id
WHERE tytul LIKE '%Harry Potter%';

/*
Ex43
Wypisz adresy email użytkowników, którzy nie złożyli jeszcze zamówienia w sklepie
aby wysłać im kupon promocyjny na pierwsze zakupy.
*/

SELECT 	
	email
FROM zamowienia z
RIGHT JOIN uzytkownicy u
ON z.uzytkownicy_id = u.id
WHERE z.id IS NULL;

-- OR

SELECT 	
	uzytkownicy.email
FROM zamowienia
RIGHT JOIN uzytkownicy
ON zamowienia.uzytkownicy_id = uzytkownicy.id
WHERE zamowienia.id IS NULL;

-- OR

SELECT 	
	uzytkownicy.email
FROM zamowienia
RIGHT JOIN uzytkownicy
ON zamowienia.uzytkownicy_id = uzytkownicy.id
WHERE zamowienia.uzytkownicy_id IS NULL;

/*
Ex44
Wylistuj wszystkich użytkowników z Warszawy i powiąż ich z zamówieniami.
*/

SELECT
	*
FROM uzytkownicy
LEFT JOIN zamowienia
ON uzytkownicy.id = zamowienia.uzytkownicy_id
WHERE uzytkownicy.adres_miasto LIKE 'Warszawa';

/*
Ex45
Wyświetl liste adresów email i ID użytkowników sklepu oraz przysługujacy im kupon zniżkowy 
wedlug nastepujacych zasad:
1. jeżeli użytkownik kupił kiedykolwiek ksiażke o Harrym Potterze, treść emaila powinna brzmieć:
„Wróć do Hogwartu! Kontynuuj przygody razem z Harrym i przyjaciółmi, wykorzystaj swój kupon rabatowy na książki i Harrym już dziś!",
a przysługujący kupon to: BACKTOHARRY 10%

2. jeżeli użytkownik kupił kiedykolwiek u nas książkę, ale nigdy o Harrym Potterze, to treść wiadomości
powinna brzmieć:
„Dołącz do uczniów Hogwartu i odkryj fascynujący świat czarów i magii. Poznaj Harrego i jego przyjaciół, 
kupuj książki z serii taniej z kodem rabatowym!",
a przysługujący kupon to: DISCOUERHARRY 20%

3. jeżeli użytkownik nigdy nie złożył u nas jeszcze zamówienia, to powinien otrzymać email 
o następującej treści:
„Witaj mugolu! Nie miałeś jeszcze okazji poznać naszego magicznego świata? Poznaj magię już dziś z kodem rabatowym 
na twoje pierwsze zamówienie. Dodaj do koszyka książki z serii o Harrym Potterze i korzystaj z magicznych rabatów!",
oraz kod FIRSTTIME 25%
*/

SELECT
	DISTINCT uzytkownicy.id,
	uzytkownicy.email AS 'email uzytkownika',
	CASE
		WHEN ksiazki.tytul LIKE '%Harry Potter%' THEN 'Wróc do Hogwartu!
			Kontynuuj przygody razem z Harrym i przyjaciółmi, wykorzystaj swöj kupon
			rabatowy na ksiazki i Harrym juz dzis!'
		WHEN zamowienia.uzytkownicy_id > 0 THEN 'Dolacz do uczniów Hogwartu 
			i odkryj fascynujacy swiat czarów i magii. Poznaj Harrego i jego
			przyjacioł, kupuj książki z serii taniej z kodem rabatowym!'
		ELSE 'Witaj mugolu! Nie miałes jeszcze okazji poznać naszego magicznego
			swiata? Poznaj magie już dziż z kodem rabatowym na twoje pierwsze
			zamówienie. Dodaj do koszyka książki z serii o Harrym Potterze 
			i korzystaj z magicznych rabatów!'
	END AS 'treść email',
	CASE
		WHEN ksiazki.tytul LIKE '%Harry Potter%' THEN 'BACKTOHARRY 10%'
		WHEN zamowienia.uzytkownicy_id > 0 THEN 'DISCOVERHARRY 20%'
		ELSE 'FIRSTTIME 25%'
	END AS kupon
FROM uzytkownicy
LEFT JOIN zamowienia ON uzytkownicy.id = zamowienia.uzytkownicy_id
LEFT JOIN koszyk ON koszyk.zamowienia_id = zamowienia.id
LEFT JOIN ksiazki ON ksiazki.id = koszyk.ksiazki_id;


