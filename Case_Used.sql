SELECT 
    emp_no,
    first_name,
    last_name,
    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;

SELECT 
    emp_no,
    first_name,
    last_name,
    CASE gender
        WHEN 'M' THEN 'Male'
        ELSE 'Female'
    END AS gender
FROM
    employees;


SELECT 
    dm.emp_no,
    e.first_name,
    e.last_name,
    MAX(s.salary) - MIN(s.salary) AS salary_difference,
    CASE
        WHEN MAX(s.salary) - MIN(s.salary) > 30000 THEN 'Salary was raised by more than $30,000'
        WHEN MAX(s.salary) - MIN(s.salary) BETWEEN 20000 AND 30000 THEN 
									'Salary was raised by more than $20,000 but less than $30,000'
        ELSE 'Salary was raised by less than $20,000'
    END AS salary_increase
FROM
    dept_manager dm
        JOIN
    employees e ON e.emp_no = dm.emp_no
        JOIN
    salaries s ON s.emp_no = dm.emp_no
GROUP BY s.emp_no;

SELECT e.emp_no, e.first_name, e.last_name,
CASE
WHEN dm.emp_no IS NOT NULL THEN 'Manager'
ELSE 'Employee'
END AS is_managers
FROM employees e
LEFT JOIN dept_manager dm ON e.emp_no = dm.emp_no
WHERE e.emp_no > 109990;

SELECT dm.emp_no,e.first_name,e.last_name, MAX(s.salary) - MIN(s.salary) AS salary_difference, 
CASE 
WHEN  MAX(s.salary) - MIN(s.salary) > 30000 THEN 'salary is higher than 30000' 
ELSE 'salary is lesser than 30000'
END AS is_salaryrange
FROM dept_manager dm
LEFT JOIN employees e ON dm.emp_no = e.emp_no
LEFT JOIN salaries s ON dm.emp_no = s.emp_no
GROUP BY dm.emp_no;

SELECT e.emp_no, e.first_name, e.last_name, 
CASE 
WHEN MAX(de.to_date) > sysdate() 
then 'IS STILL EMPLOYED'
ELSE 'Not an employee anymore'
END AS employee_status
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
GROUP BY e.emp_no
LIMIT 100;