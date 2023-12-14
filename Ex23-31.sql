/*
Ex23
Policz ile książek zostało opublikowanych w 2012r.
*/

SELECT COUNT(*) 
FROM ksiazki 
WHERE rok_wydania = 2012;

/*
Ex24
Policz ile książek zostało napisanych przez autora o imieniu John.
*/

SELECT COUNT(*) 
FROM ksiazki 
WHERE SUBSTRING_INDEX(autor, ' ', 1) LIKE 'John %';

/*
Ex25
Podaj liczbę książek wydanych w różnych latach, wynik podaj 
w kolejności malejącej według liczby ksiąźek.
*/

SELECT rok_wydania, COUNT(*) AS liczba_ksiazek
FROM ksiazki
GROUP BY rok_wydania
ORDER BY 2 DESC;

/*
Ex26
Podaj rok pierwszej publikacji książki każdego autora z bazy.
*/

SELECT autor, MIN(rok_wydania) 
FROM ksiazki
GROUP BY autor;

/*
Ex27
Podaj listę 10 najczęściej komentowanych autorów.
*/

SELECT autor, SUM(reviews_no)
FROM ksiazki
GROUP BY autor
ORDER BY 2
LIMIT 10;

/*
Ex28
Podaj imię i nazwisko autora oraz policz średnią liczbę jednej i pięciu gwiazdek każdego z nich, 
wyniki uporządkuj alfabetycznie według samych nazwisk autorów, a średnie zaokrąglij do liczby całkowitej.
*/

SELECT 
	autor,
    ROUND(AVG(star_1), 0),
	ROUND(AVG(star_5), 0)
FROM ksiazki
GROUP BY autor
ORDER BY SUBSTRING_INDEX(autor, ' ', -1);

/*
Ex29
Znajdź tytuły książek które zostały opublikowane nie wcześniej niż w 2005 roku oraz nie później niż w 2010.
*/

SELECT tytul
FROM ksiazki
WHERE rok_wydania BETWEEN 2005 AND 2010;

/*
Ex30
Oblicz średni rating książek wydanych pomiędzy 1990 a 2005, 
dla każdego roku wydawniczego, wyniki podaj chronologicznie.
*/

SELECT 
	rok_wydania,
    AVG(rating)
FROM ksiazki
WHERE rok_wydania BETWEEN 1990 AND 2005
GROUP BY 1
ORDER BY 1;

/*
Ex31
Policz ile każdy z autorów dostał po jednej gwiazdce dla wszystkich swoich książek, 
ale uwzględnij tylko te pozycje dla których oddano co najmniej milion głosów w sumie, 
lub umieszczono co najmniej 50 000 komentarzy.
*/

SELECT 
	autor, 
    SUM(star_1) 
FROM ksiazki 
WHERE ratings_no >=1000000 OR reviews_no >= 50000 
GROUP BY autor;

    