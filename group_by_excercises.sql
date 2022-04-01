USE employees;

-- 2.
SELECT DISTINCT title FROM titles;

-- 3. 
SELECT last_name FROM employees
	GROUP BY last_name
	HAVING last_name LIKE 'E%e';
-- a DISTINCT here would be redundant:
SELECT DISTINCT last_name FROM employees
	GROUP BY last_name
	HAVING last_name LIKE 'E%e';
-- class review solution: can also use a where:
SELECT last_name FROM employees
	WHERE last_name LIKE 'E%e'
	GROUP BY last_name;
    
-- 4. 
SELECT last_name, first_name FROM employees
	GROUP BY last_name, first_name
	HAVING last_name LIKE 'E%e';
-- class solution, use a where
SELECT last_name, first_name FROM employees
	WHERE last_name LIKE 'E%e'
	GROUP BY last_name, first_name;
    
-- 5.
SELECT DISTINCT last_name FROM employees
	GROUP BY first_name, last_name
    HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';
/* 
'Chleq'
'Lindqvist'
'Qiwen'
*/

-- 6.
SELECT COUNT(last_name), last_name FROM employees
	GROUP BY last_name
    HAVING last_name LIKE '%q%' AND last_name NOT LIKE '%qu%';

-- 7.
SELECT COUNT(*), gender, first_name FROM employees
	GROUP BY first_name, gender
    HAVING first_name IN ('Irena', 'Vidya', 'Maya')
    ORDER BY gender, first_name;
-- can use a where
SELECT COUNT(*), gender, first_name FROM employees
	WHERE first_name IN ('Irena', 'Vidya', 'Maya')
	GROUP BY first_name, gender
    ORDER BY gender, first_name;
    
-- 8. 
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)))
		AS username, COUNT(*)
	FROM employees
    GROUP BY username
    ORDER BY username;
-- display repeated usernames
SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1), SUBSTR(last_name, 1, 4), '_', SUBSTR(birth_date, 6, 2), SUBSTR(birth_date, 3, 2)))
		AS username, COUNT(*)
	FROM employees
    GROUP BY username
    HAVING COUNT(*) > 1
    ORDER BY COUNT(*) DESC;

-- 9.
-- a.
SELECT emp_no, AVG(salary)
	FROM salaries
    GROUP BY emp_no;
/* SELECT e.emp_no, AVG(salaries.salary)
	FROM employees AS e JOIN salaries USING (emp_no)
    GROUP BY emp_no;
*/
-- b.
SELECT dept_no, COUNT(emp_no)
	FROM dept_emp
    GROUP BY dept_no;
-- c.
SELECT emp_no, COUNT(salary)
	FROM salaries
    GROUP BY emp_no;
-- d.
SELECT emp_no, MAX(salary)
	FROM salaries
    GROUP BY emp_no;
-- e.
SELECT emp_no, MIN(salary)
	FROM salaries
    GROUP BY emp_no;
-- f.
SELECT emp_no, STDDEV(salary)
	FROM salaries;
-- g. 
SELECT emp_no, MAX(salary)
	FROM salaries
    GROUP BY emp_no
    HAVING MAX(salary) > 150000;
-- h.
SELECT emp_no, AVG(salary)
	FROM salaries
    GROUP BY emp_no
    HAVING AVG(salary) BETWEEN 80000 AND 90000;

