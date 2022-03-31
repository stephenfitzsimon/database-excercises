-- 2
USE albums_db;

-- 3
-- a: returns 31 rows
SELECT * FROM albums;
-- alt covered in class
SELECT COUNT(*) FROM albums;
-- b: 23 rows returned
SELECT DISTINCT artist FROM albums;
-- going off of the alt solution above
SELECT COUNT(DISTINCT artist) FROM albums;
-- c: primary key is id column
DESCRIBE albums;
-- d: earliest release 1967 and latest release 2011
-- info: https://www.w3schools.com/Sql/sql_orderby.asp
SELECT release_date FROM albums ORDER BY release_date;
-- using info from https://www.w3schools.com/Sql/sql_min_max.asp
SELECT MIN(release_date) FROM albums;
SELECT MAX(release_date) FROM albums;
-- probably best way to get multicolumns
-- info: https://www.w3schools.com/Sql/sql_top.asp and 
SELECT release_date, name, artist FROM albums ORDER BY release_date LIMIT 1;
SELECT release_date, name, artist FROM albums ORDER BY release_date DESC LIMIT 1;

-- 4
-- a: 'Dark side of the moon' and 'the wall'
SELECT name FROM albums WHERE artist='Pink Floyd';
-- b: 1967
SELECT release_date FROM albums WHERE name='Sgt. Pepper\'s Lonely Hearts Club Band';
-- c: Grunge, Alt Rock
SELECT genre FROM albums WHERE name='Nevermind';
-- d:
SELECT name, release_date FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- info from https://www.w3schools.com/Sql/sql_operators.asp
SELECT name, release_date FROM albums WHERE release_date>=1990 AND release_date <= 1999;
-- e: assuming that the sales float is in millions not singles
SELECT name FROM albums WHERE sales < 20;
-- f: the search is not very smart and looks for exact matches; so a string like "rock, prog rock" will not be matched.
SELECT name, genre FROM albums WHERE genre='Rock';
-- this will match any string that contains the string 'Rock' (this is in the next module)
SELECT name, genre FROM albums WHERE genre LIKE '%Rock%';
-- alt answer from Andrew in class
SELECT name, genre FROM albums WHERE genre='Rock'
	OR genre LIKE '%, Rock'
    OR genre LIKE 'Rock,%';