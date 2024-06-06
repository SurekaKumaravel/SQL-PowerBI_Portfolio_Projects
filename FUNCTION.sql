

DELIMITER $$
CREATE FUNCTION f_emp_avg_salary(p_emp_no INTEGER) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_avg_salary DECIMAL(10,2);

SELECT AVG(s.salary)
INTO v_avg_salary 
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no = p_emp_no;
RETURN v_avg_salary;
END$$
DELIMITER ;                                                                                                                                              



DELIMITER $$
CREATE FUNCTION f_emp_info(p_first_name varchar(255),p_last_name varchar(255))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);


SELECT v_max_from_date, v_salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name AND s.from_date = v_max_from_date
RETURN v_max_from_date;
RETURN v_salary;
END$$
DELIMITER ;