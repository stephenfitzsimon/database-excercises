USE employees;

-- 2: 709 employees
SELECT COUNT(*) FROM employees WHERE first_name IN ('Irena', 'Vidya', 'Maya');

-- 3: 709 employees, matches Q2
SELECT COUNT(*) FROM employees WHERE first_name = 'Irena' OR first_name = 'Vidya' OR first_name = 'Maya';

-- 4: 441 returns
DESCRIBE employees;
SELECT COUNT(*) FROM employees 
	WHERE (first_name = 'IRENA' OR first_name = 'Vidya' OR first_name = 'Maya') 
		AND gender='M';

DESCRIBE employees;
SELECT COUNT(*) FROM employees 
	WHERE gender='M'
		AND (first_name = 'IRENA' OR first_name = 'Vidya' OR first_name = 'Maya');

-- 5: 7330 returns
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE 'E%';
    
-- 6: 30723 returns
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE 'E%' OR last_name LIKE '%e';
-- returns 23393
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE '%e' AND last_name NOT LIKE 'E%';
    
-- 7: 899 returns
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE 'E%' AND last_name LIKE '%e';
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE 'E%E';
-- returns 24292 
SELECT COUNT(*) FROM employees
	WHERE last_name LIKE '%e';
    
-- 8: 135214 returns
SELECT COUNT(*) FROM employees WHERE hire_date >= '1990-01-01' AND hire_date <= '1999-12-31';
SELECT COUNT(*) FROM employees WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';
-- alt solution covered in class
SELECT COUNT(*) FROM employees WHERE hire_date LIKE '199%';
SELECT COUNT(*) FROM employees WHERE hire_date LIKE '199_-__-__';

-- 9: 842 returns
DESCRIBE employees;
SELECT COUNT(*) FROM employees WHERE birth_date LIKE '____-12-25';

-- 10: 362 returns
SELECT COUNT(*) FROM employees
	WHERE birth_date LIKE '____-12-25'
		AND hire_date BETWEEN '1990-01-01' AND '1999-12-31';

-- 11: 1873 returns
SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%';

-- 12: 547 returns
SELECT COUNT(*) FROM employees WHERE last_name LIKE '%q%' AND NOT last_name LIKE '%qu%';