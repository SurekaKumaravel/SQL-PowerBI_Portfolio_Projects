DELIMITER $$
CREATE FUNCTION emp_info(p_first_name varchar(255),p_last_name varchar(255))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE v_max_from_date DATE;
DECLARE v_salary DECIMAL(10,2);


SELECT MAX(from_date)
INTO v_max_from_date 
FROM employees e
    JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name;
SELECT s.salary 
INTO v_salary FROM
employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.first_name = p_first_name AND e.last_name = p_last_name 
AND s.from_date = v_max_from_date;
RETURN v_salary;
END$$
DELIMITER ;


SELECT emp_info('Aruna', 'Journel');