/*
Ex39
Przy pomocy jednego zapytania wypisz numery zamowień i ilość książek
jakie zostały w ramach każdego zamówienia kupione.
*/

SELECT 
	zamowienia_id, 
    COUNT(*) AS ilosc_ksiazek
FROM ksiazki, koszyk 
WHERE ksiazki.id = ksiazki_id 
GROUP BY zamowienia_id;

/*
Ex41
Wylistuj numery zamowien i zamowine ksiazki
*/

 SELECT 
	zamowienia_id
	,tytul
FROM koszyk ko
JOIN ksiazki ks
ON ko.ksiazki_id = ks.id;



