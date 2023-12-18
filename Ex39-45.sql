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





