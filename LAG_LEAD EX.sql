USE employees;

SELECT emp_no, salary, 
LAG(salary) OVER w as previous_salary,
LEAD(salary) OVER w as next_salary,
salary - LAG(salary) OVER w as diff_salary_current_previous,
LEAD(salary) OVER w - salary as diff_salary_next_current
FROM salaries
WHERE emp_no = 10001
WINDOW w AS (ORDER BY salary);

SELECT emp_no, salary, 
LAG(salary) OVER w as previous_salary,
LEAD(salary) OVER w as next_salary,
salary - LAG(salary) OVER w as diff_current_previous,
LEAD(salary) OVER w - salary as diff_next_current
FROM salaries
WHERE emp_no BETWEEN 10500 AND 10600 AND salary > 80000
WINDOW w as (PARTITION BY emp_no ORDER BY salary);

