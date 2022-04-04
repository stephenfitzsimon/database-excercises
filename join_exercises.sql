-- Join examples database
-- 1.
USE join_example_db;
SELECT * FROM users;
SELECT * FROM roles;
-- 2.
-- this will show all records that both tables share
SELECT * FROM users JOIN roles ON users.id=roles.id;
-- they also share the same column info
SELECT * FROM users JOIN roles USING (id);
-- this gets all the members from users, regardless if they exist on roles
SELECT * FROM users LEFT JOIN roles ON users.id=roles.id;
-- looks like a left/right join are exchangable and only change order of the columns? see below:
SELECT * FROM roles RIGHT JOIN users ON users.id=roles.id;
-- this will get all the records from roles, and the records from users IF they are also in roles
SELECT * FROM users RIGHT JOIN roles ON users.id=roles.id;
-- 3.
SELECT roles.name, COUNT(users.name) AS num_of_emp
	FROM users JOIN roles ON users.role_id=roles.id
    GROUP BY roles.name;
-- in class solution to get commenter line
SELECT roles.name, COUNT(users.name) AS num_of_emp
	FROM users RIGHT JOIN roles ON users.role_id=roles.id
    GROUP BY roles.name;
    
-- employees database
-- 1.
USE employees;

-- 2.
SELECT d.dept_name, CONCAT(e.first_name,' ', e.last_name) AS current_manager
	FROM employees AS e
		JOIN dept_manager AS dm ON dm.emp_no=e.emp_no
		JOIN departments AS d ON d.dept_no=dm.dept_no
    WHERE dm.to_date > CURDATE()
    ORDER BY d.dept_name;
-- solution in class to move WHERE clause
SELECT d.dept_name, CONCAT(e.first_name,' ', e.last_name) AS current_manager
	FROM employees AS e
		JOIN dept_manager AS dm ON dm.emp_no=e.emp_no 
			AND dm.to_date > CURDATE()
		JOIN departments AS d ON d.dept_no=dm.dept_no
    ORDER BY d.dept_name;
    
-- 3.
SELECT d.dept_name, CONCAT(e.first_name,' ', e.last_name) AS manager_name
	FROM employees AS e
		JOIN dept_manager AS dm ON dm.emp_no=e.emp_no
		JOIN departments AS d ON d.dept_no=dm.dept_no
    WHERE dm.to_date > CURDATE() AND e.gender='F'
    ORDER BY d.dept_name;

-- 4.
SELECT t.title, COUNT(e.emp_no)
	FROM employees AS e
		JOIN titles AS t ON t.emp_no=e.emp_no
		JOIN dept_emp AS de ON de.emp_no=e.emp_no
    WHERE de.dept_no='d009' AND de.to_date > CURDATE() AND t.to_date > NOW() -- watch for current title, not past ones
    GROUP BY t.title
    ORDER BY t.title;

-- 5.
SELECT d.dept_name, CONCAT(e.first_name,' ', e.last_name) AS name, s.salary
	FROM employees AS e
		JOIN salaries AS s ON s.emp_no=e.emp_no
		JOIN dept_manager AS dm ON dm.emp_no=s.emp_no
		JOIN departments AS d ON d.dept_no=dm.dept_no
    WHERE dm.to_date > CURDATE() AND s.to_date > CURDATE()
    ORDER BY d.dept_name;
    
-- 6.
SELECT d.dept_no, d.dept_name, COUNT(de.emp_no) AS num_employees
	FROM departments AS d
		JOIN dept_emp AS de ON de.dept_no=d.dept_no
    WHERE de.to_date > CURDATE()
    GROUP BY d.dept_no
    ORDER BY d.dept_no;
    
-- 7.
SELECT d.dept_name, AVG(s.salary) AS avg_salary
	FROM departments AS d
		JOIN dept_emp AS de USING (dept_no)
		JOIN salaries AS s USING (emp_no)
    WHERE s.to_date > NOW() AND de.to_date > NOW()
    GROUP BY d.dept_no
    ORDER BY AVG(s.salary) DESC
    LIMIT 1;

-- 8. 
SELECT CONCAT(e.first_name,' ', e.last_name) AS name, s.salary
	FROM employees AS e
		JOIN dept_emp AS de USING (emp_no)
        JOIN salaries AS s USING (emp_no)
	WHERE dept_no = 'd001' AND de.to_date > NOW()
    ORDER BY s.salary DESC
    LIMIT 1;

-- 9.
SELECT e.first_name, e.last_name, s.salary, d.dept_name
	FROM employees AS e
		JOIN salaries AS s ON s.emp_no=e.emp_no
		JOIN dept_manager AS dm ON dm.emp_no=s.emp_no
		JOIN departments AS d ON d.dept_no=dm.dept_no
    WHERE dm.to_date > NOW() AND s.to_date > NOW()
    ORDER BY s.salary DESC
    LIMIT 1;
    
-- 10.
SELECT d.dept_name, ROUND(AVG(s.salary),0) AS avg_salary
	FROM departments AS d
		JOIN dept_emp AS de ON de.dept_no=d.dept_no
		JOIN salaries AS s ON s.emp_no=de.emp_no
    GROUP BY d.dept_no
    ORDER BY AVG(s.salary) DESC;

-- 11.
SELECT CONCAT(e.first_name,' ', e.last_name) AS emp_name, d.dept_name, CONCAT(man.first_name,' ', man.last_name) AS manager_name
	FROM employees AS e
		JOIN dept_emp AS de USING (emp_no)
        JOIN departments AS d USING (dept_no)
        JOIN dept_manager AS dm USING (dept_no)
        JOIN employees AS man ON man.emp_no=dm.emp_no
	WHERE de.to_date > NOW() AND dm.to_date > NOW()
    ORDER BY d.dept_name;
-- class: can also use a sub query
    
-- 12.
SELECT d.dept_name, e.emp_no, CONCAT(e.first_name, ' ', last_name) AS name
	FROM employees AS e
		JOIN dept_emp AS de USING (emp_no)
		JOIN departments AS d USING (dept_no)
		JOIN dept_emp AS des USING (dept_no)
		JOIN salaries AS s ON s.emp_no=des.emp_no
		WHERE s.to_date > NOW() AND des.to_date > NOW();
        
SELECT d.dept_name, CONCAT(e.first_name, ' ', last_name), MAX(s.salary)
	FROM departments AS d
		JOIN dept_emp AS de USING (dept_no)
        JOIN employees AS e USING (emp_no)
        JOIN salaries AS s USING (emp_no)
        WHERE s.to_date > NOW() AND de.to_date > NOW()
	GROUP BY d.dept_name, e.first_name, e.last_name;

-- MAX salary in each dept by dept_no
SELECT de.dept_no, MAX(s.salary)
	FROM dept_emp AS de
		JOIN salaries AS s ON s.emp_no=de.emp_no
	WHERE de.to_date>NOW() AND s.to_date>NOW()
    GROUP BY de.dept_no;
