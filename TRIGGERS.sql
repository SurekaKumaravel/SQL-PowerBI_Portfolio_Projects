USE employees;

COMMIT;

#Before insert
DELIMITER $$

CREATE TRIGGER before_salaries_insert
BEFORE INSERT ON salaries
FOR EACH ROW 
BEGIN 
IF NEW.salary < 0 THEN
	SET NEW.salary = 0;
    END IF;
    END $$
    
    
    SELECT * FROM salaries
    WHERE emp_no = '10001';
    
INSERT INTO salaries VALUES('10001', -92891, '2010-06-22', '9999-01-01');

DELIMITER $$

CREATE TRIGGER trig_upd_salary
BEFORE UPDATE ON salaries
FOR EACH ROW
BEGIN 
	IF NEW.salary < 0 THEN 
		SET NEW.salary = OLD.salary; 
	END IF; 
END $$

DELIMITER ;
    
 SELECT * FROM salaries
    WHERE emp_no = '10001' AND from_date = '2010-06-22';
    
UPDATE salaries 
SET 
    salary = -50000
WHERE
    emp_no = '10001'
        AND from_date = '2010-06-22';
        