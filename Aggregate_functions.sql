SELECT COUNT(salary)
FROM salaries;
SELECT * FROM dept_emp;

SELECT COUNT(DISTINCT emp_no)
FROM dept_emp;

SELECT SUM(salary)
FROM salaries
WHERE from_date > '1997-01-01';

SELECT * FROM employees;

SELECT MIN(emp_no)
 FROM employees;
 
 SELECT 
    MAX(emp_no)
FROM
    employees;
 
 SELECT ROUND(AVG(salary))
FROM salaries;

SELECT AVG(salary)
FROM salaries
WHERE from_date > '1997-01-01';

SELECT ROUND(AVG(salary),2)
FROM salaries
WHERE from_date > '1997-01-01';

SELECT * FROM departments_dup;

ALTER TABLE
departments_dup
CHANGE COLUMN
dept_name dept_name VARCHAR(40) NULL;

INSERT INTO departments_dup(dept_no)
VALUES ('d011');

SELECT
*
FROM
departments_dup
ORDER BY
dept_no ASC;

ALTER TABLE
employees.departments_dup
ADD COLUMN
dept_manager VARCHAR(255) NULL AFTER dept_name;

COMMIT;

SELECT
dept_no, IFNULL(dept_name, 'Department number not provided') AS Dept_Name
FROM
departments_dup;

SELECT
dept_no, dept_name, coalesce(dept_manager, dept_name, 'N/A') AS Dept_Manager
FROM
departments_dup
ORDER BY dept_NO ASC;

SELECT
dept_no, dept_name, COALESCE(dept_no, dept_name) AS dept_info
FROM
departments_dup
ORDER BY dept_NO ASC;

SELECT
IFNULL(dept_no,'N/A') AS dept_no, IFNULL(dept_name, 'Department name not provided') AS dept_name, 
COALESCE(dept_no, dept_name) AS dept_info
FROM
departments_dup
ORDER BY dept_NO ASC;

select * from departments_dup

ALTER TABLE departments_dup
DROP COLUMN dept_manager;

ALTER TABLE departments_dup
CHANGE COLUMN dept_no dept_no CHAR(4) NULL;

ALTER TABLE departments_dup
CHANGE COLUMN dept_name dept_name VARCHAR(40) NULL;

DROP TABLE IF EXISTS dept_manager_dup;

CREATE TABLE dept_manager_dup (
emp_no int(11) NOT NULL,
dept_no char(4) NULL,
from_date date NOT NULL,
to_date date NULL
);

INSERT INTO dept_manager_dup

select * from dept_manager;

INSERT INTO dept_manager_dup (emp_no, from_date)
VALUES                
(999904, '2017-01-01'),(999905, '2017-01-01'),
(999906, '2017-01-01'),(999907, '2017-01-01');
DELETE FROM dept_manager_dup
WHERE dept_no = 'd001';
SET SQL_SAFE_UPDATES = 0;


