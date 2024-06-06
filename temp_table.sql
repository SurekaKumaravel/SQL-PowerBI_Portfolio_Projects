USE employees;

CREATE TEMPORARY TABLE f_highest_salaries
SELECT s.emp_no, MAX(s.salary) AS highest_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND gender = 'F'
GROUP BY s.emp_no;

SELECT * FROM f_highest_salaries;

SELECT * FROM f_male_max_salaries
WHERE emp_no <= 10011;

DROP TEMPORARY TABLE IF EXISTS  _salaries;

CREATE TEMPORARY TABLE f_male_max_salaries
SELECT s.emp_no, MAX(s.salary) as high_salary
FROM salaries s
JOIN employees e ON s.emp_no = e.emp_no AND gender = 'M'
GROUP BY s.emp_no;

WITH cte AS (SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
LIMIT 10)
SELECT * FROM f_highest_salaries f1 JOIN cte c;


WITH cte AS (SELECT 
    s.emp_no, MAX(s.salary) AS f_highest_salary
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no AND e.gender = 'F'
GROUP BY s.emp_no
LIMIT 10)
SELECT * FROM f_highest_salaries UNION ALL SELECT * FROM cte;

    
CREATE TEMPORARY TABLE dates
SELECT 
    NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later;
    
SELECT 
    *
FROM
    dates;

SELECT 
    *
FROM
    dates d1
        JOIN
    dates d2;
    
SELECT 
    *
FROM
    dates d1 
UNION SELECT 
    *
FROM
    dates d2;

WITH cte AS (SELECT 
    NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates d1 JOIN cte c;

WITH cte AS (SELECT 
    NOW() AS current_date_and_time,
    DATE_SUB(NOW(), INTERVAL 1 MONTH) AS a_month_earlier,
    DATE_SUB(NOW(), INTERVAL -1 YEAR) AS a_year_later)
SELECT * FROM dates UNION ALL SELECT * FROM cte;

    



