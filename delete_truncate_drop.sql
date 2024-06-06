INSERT INTO employees
(
emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date
)VALUES
(
999901,
'1986-04-21',
'John',
'Smith',
'M',
'2011-01-01'
);

INSERT INTO employees
(
emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date
)VALUES
(
999902,
'1973-03-26',
'Patricia',
'Lawrence',
'M',
'2005-01-01'
);

INSERT INTO employees
VALUES
(
999903,
'1977-09-14',
'Jonathan',
'Creek',
'M',
'1999-01-01'
);

SELECT * FROM employees
order by emp_no desc;
LIMIT 10;

SELECT * FROM titles
order by emp_no desc
LIMIT 10;

insert into titles (
emp_no, title, from_date
)
values
(999903,
'Senior Engineer',
'1997-10-01'
 );

insert into dept_emp 
values
(
999903,
'd005',
'1997-10-01',
'9999-01-01'
);

SELECT * FROM dept_emp
order by emp_no desc
LIMIT 10;

select * from departments
limit 10;

create table departments_dup
(
dept_no CHAR(4) NOT NULL,
dept_name VARCHAR(40) NOT NULL
);

select * from departments_dup
order by dept_no
limit 10;

insert into departments_dup 
(
select * from departments
);

insert into departments
( dept_no, dept_name)
values
(
'd010', 'Business Analysis');

UPDATE employees
SET
first_name = 'Stella',
last_name = 'Parkinson',
birth_date= '1990-12-21',
gender = 'F'
WHERE 
emp_no = 999901;

SELECT * FROM employees
order by emp_no desc;
LIMIT 10;

select * from departments_dup
order by dept_no;

COMMIT;

UPDATE departments_dup
SET 
dept_no = 'd011',
dept_name = 'Quality Control';

rollback;

commit;

update departments
set
dept_name = 'Data Analysis'
where dept_name = 'Business Analysis';

select * from departments;

select * from titles
where emp_no = 999903;

delete from employees
where emp_no = 999903;

rollback;

select * from departments_dup
order by dept_no;

DELETE FROM departments_dup;

DELETE FROM departments
where dept_no = 'd010';