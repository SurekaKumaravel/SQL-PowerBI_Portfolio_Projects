USE employees;

DROP PROCEDURE IF EXISTS select_employees;

DELIMITER $$ 
CREATE PROCEDURE select_employees()
BEGIN

SELECT * FROM employees
LIMIT 1000;

END$$

DELIMITER ;

CALL employees.select_employees();

USE employees;

DROP PROCEDURE IF EXISTS emp_salary;

DELIMITER $$ 
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN





CALL select_employees();


DELIMITER $$

CREATE PROCEDURE average_salary_emp()
BEGIN
SELECT AVG(SALARY) 
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no;
END$$
DELIMITER ;

USE employees;
DROP PROCEDURE IF EXISTS emp_avg_salary;

DELIMITER $$
USE employees $$
CREATE PROCEDURE emp_avg_salary(IN p_emp_no INTEGER)
BEGIN
SELECT e.first_name, e.last_name, AVG(s.salary)
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
END$$
DELIMITER ;

CALL emp_avg_salary(11300);

DROP PROCEDURE IF EXISTS emp_info;
DELIMITER $$
CREATE PROCEDURE emp_info(in p_first_name varchar(255), in p_last_name varchar(255), 
out p_emp_no integer)
BEGIN
SELECT e.emp_no INTO p_emp_no
FROM employees e
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
END$$
DELIMITER ;


DROP procedure IF EXISTS emp_avg_salary_out;

DELIMITER $$
CREATE PROCEDURE emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
BEGIN
SELECT 
    AVG(s.salary)
INTO p_avg_salary FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
    e.emp_no = p_emp_no;
END$$

DELIMITER ;
