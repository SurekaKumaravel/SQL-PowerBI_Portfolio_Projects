USE employees;

SELECT 
	AVG(salary) as avg_salary
FROM salaries;

WITH cte AS 
(SELECT 
	AVG(salary) as avg_salary
FROM salaries)
SELECT 
* FROM salaries s
JOIN employees e ON s.emp_no = s.emp_no AND e.gender = 'F'
CROSS JOIN
cte c;