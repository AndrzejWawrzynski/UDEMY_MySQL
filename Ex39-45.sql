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