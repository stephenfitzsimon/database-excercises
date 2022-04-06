-- jemison_####
USE jemison_1755;

-- 1.
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT first_name, last_name, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
LIMIT 100;

SELECT * FROM employees_with_departments;


-- a.    
-- find length of first_name and last_name
SHOW CREATE TABLE employees_with_departments;
/* CREATE TEMPORARY TABLE `employees_with_departments` (
  `emp_no` int NOT NULL,
  `first_name` varchar(14) CHARACTER SET latin1 NOT NULL,
  `last_name` varchar(16) CHARACTER SET latin1 NOT NULL,
  `dept_no` char(4) CHARACTER SET latin1 NOT NULL,
  `dept_name` varchar(40) CHARACTER SET latin1 NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci */
-- adding the lengths of the two fields
ALTER TABLE employees_with_departments 
	ADD full_name VARCHAR(31); -- 31 because sum of both length and a space: 14+16+1=31
SELECT * FROM employees_with_departments;
    
-- b.
UPDATE employees_with_departments
	SET full_name = CONCAT(first_name,' ', last_name);
SELECT * FROM employees_with_departments;

-- c.
ALTER TABLE employees_with_departments
	DROP COLUMN first_name;
ALTER TABLE employees_with_departments
	DROP COLUMN last_name;
SELECT * FROM employees_with_departments;

-- d. 
-- concat the columns with al alias
CREATE TEMPORARY TABLE employees_with_departments_full_name AS
	SELECT dept_name, CONCAT(first_name, ' ' , last_name) AS full_name
	FROM employees.employees
	JOIN employees.dept_emp USING(emp_no)
	JOIN employees.departments USING(dept_no)
	LIMIT 100;
SELECT * FROM employees_with_departments_full_name;

-- 2. 
CREATE TEMPORARY TABLE sakila_pay AS 
	SELECT * FROM sakila.payment;
SHOW CREATE TABLE sakila_pay;
/* SELECT * FROM sakila_pay ORDER BY amount DESC;CREATE TEMPORARY TABLE `sakila_pay` (
  `payment_id` smallint unsigned NOT NULL DEFAULT '0',
  `customer_id` smallint unsigned NOT NULL,
  `staff_id` tinyint unsigned NOT NULL,
  `rental_id` int DEFAULT NULL,
  `amount` decimal(5,2) NOT NULL,
  `payment_date` datetime NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci */
ALTER TABLE sakila_pay ADD int_payment INT; 
UPDATE sakila_pay 
	SET int_payment = amount*(100);
SELECT * FROM sakila_pay;
ALTER TABLE sakila_pay DROP COLUMN amount;
ALTER TABLE sakila_pay RENAME COLUMN int_payment TO amount;
SELECT * FROM sakila_pay;

-- alt solution in class:
CREATE TEMPORARY TABLE sakila_pay_alt_solution AS 
	SELECT payment_id, customer_id, staff_id, rental_id, amount*100 AS pennie, payment_date
    FROM sakila.payment;
SELECT * FROM sakila_pay_alt_solution;
-- now change data type
ALTER TABLE sakila_pay_alt_solution MODIFY pennie int NOT NULL; -- this will truncate the decimals (but these are all zero)
SELECT * FROM sakila_pay_alt_solution;
    
-- 3.
-- query to get avg salary for dept
	SELECT d.dept_name, AVG(s.salary) AS dept_avg
		FROM employees.salaries AS s
			JOIN employees.dept_emp AS de USING(emp_no)
			JOIN employees.departments AS d USING (dept_no)
		WHERE s.to_date > NOW()
			AND de.to_date > NOW()
		GROUP BY de.dept_no;
-- make a salaries table with zscore
-- don't need the dept_no, but it might be easier to match other tables
CREATE TEMPORARY TABLE custom_salaries AS
	SELECT d.dept_name, de.dept_no, AVG(s.salary) AS dept_avg
		FROM employees.salaries AS s
			JOIN employees.dept_emp AS de USING(emp_no)
			JOIN employees.departments AS d USING (dept_no)
		WHERE s.to_date > NOW()
			AND de.to_date > NOW()
		GROUP BY de.dept_no;
SELECT * FROM custom_salaries;
-- add a column for the overall average salary
-- query to produce average query
SELECT AVG(s.salary)
	FROM employees.salaries AS s;
-- use double type to preserve accuracy?
ALTER TABLE custom_salaries ADD hist_avg DOUBLE;
UPDATE custom_salaries
	SET hist_avg = (SELECT AVG(s.salary)
						FROM employees.salaries AS s);
SELECT * FROM custom_salaries;
-- make a column for the std dev
ALTER TABLE custom_salaries ADD std_dev DOUBLE;
UPDATE custom_salaries
	SET std_dev = (SELECT STD(s.salary) 
					FROM employees.salaries AS s);
SELECT * FROM custom_salaries;
-- in class solution: make a temp table that contains hist mean and std, then join with table with dept_avg
-- select statement showing the z_score
SELECT dept_name, ((dept_avg-hist_avg)/std_dev) AS z_score
	FROM custom_salaries
    ORDER BY z_score DESC;
ALTER TABLE custom_salaries ADD z_score DOUBLE;
UPDATE custom_salaries
	SET z_score = ((dept_avg-hist_avg)/std_dev);
SELECT * FROM custom_salaries
	ORDER BY z_score DESC;
-- best department is sales and worst human resources

-- apply above but get the z_score for each employee then average by dept
-- this is an alternative interpretation of the question
SELECT s.emp_no, s.salary, de.dept_no
	FROM employees.salaries AS s
    JOIN employees.dept_emp AS de USING (emp_no)
    WHERE s.to_date > NOW()
    ORDER BY s.emp_no;
CREATE TEMPORARY TABLE salary_calc AS
	SELECT s.emp_no, s.salary, de.dept_no
		FROM employees.salaries AS s
		JOIN employees.dept_emp AS de USING (emp_no)
		WHERE s.to_date > NOW()
		ORDER BY s.emp_no;
SELECT * FROM salary_calc;
ALTER TABLE salary_calc ADD COLUMN hist_avg DOUBLE;
ALTER TABLE salary_calc ADD COLUMN hist_std DOUBLE;
UPDATE salary_calc
	SET hist_avg = (SELECT AVG(s.salary)
						FROM employees.salaries AS s);
UPDATE salary_calc
	SET hist_std = (SELECT STD(s.salary) 
					FROM employees.salaries AS s);
SELECT * FROM salary_calc;
ALTER TABLE salary_calc ADD z_score DOUBLE;
UPDATE salary_calc
	SET z_score = ((salary-hist_avg)/hist_std);
SELECT * FROM salary_calc;
-- get average z_score for the dept
SELECT AVG(z_score), dept_no
	FROM salary_calc
    GROUP BY dept_no
    ORDER BY AVG(z_score) DESC;
