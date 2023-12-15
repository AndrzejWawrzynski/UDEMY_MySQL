/*
Ex12
Wybierz z tabeli customer dostępnej w bazie sakila oraz wylistuj przy pomocy aliasow: 
Imie i Nazwisko użytkownika, jego adres email oraz datę rejestracji (przyjmij date utworzenia z bazy).
Ogranicz wynik do 15 użytkowników rozpoczynając od użytkownika 100 (Robin Hayes).
Zwróć uwagę, ze kiedy nasz alias jest jednoczłonowy, nie ma potrzeby używania cudzysłowu.
*/

SELECT
	first_name AS Imie,
	last_name AS Nazwisko,
	email AS 'adres e-mail',
	create_date AS 'data rejestracji'
FROM customer
LIMIT 99,15;

/*
Ex13
Zaktualizuj adres email użytkownika Amy Lopez (sakila.customer, znajduje się na 32 pozycji) 
na: Lopez.A@yahoo.com 
*/

USE sakila;
UPDATE customer SET email = 'Lopez.A@yahoo.com' WHERE customer_id = 32; 

/*
Ex14
Przeanalizuj strukturę pliku ksiazki.csv. Przygotuj schemat tabeli o nazwie ksiazki, 
następnie wczytaj do niej wszystkie dane. Dla zachowania czystości środowiska, przygotuj wcześniej nową bazę danych.
W pliku znajduje się dwanaście kolumn: Autor książki, Tytuł, Rok publikacji, Numer ISBN, średnia ocena książki, 
liczba osób oceniających, liczba komentarzy, liczba ocen 1, 2, 3, 4 i 5 gwiazdkowych. 
W pierwszym wierszu znajduje się spis nazw kolumn, pola rozdzielone są średnikami 
a rating jest w liczbie dziesiętnej z 2 miejscami po przecinku i przecinkiem jako separatorem dziesiętnym. 
Plik nie zawiera kolumny ID!
*/

CREATE DATABASE ksiegarnia; 

USE ksiegarnia;

CREATE TABLE ksiazki
(
	id INT AUTO_INCREMENT PRIMARY KEY, 
	autor VARCHAR(50),
	tytul VARCHAR(150),
	rok_wydania INT,
	isbn CHAR(13),
	rating DEC(3,2),
	ratings_no INT,
	reviews_no INT,
	star_1 INT,
	star_2 INT,
	star_3 INT,
	star_4 INT,
	star_5 INT
);

LOAD DATA INFILE '/usr/local/mysql/ksiazki.csv' -- tu podaj sciezke dostepu do pliku na swoim komputerze
INTO TABLE ksiazki
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(autor, tytul, rok_wydania, isbn, @rating, ratings_no, reviews_no, star_1, star_2, star_3, star_4, star_5)
SET rating = REPLACE(@rating, ',', '.');

SELECT * FROM ksiazki;

/*
Ex15
Zapisz do nowego pliku tytuł książki oraz rok wydania. Użyj takiego formatowania, 
aby tytuły nie były zapisane w cudzysłowiu a pola były rozdzielone przecinkami.
Sprawdź czy w tytule książki „Eat, pray, love” nie powstały żadne błędy 
w związku z zastosowaniem przecinków jako separatora pól i przecinków w nazwie książki.
*/

USE ksiegarnia;
SELECT tytul, rok_wydania
FROM ksiazki
INTO OUTFILE 'ksiazki2.csv'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n';

/*
W pliku 'ksiazki2.csv', w tytule książki „Eat, Pray, Love” dodane zostały znaki ucieczki '\', czyli backslash, 
aby zaznaczyć że jest to część pola z tekstem a nie separatory pól. (Eat\, pray\, love,2006)
*/

/*
Ex16
Wybierz 5 pierwszych liter autora każdej książki, następnie dodaj 3 kropki, myślnik (ze spacjami) 
oraz 10 pierwszych liter tytułu książki. Całość zakończ ponownie 3 kropkami.
Dla pierwszego przypadku wynik powinien być następujący: Kathr... - The Help...
*/

SELECT
	CONCAT_WS
	(
		' - ',
		CONCAT 
		(
			SUBSTRING(autor, 1, 5),
            '...'
		),
		CONCAT
		(
			SUBSTRING(tytul, 1, 10),
            '...'
		)
    )
FROM ksiazki;

/*
Ex17
Rozbuduj nieco przykład z pokemonizacją tytułów książek. Wylistuj 15 pierwszych książek, 
ale w ich tytułach zamień litery według następującego schematu: e->3 a->4 t->7 b->8 s->5
Użyj do tego jednego zapytania.
*/

SELECT
	REPLACE 
    (
		REPLACE 
        (
			REPLACE 
            (
				REPLACE 
                (
					REPLACE 
                    (
						tytul,
						'e', '3'
					),
                    'a', '4'
				),
                't', '7'
			),
            'b', '8'
		),
        's', '5'
	)
FROM ksiazki 
LIMIT 15;

/*
Ex18
Wypisz wszystkie przypadki imion z listy autorów (zastosuj formatowanie małą literą) 
oraz podaj ich długość (ilość znaków).
*/

SELECT 
	DISTINCT SUBSTRING_INDEX(LOWER(autor), ' ', 1) AS imie, 
    CHAR_LENGTH(SUBSTRING_INDEX(autor, ' ', 1)) AS dlugosc 
FROM ksiazki;

/*
Ex19
Podaj tytuły oraz nazwiska autorów 15 najczęściej ocenianych książek.
*/

SELECT 
	tytul AS tytuł, 
    SUBSTRING_INDEX(autor, ' ', -1) AS nazwisko 
FROM ksiazki 
ORDER BY rating DESC 
LIMIT 15;

/*
Ex20
Wyszukaj wszystkie książki, które mają w tytule słowo „the”.
*/

SELECT tytul 
FROM ksiazki 
WHERE tytul LIKE '%the%';

/*
Ex21
Wyszukaj wszystkich autorów których nazwiska mają dokładnie 6 liter 
(spróbuj zastosować dwa różne rozwiązania).
*/

SELECT SUBSTRING_INDEX(autor, ' ', -1) AS nazwisko 
FROM ksiazki 
WHERE SUBSTRING_INDEX(autor, ' ', -1) LIKE '______';

SELECT SUBSTRING_INDEX(autor, ' ', -1) AS nazwisko 
FROM ksiazki 
WHERE CHAR_LENGTH(SUBSTRING_INDEX(autor, ' ' , -1)) = 6;

/*
Ex22
Wypisz wielkimi literami wszystkie imiona autorów zaczynające się na literę E (bez powtórzeń).
*/

SELECT DISTINCT SUBSTRING_INDEX(UPPER(autor), ' ', 1) AS imie 
FROM ksiazki 
WHERE autor LIKE 'E%';


