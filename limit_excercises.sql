-- 2.
SELECT DISTINCT last_name FROM employees
	ORDER BY last_name DESC
    LIMIT 10;
    
-- 3.
SELECT * FROM employees
	WHERE birth_date LIKE '____-12-25'
		AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY hire_date
    LIMIT 5;
-- Alselm CAPELLO, Utz MANDELL, Bouchung SCHREITER, Baocai KUSHNER, Petter STROUSTRUP

-- 4. 
SELECT * FROM employees
	WHERE birth_date LIKE '____-12-25'
		AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY hire_date
    LIMIT 5 OFFSET 45;
-- Assuming that the OFFSET is a multiple of the LIMIT, determine which page we are on by the following:
-- OFFSET = LIMIT*(PAGE-1)
-- to determine the page:
-- PAGE = OFFSET/LIMIT + 1
-- Assuming the OFFSET is not a multiple of the LIMIT, we can determine the PAGE the starting by
-- PAGE = (OFFSET-OFFSET%LIMIT)/LIMIT+1
-- I think?