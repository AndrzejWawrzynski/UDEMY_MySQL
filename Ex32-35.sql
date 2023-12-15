/*
Ex32
Jaki procent wśród książek o ocenie co najmniej 4, 
stanowią oceny pięciogwiazdkowe?
*/

SELECT 
	SUM(star_5)/SUM(ratings_no)*100 AS procent 
FROM ksiazki 
WHERE rating > 4;

/*
Ex33
Jaka jest średnia ocena dla autorów których nazwiska są krótsze niż 6 albo dłuższe niż 10 znaków?
*/

SELECT 
	autor, 
    ROUND(AVG(rating),2) AS srednia 
FROM ksiazki 
WHERE CHAR_LENGTH(SUBSTRING_INDEX(autor, ' ', -1)) NOT BETWEEN 6 AND 10 
GROUP BY autor 
ORDER BY srednia;

/*
Ex34
Dla każdego autora, dla każdego roku w którym opublikował książkę (lub książki) 
policz sumę komentarzy do tych pozycji, uwzględnij tylko pozycje, które miały co najmniej 600 tys. głosów, 
listę podaj posortowaną od Z do A.
*/

SELECT 
	autor, 
	rok_wydania, 
    SUM(reviews_no) AS 'suma komentarzy' 
FROM ksiazki 
WHERE ratings_no >= 600000 
GROUP BY autor, rok_wydania
ORDER BY 1 DESC;

/*
Ex35
Podaj listę autorów i tytułów książek wydanych w latach parzystych.
*/

SELECT
	autor,
    tytul,
    rok_wydania
FROM ksiazki
WHERE rok_wydania % 2 = 0;



