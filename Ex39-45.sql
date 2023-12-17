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



