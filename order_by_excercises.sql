-- 2. 
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
	ORDER BY first_name;
-- FIRST ROW: Irena REUTANAUER
-- LAST ROW: Vidya SIMMEN

-- 3.
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
	ORDER BY first_name, last_name;
-- FIRST ROW: Irena ACTON
-- LASR ROW: Vidya ZWEIZIG

-- 4. 
SELECT * FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya') 
	ORDER BY last_name, first_name;
-- FIRST ROW: Irena ACTON
-- LAST ROW: Maya ZYDA

-- 5.
SELECT * FROM employees WHERE last_name LIKE 'E%E'
    ORDER BY emp_no;
-- returns 899 rocords
-- first row: 10021 Ramzi ERDE
-- last row: 499648 Tadahiro ERDE

-- 6.
SELECT * FROM employees WHERE last_name LIKE 'E%E'
    ORDER BY hire_date DESC;
-- returns 899 records
-- first row: Teiji ELDRIDGE
-- last row: Sergi ERDE

-- 7.
SELECT * FROM employees
	WHERE birth_date LIKE '____-12-25'
		AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
	ORDER BY hire_date DESC;
-- returns 362 records
-- first row: Khun BERNINI
-- last row: Alselm CAPPELLO