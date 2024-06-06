SELECT * FROM dept_emp;

SELECT 
    emp_no, from_date, to_date, COUNT(emp_no) AS Num
FROM
    dept_emp
GROUP BY emp_no
HAVING Num > 1;

CREATE OR REPLACE VIEW v_dept_emp_latest_date AS
	SELECT 
		emp_no, MAX(from_date) AS from_date, MAX(to_date) AS to_date
	FROM dept_emp
    GROUP BY emp_no;

CREATE OR REPLACE VIEW v_avgsalary_managers AS
SELECT
ROUND(AVG(salary),2) AS manager_salary
FROM salaries s
JOIN dept_manager dm ON s.emp_no = dm.emp_no;

