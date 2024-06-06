SELECT 
    dept_no
FROM
    departments;
    
SELECT * FROM employees
WHERE first_name = 'Elvis' and gender = 'M';

SELECT * FROM employees
WHERE first_name = 'Kellie' OR gender = 'F';

SELECT * FROM employees
WHERE first_name = 'Kellie' OR first_name = 'Aruna';

SELECT * FROM employees
WHERE gender = 'F' AND (first_name = 'Kellie' OR first_name = 'Aruna');

SELECT * FROM employees
WHERE first_name IN ('Denis', 'Elvis');

SELECT * FROM employees
WHERE first_name NOT IN ('John', 'Mark', 'Jacob');
USE employees;
SELECT * FROM employees
WHERE first_name LIKE ('Mark%');

SELECT * FROM employees
WHERE hire_date LIKE ('2000%_');

SELECT * FROM employees
WHERE emp_no LIKE ('1000_');

SELECT * FROM employees
WHERE first_name LIKE ('%Jack%');

SELECT * FROM employees
WHERE first_name NOT LIKE ('%Jack%');

SELECT * FROM salaries
WHERE  salary BETWEEN 66000 AND 70000;

SELECT * FROM employees
WHERE emp_no not between 10004 and 10012;

SELECT * FROM departments
WHERE dept_no BETWEEN 'd003' AND 'd006';

SELECT * FROM departments
WHERE dept_no IS NOT NULL;

SELECT * FROM employees
WHERE gender = 'F' AND hire_date >= '2000-01-01';

SELECT * FROM salaries
WHERE  salary > 150000;

SELECT DISTINCT hire_date FROM employees
limit 1000;

SELECT COUNT(*) FROM salaries
WHERE salary >= 100000;

SELECT 
    count(*)
FROM
    dept_manager;

select * from employees 
order by hire_date desc;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
ORDER BY first_name;

SELECT salary, COUNT(emp_no) AS emp_with_same_salary FROM salaries
WHERE salary > 80000
GROUP BY salary
ORDER BY SALARY;

SELECT 
    first_name, COUNT(first_name) AS names_count
FROM
    employees
GROUP BY first_name
HAVING COUNT(first_name)>250
ORDER BY first_name;

SELECT *, AVG(salary) FROM salaries
GROUP BY emp_no
HAVING AVG(salary)>120000;

SELECT emp_no, AVG(salary) FROM salaries
GROUP BY emp_no
HAVING AVG(SALARY) > 120000;
SELECT * FROM employees

SELECT 
    first_name, COUNT(first_name)
FROM
    employees
WHERE
    hire_date > '1999-01-01'
GROUP BY first_name
HAVING COUNT(first_name) < 200
order by first_name;

select * from dept_emp;

SELECT
emp_no
FROM
dept_emp
WHERE
from_date > '2000-01-01'
GROUP BY emp_no
HAVING COUNT(from_date) > 1
ORDER BY emp_no;

SELECT * FROM salaries
order by emp_no desc
limit 10;

select * from dept_emp
limit 100;

select emp_no 
from dept_emp
where from_date > '2000-01-01'
group by emp_no
having count(from_date)>1
order by emp_no;