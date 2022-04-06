USE employees;

-- 1.
SELECT e.first_name, e.last_name, de.dept_no, de.to_date, de.from_date, 
		IF(de.to_date>NOW(), TRUE, FALSE) AS is_current_employee
	FROM employees AS e
		JOIN dept_emp AS de USING (emp_no);
        
-- 2.
SELECT first_name, last_name, 
		CASE 
			WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'A' AND 'H' THEN 'A-H'
			WHEN SUBSTRING(last_name, 1, 1) BETWEEN 'I' AND 'Q' THEN 'I-Q'
			ELSE 'R-Z'
		END AS alpha_group
	FROM employees;

-- 3.
SELECT MIN(birth_date)
	FROM employees;
SELECT MAX(birth_date)
	FROM employees;
-- earlist birth date is in the 1950s and last is in 1965
SELECT 
		COUNT(CASE WHEN YEAR(birth_date) BETWEEN '1950' AND '1959' THEN '1950s' ELSE NULL END) AS '1950s',
		COUNT(CASE WHEN YEAR(birth_date) BETWEEN '1960' AND '1969' THEN '1960s' ELSE NULL END) AS '1960s'
	FROM employees;
-- 182886 in 1950s and 117138 in 1960s
-- following to check
SELECT COUNT(birth_date) FROM employees;
-- 300024 total birthdays, the above sums up correctly.
-- alt solution in class
SELECT CONCAT(SUBSTR(birth_date, 1, 3), '0') AS decade, COUNT(*)
	FROM employees
	GROUP BY decade;

-- 4.
SELECT AVG(s.salary) AS dept_grp_avg, 
		CASE 
			WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D'
			WHEN d.dept_name IN ('Sales', 'Marketing') THEN 'Sales & Marketing'
			WHEN d.dept_name IN ('Production', 'Quality Management') THEN 'Prod & QM'
			WHEN d.dept_name IN ('Finance','Human Resources') THEN 'Finance & HR'
			ELSE 'Customer Service'
		END AS dept_grp
	FROM salaries AS s
		JOIN dept_emp AS de USING (emp_no)
        JOIN departments AS d USING (dept_no)
	WHERE s.to_date > NOW() AND de.to_date > NOW()
	GROUP BY dept_grp;