/*
Ex36
Dla paru książek suma oddanych na nie głosów oraz suma głosów na poszczególną liczbę gwiazdek się nie zgadza. 
Zidentyfikuj tytuły książek o których jest mowa.
Napisz formułę, która sprawdzi powyższy warunek i dla każdej pozycji, dla której suma głosów (ratings_no) 
jest inna niż suma głosów na poszczególną ilość gwiazdek, zaktualizuje ten atrybut do liczby będącej prawidłową sumą.
*/

SELECT * 
FROM ksiazki 
WHERE star_1 + star_2 + star_3 + star_4 + star_5 != ratings_no;

UPDATE ksiazki 
SET ratings_no = (star_1 + star_2 + star_3 + star_4 + star_5) 
WHERE ratings_no != (star_1 + star_2 + star_3 + star_4 + star_5);

/*
Ex37
Podaj średnią ocenę książek każdego autora który ma na imię John, Dan, George lub William, 
uwzględnij tylko książki publikowane w latach nieparzystych.
*/

SELECT 
    autor, 
    AVG(rating) AS srednia_ocena 
FROM ksiazki 
WHERE SUBSTRING_INDEX(autor, ' ', 1) IN ('John', 'Dan', 'George', 'William') 
AND rok_wydania % 2 = 1 
GROUP BY autor;

/*
Ex38
Zastosuj formatowanie warunkowe aby przypisać liczbę gwiazdek książce według jej oceny. 
Zastosuj następujące kryteria :
***** dla rating > 4.5
****' dla rating > 4.0 i <= 4.5
****  dla rating > 3.5 i <= 4.0
***'  dla rating > 3.0 i <= 3.5
***   dla rating > 2.5 i <= 3.0
**'   dla rating > 2.0 i < 2.5 
*     dla pozostałych
Dodatkowo nadaj hasztagi książkom według epok literackich :
<= 1492 #sredniowiecze
<= 1520 #renesans
<= 1680 #barok
<= 1789 #oswiecenie
<= 1850 #romantyzm
<= 1880 #pozytywizm
<= 1918 #modernizm
<= 1939 #literaturamiedzywojenna 
po 1939 #literaturawspolczesna
oraz zaznacz czy użytkownicy częściej wybierają 1 do 4 gwiazdek 
(jako „przeważnie mniej niż 5 gwiazdek”) czy 5 gwiazdek („przeważnie 5 gwiazdek”).
Wszystkie polecenia wywołaj jednym zapytaniem, użyj różnych formuł warunkowych.
*/

SELECT 
	tytul,
    rating,
	CASE 
		WHEN rating > 4.5 THEN '*****'
		WHEN rating > 4.0 AND rating <= 4.5 THEN '****\''
		WHEN rating > 3.5 AND rating <= 4.0 THEN '****'
		WHEN rating > 3.0 AND rating <= 3.5 THEN '***\''
		WHEN rating > 2.5 AND rating <= 3.0 THEN '***'
		WHEN rating > 2.0 AND rating <= 2.5 THEN '**\''
		ELSE '*' 
    END AS gwiazdki,
    rok_wydania,
    CASE
	WHEN rok_wydania <= 1492 THEN '#sredniowiecze'
        WHEN rok_wydania BETWEEN 1492 AND 1520 THEN '#renesans'
	WHEN rok_wydania BETWEEN 1521 AND 1680 THEN '#barok'
        WHEN rok_wydania BETWEEN 1681 AND 1789 THEN '#oswiecenie'
	WHEN rok_wydania BETWEEN 1790 AND 1850 THEN '#romantyzm'
	WHEN rok_wydania BETWEEN 1851 AND 1880 THEN '#pozytywizm'
        WHEN rok_wydania BETWEEN 1881 AND 1918 THEN '#modernizm'
        WHEN rok_wydania BETWEEN 1919 AND 1939 THEN '#literaturamiedzywojenna'
        ELSE 'literaturawspolczesna'
	END AS hashtag,
    IF ((star_1 + star_2 + star_3 + star_4) > star_5,'przewaznie mniej niz 5 gwiazdek', 'przewaznie 5 gwiazdek') AS klasyfikacja
FROM ksiazki
ORDER BY tytul;

