USE employees;

-- 1.
-- get hire date of employee 101010
SELECT hire_date FROM employees
	WHERE emp_no=101010;
-- a query to get current employees with emp_no=101010
SELECT emp_no, first_name, last_name, hire_date
	FROM employees
		JOIN dept_emp USING (emp_no)
	WHERE dept_emp.to_date > NOW()
		AND employees.hire_date=(SELECT hire_date FROM employees
									WHERE emp_no=101010);
                                    
-- 2.
-- list of emp_no with first name Aamod
SELECT emp_no
	FROM employees
    JOIN dept_emp USING (emp_no)
	WHERE first_name='Aamod' AND dept_emp.to_date > NOW();
-- get titles of employees in the above list
SELECT DISTINCT title
	FROM titles
	WHERE emp_no IN (SELECT emp_no
						FROM employees
						JOIN dept_emp USING (emp_no)
						WHERE first_name='Aamod' AND dept_emp.to_date > NOW());
                        
-- 3.
-- emp_no of people working at the company
SELECT DISTINCT emp_no
	FROM dept_emp
	WHERE to_date > NOW();
-- 59900 employees no longer work for the company
SELECT COUNT(emp_no)
	FROM employees
    WHERE emp_no NOT IN (SELECT DISTINCT emp_no
							FROM dept_emp
							WHERE to_date > NOW());
                        
-- 4.
-- get current female dept managers' emp_no
SELECT emp_no
	FROM dept_manager
    JOIN employees USING (emp_no)
    WHERE gender='F' AND to_date>NOW();
-- get their names
SELECT first_name, last_name
	FROM employees
	WHERE emp_no IN (SELECT emp_no
						FROM dept_manager
						JOIN employees USING (emp_no)
						WHERE gender='F' AND to_date>NOW());
/*
'Isamu','Legleitner'
'Karsten','Sigstam'
'Leon','DasSarma'
'Hilary','Kambil'
*/
-- solution in class is to get the emp_no of department managers
SELECT emp_no
	FROM dept_manager
    WHERE to_date > NOW();
-- seperate out the gender condition:


-- 5.
-- get historical avg salary
SELECT AVG(salary)
	FROM salaries;
-- list of employees with a currently higher than avg salary
SELECT emp_no, first_name, last_name, salary
	FROM salaries
		JOIN employees USING (emp_no)
	WHERE salaries.to_date > NOW() 
		AND salary > (SELECT AVG(salary)
						FROM salaries);
-- count of the employees for 154543 employees
SELECT COUNT(*)
	FROM salaries
		JOIN employees USING (emp_no)
	WHERE salaries.to_date > NOW() 
		AND salary > (SELECT AVG(salary)
						FROM salaries);
                        
-- 6.
-- get current max salary
SELECT MAX(salary)
	FROM salaries
	WHERE to_date > NOW();
-- get standard deviation
SELECT STD(salary)
	FROM salaries
    WHERE to_date > NOW();
-- get salaries within one stddev: 83 total
SELECT COUNT(salary)
	FROM salaries
		WHERE salary >=
			(SELECT MAX(salary)
				FROM salaries
				WHERE to_date > NOW()) - 
			(SELECT STD(salary)
				FROM salaries
				WHERE to_date > NOW())
			AND to_date > NOW()
	ORDER BY salary DESC;

-- get the percent of the scores
-- assuming only current salaries
-- subquery for all salaries
SELECT COUNT(salary)
	FROM salaries
    WHERE to_date>NOW();
-- get the percent
SELECT COUNT(*)/(SELECT COUNT(*)
						FROM salaries
                        WHERE to_date>NOW())*100
	FROM salaries
		WHERE salary >=
			(SELECT MAX(salary)
				FROM salaries
				WHERE to_date > NOW()) - 
			(SELECT STD(salary)
				FROM salaries
				WHERE to_date > NOW())
			AND to_date > NOW();

-- BONUS
-- 1.
-- first get female managers' emp_no
SELECT emp_no
	FROM dept_manager
    JOIN employees USING (emp_no)
    WHERE gender='F' AND to_date>NOW();
-- 
SELECT dept_name, emp_no
	FROM dept_manager
    JOIN departments USING (dept_no)
    WHERE emp_no IN (
				SELECT emp_no
					FROM dept_manager
					JOIN employees USING (emp_no)
					WHERE gender='F' AND to_date>NOW());
                    
-- 2.
-- get max salary
SELECT MAX(salary)
	FROM salaries;
-- get the emp_no associated
SELECT emp_no
	FROM salaries
    WHERE salary=(SELECT MAX(salary)
					FROM salaries);
-- Get employee names
SELECT first_name, last_name
	FROM employees
    WHERE emp_no = (SELECT emp_no
					FROM salaries
					WHERE salary=(SELECT MAX(salary)
									FROM salaries));
                                    
-- 3.
-- get the dept name
SELECT dept_name
	FROM departments
    JOIN dept_emp USING (dept_no)
    JOIN (SELECT emp_no
			FROM salaries
			WHERE salary=(SELECT MAX(salary)
							FROM salaries)) AS e_no USING (emp_no);
