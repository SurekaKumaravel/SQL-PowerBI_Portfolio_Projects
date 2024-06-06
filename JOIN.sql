INSERT INTO dept_manager_dup 
VALUES ('110228', 'd003', '1992-03-21', '9999-01-01');

INSERT INTO departments_dup 
VALUES ('d009', 'Customer Service');

SELECT * 
FROM dept_manager_dup 
ORDER BY dept_no;

SELECT * 
FROM departments_dup 
ORDER BY dept_no;

SET GLOBAL sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT m.dept_no, m.emp_no, d.dept_name
FROM
dept_manager_dup m
INNER JOIN 
departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY m.dept_no;

# remove the duplicates from the tables
DELETE FROM dept_manager_dup
WHERE emp_no = '110228';

DELETE FROM departments_dup
WHERE dept_no = 'd009'; 

insert into dept_manager_dup
values ('110228', 'd003', '1992-02-21', '9999-01-01');

insert into departments_dup
values ('d009', 'Customer Service');

/* LEFT JOIN */
SELECT m.dept_no, m.emp_no, d.dept_name
FROM
dept_manager_dup m
LEFT JOIN 
departments_dup d ON m.dept_no = d.dept_no
where dept_name IS NULL
ORDER BY m.dept_no;

SELECT d.dept_no, m.emp_no, d.dept_name
FROM
departments_dup d
LEFT OUTER JOIN 
dept_manager_dup m ON m.dept_no = d.dept_no
ORDER BY d.dept_no;

SELECT * from employees;

select * from departments_dup;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, dm.from_date
FROM 
employees e
LEFT JOIN dept_manager dm
ON e.emp_no = dm.emp_no
WHERE e.last_name = 'Markovitch'
ORDER BY dm.dept_no desc, e.emp_no;

ALTER TABLE dept_manager
DROP dept_name ;

INSERT INTO departments_dup(dept_name)
VALUES ('Public Relations');

/* RIGHT JOIN */
SELECT m.dept_no, m.emp_no, d.dept_name
FROM
dept_manager_dup m
RIGHT JOIN 
departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no, e.hire_date
FROM 
employees e, dept_manager dm
WHERE e.emp_no = dm.emp_no;

SELECT e.emp_no, e.first_name, e.last_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
WHERE salary > 145000;

select * from titles;

select e.emp_no, e.first_name, e.last_name, e.hire_date, t.title
from employees e
JOIN titles t on e.emp_no = t.emp_no
WHERE e.first_name = 'Margareta'AND e.last_name = 'Markovitch'
order by emp_no;

# CROSS JOIN
SELECT e.*, d.*
FROM dept_manager dm
CROSS JOIN 
departments d
INNER JOIN employees e ON dm.emp_no = e.emp_no
WHERE d.dept_no <> dm.dept_no
ORDER BY dm.emp_no, d.dept_no;

SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no = 'd009'
ORDER BY d.dept_no;

SELECT * FROM employees;

select e.*, d.*
FROM employees e
CROSS JOIN
departments d
WHERE e.emp_no < '10011'
ORDER BY e.emp_no, d.dept_name;

select * from salaries;

SELECT e.gender, AVG(s.salary) as Average_Salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;

# JOIN MORE THAN TWO TABLES
SELECT e.first_name, e.last_name, e.hire_date, dm.from_date, d.dept_name
FROM employees e
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

select e.first_name, e.last_name, e.hire_date, t.title, dm.from_date, d.dept_name
FROM employees e
JOIN titles t ON e.emp_no = t.emp_no
JOIN dept_manager dm ON e.emp_no = dm.emp_no
JOIN departments d ON dm.dept_no = d.dept_no
WHERE title = 'Manager'
ORDER BY e.emp_no;

SELECT d.dept_name, AVG(salary) as Average_salary
FROM departments d
JOIN
dept_manager dm ON d.dept_no = dm.dept_no
JOIN 
salaries s ON dm.emp_no = s.emp_no
GROUP BY dept_name
HAVING Average_salary > 60000
ORDER BY Average_salary DESC;

select e.gender,COUNT(e.emp_no) as Countofemployees
FROM employees e
JOIN dept_manager dm ON  e.emp_no = dm.emp_no
GROUP BY gender;



SET SQL_SAFE_UPDATES = 0;
SET sql_mode='STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
