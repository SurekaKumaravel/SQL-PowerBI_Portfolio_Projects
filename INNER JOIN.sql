SELECT 
*
FROM
dept_manager_dup
ORDER BY dept_no;

SELECT m.dept_no, m.emp_no, d1.dept_name
FROM
dept_manager_dup m
INNER JOIN 
departments_dup d1 ON m.dept_no = d1.dept_no
ORDER BY m.dept_no;

select * from dept_manager_dup;

select * from departments_dup;

INSERT INTO dept_manager_dup

select * from dept_manager;
select * from departments_dup;
DELETE FROM departments_dup
WHERE
dept_no = 'd002'; 
DELETE FROM dept_manager_dup
WHERE
dept_no = 'd001';

SELECT m.dept_no, m.emp_no, d.dept_name
FROM
dept_manager_dup m
INNER JOIN 
departments_dup d ON m.dept_no = d.dept_no
ORDER BY m.dept_no;

SELECT e.emp_no, e.first_name, e.last_name, dm.dept_no,e.hire_date
FROM
employees e
INNER JOIN dept_manager dm ON e.emp_no = dm.emp_no;