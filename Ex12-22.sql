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