SELECT a.emp_no, MIN(salary) as min_salary FROM
(SELECT emp_no, salary, ROW_NUMBER()OVER (PARTITION BY emp_no ORDER BY SALARY ASC) as row_num
FROM salaries) a
GROUP BY a.emp_no;

SELECT a.emp_no, MIN(salary) as min_salary
FROM (select emp_no, salary 
from salaries) a 
GROUP BY emp_no;

SELECT a.emp_no, a.salary as min_salary FROM
(SELECT emp_no, salary, ROW_NUMBER()OVER w as row_num
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY SALARY ASC)) a
WHERE a.row_num = 1;

SELECT a.emp_no, a.salary as min_salary FROM
(SELECT emp_no, salary, ROW_NUMBER()OVER w as row_num
FROM salaries
WINDOW w AS (PARTITION BY emp_no ORDER BY SALARY ASC)) a
WHERE a.row_num = 2;