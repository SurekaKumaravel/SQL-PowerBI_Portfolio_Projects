SELECT emp_no, COUNT(SALARY)-COUNT(DISTINCT salary) as diff
FROM salaries
GROUP BY emp_no
HAVING diff > 0
ORDER BY emp_no;

select * from salaries
where emp_no = 11839;

SELECT emp_no, salary, RANK() OVER w as row_num
        FROM salaries
        WHERE emp_no = 11839
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
    
    SELECT emp_no, salary, DENSE_RANK() OVER w as row_num
        FROM salaries
        WHERE emp_no = 11839
	WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);
    
SELECT emp_no, salary, RANK() OVER w as row_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT emp_no, salary, DENSE_RANK() OVER w as row_num
FROM salaries
WHERE emp_no = 10560
WINDOW w AS (PARTITION BY emp_no ORDER BY salary DESC);

SELECT

    dm.emp_no, (COUNT(salary)) AS no_of_salary_contracts

FROM

    dept_manager dm

        JOIN

    salaries s ON dm.emp_no = s.emp_no

GROUP BY emp_no

ORDER BY emp_no;



SELECT dm.emp_no, COUNT(s.salary) as contracts_signed
FROM salaries s
JOIN dept_manager dm ON s.emp_no = dm.emp_no
GROUP BY emp_no
ORDER BY emp_no;