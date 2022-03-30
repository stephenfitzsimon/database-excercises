#use the emplyees database
USE employees;

#display the tables in the database
SHOW TABLES;

#show the info about the employees tables
DESCRIBE employees;
EXPLAIN dept_emp;
DESCRIBE salaries;
DESCRIBE titles;
describe departments;
#Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
#emp_no is numeric, salary is numeric.  These are in dept_emp,  dept_manager, employees, salaries, and titles

#Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
#first_name, last_name are string, so is title, dept_name and dept_no
#gender is an enum of two string values
#these are on the departments, dept_emp, dept_manager, employees, and titles

#Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
#birth_date and hire_date are date type, from_date and to_date have date type.  THese are used in dept_emp, dept_manager, 
#employees, salaries, and titles

DESCRIBE departments;
DESCRIBE dept_emp;
#What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
#employees and departments are related via the dept_emp table.  Since dept_emp contains the cols emp_no and dept_no
#an emp_no can be used to look up what department (via the dept_no) that employees belongs to (and vice versa)

SHOW CREATE TABLE dept_manager;
#'dept_manager', 'CREATE TABLE `dept_manager` (\n  `emp_no` int NOT NULL,\n  `dept_no` char(4) NOT NULL,\n  `from_date` date NOT NULL,\n  `to_date` date NOT NULL,\n  PRIMARY KEY (`emp_no`,`dept_no`),\n  KEY `dept_no` (`dept_no`),\n  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,\n  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT\n) ENGINE=InnoDB DEFAULT CHARSET=latin1'
-- 'CREATE TABLE `dept_manager` (
--  `dept_no` char(4) NOT NULL,
--  `from_date` date NOT NULL,
--  `to_date` date NOT NULL,
--  PRIMARY KEY (`emp_no`,`dept_no`),
--  KEY `dept_no` (`dept_no`),
--  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
--  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
-- ) ENGINE=InnoDB DEFAULT CHARSET=latin1'