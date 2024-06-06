USE employees;

SELECT
d.dept_no, d.dept_name, dm.emp_no, 
RANK() OVER w AS department_salary_ranking,
s.salary,
s.from_date as salary_from_date,
s.to_date as salary_to_date,
dm.from_date as dept_manager_from_date,
dm.to_date as dept_manager_to_date
FROM dept_manager dm
JOIN salaries s ON s.emp_no = dm.emp_no
					AND s.from_date BETWEEN dm.from_date AND dm.to_date
                    AND s.to_date BETWEEN dm.from_date AND dm.to_date
JOIN departments d ON d.dept_no = dm.dept_no
WINDOW w AS (PARTITION BY dm.dept_no ORDER BY s.salary DESC);



SELECT
s.emp_no, salary, RANK() OVER(PARTITION BY e.emp_no ORDER BY salary DESC)
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE e.emp_no BETWEEN 10500 AND 10600;

SELECT
s.emp_no, salary, DENSE_RANK() OVER(PARTITION BY e.emp_no ORDER BY salary DESC),  
(YEAR(s.from_date) - YEAR(e.hire_date)) AS years_from_start
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
AND YEAR(s.from_date) - YEAR(e.hire_date) >= 5
WHERE e.emp_no BETWEEN 10500 AND 10600;
