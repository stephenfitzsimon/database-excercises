USE employees;
DESCRIBE employees;

-- 2.
SELECT CONCAT(first_name, ' ', last_name) AS full_name 
	FROM employees
    WHERE last_name LIKE 'E%e';
    
-- 3. 
SELECT UPPER(CONCAT(first_name, ' ', last_name)) AS full_name 
	FROM employees
    WHERE last_name LIKE 'E%e';
    
-- 4.
SELECT CONCAT(first_name, ' ', last_name) AS full_name, DATEDIFF(CURDATE(), hire_date) AS days_employed FROM employees
	WHERE hire_date LIKE '199_-__-__'
		AND birth_date LIKE '____-12-25';
        
-- 5.
DESCRIBE salaries;
SELECT * FROM salaries;
-- get the salary info
SELECT MIN(salary) FROM salaries WHERE curdate() < to_date;
SELECT MAX(salary) FROM salaries WHERE curdate() < to_date;
-- to double check the answers
SELECT MIN(salary) FROM salaries;
SELECT MAX(salary) FROM salaries;
SELECT * FROM salaries ORDER BY salary DESC;

-- 6.
SELECT LOWER(
		CONCAT(
			SUBSTR(first_name, 1, 1), 
			SUBSTR(last_name, 1, 4), '_', 
			SUBSTR(birth_date, 6, 2), 
			SUBSTR(birth_date, 3, 2)))
		AS username,
		first_name, 
        last_name, 
        birth_date 
	FROM employees;