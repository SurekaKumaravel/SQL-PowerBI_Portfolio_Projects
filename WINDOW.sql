USE employees;

SELECT 
	emp_no, salary, ROW_NUMBER() OVER() AS row_num
FROM 
	salaries;

SELECT emp_no, ROW_NUMBER()OVER(ORDER BY emp_no) AS row_num
FROM dept_manager;

SELECT emp_no, first_name, last_name, ROW_NUMBER() OVER(PARTITION BY first_name ORDER BY last_name asc) as row_num
FROM employees;

USE employees;

SELECT 
	emp_no, 
    salary, 
    ROW_NUMBER() OVER () AS row_num1,
    ROW_NUMBER() OVER (PARTITION BY emp_no) AS row_num2,
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num3,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num4
FROM
	salaries;
    
SELECT 
	emp_no, 
    salary, 
    # ROW_NUMBER() OVER() AS row_num1,
    ROW_NUMBER() OVER(PARTITION BY emp_no) AS row_num2,
    #ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num3,
    ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num4
FROM
	salaries;
    
SELECT dm.emp_no,salary,ROW_NUMBER() OVER() AS row_num1, 
ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY s.salary DESC) as row_num2
FROM dept_manager dm
JOIN salaries s ON dm.emp_no = s.emp_no
ORDER BY row_num1, emp_no, salary ASC;

SELECT dm.emp_no,salary,
ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY s.salary ASC) as row_num2,
ROW_NUMBER() OVER(PARTITION BY emp_no ORDER BY s.salary DESC) as row_num2
FROM dept_manager dm
JOIN salaries s ON dm.emp_no = s.emp_no;

SELECT 
	emp_no, 
	salary, 
	ROW_NUMBER() OVER w AS row_num
FROM
	salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT
emp_no,
first_name,
ROW_NUMBER() OVER w AS row_num
FROM
employees
WINDOW w AS (PARTITION BY first_name ORDER BY emp_no);

SELECT 
    *
FROM
    salaries
GROUP BY emp_no;

SELECT 
	emp_no, 
    salary, 
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;

SELECT a.emp_no, 
       MAX(salary) AS max_salary FROM (
	SELECT 
		emp_no, salary, ROW_NUMBER() OVER w AS row_num
	FROM
		salaries
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)) a
GROUP BY emp_no;

SELECT a.emp_no, MAX(salary) AS max_salary FROM (
	SELECT 
		emp_no, salary, ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) as row_num
	FROM
		salaries) a
GROUP BY emp_no;

SELECT a.emp_no, 
       MAX(salary) AS max_salary FROM (
	SELECT 
		emp_no, salary
	FROM
		salaries) a
GROUP BY emp_no;

SELECT a.emp_no, 
       a.salary AS max_salary FROM (
	SELECT 
		emp_no, salary, ROW_NUMBER() OVER w as row_num
	FROM
		salaries
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC)) a
WHERE a.row_num = 2;

SELECT 
	emp_no, 
    salary, 
    ROW_NUMBER() OVER (PARTITION BY emp_no ORDER BY salary DESC) AS row_num
FROM
	salaries;

