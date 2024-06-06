ALTER TABLE customers
ADD UNIQUE KEY (email_address);

alter table customers
change column customer_id INT AUTO_INCREMENT;

ALTER TABLE customers
    ADD COLUMN gender ENUM('M', 'F') AFTER last_name;
INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley','M', 'john.mckinley@365careers.com', 0);

select * from customers;
INSERT INTO customers (customer_id, first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('1', 'John', 'Mackinley', 'M', 'john.mckinley@365careers.com', 0);

alter table customers
change column customer_id customer_id INT AUTO_INCREMENT;

insert into customers (first_name, last_name, gender)
values ('Peter', 'Figaro','M');

alter table customers
change column number_of_complaints number_of_complaints INT DEFAULT 0;
SELECT * FROM CUSTOMERS;

DELETE FROM CUSTOMERS
WHERE number_of_complaints is null;

alter table customers
alter column number_of_complaints DROP DEFAULT;

alter table customers
alter column number_of_complaints INT(11);

select * from companies;

alter table companies
MODIFY company_name varchar(255) null;

alter table companies
modify company_name varchar(255) not null;

alter table companies
change company_name company_name varchar(255) not null;

alter table companies
MODIFY company_id INT AUTO_INCREMENT;
ALTER TABLE COMPANIES
CHANGE COLUMN headquarters_phone_number headquarters_phone_number varchar(255);

delete from companies
where company_id = 1;

select * from companies;

ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR(255) NOT NULL;

INSERT INTO companies (company_name, headquarters_phone_number)
values ( 'Company A', '+1 (202) 555-0196');

SELECT 
    *
FROM
    companies;
    
SELECT 
    *
FROM
    customers