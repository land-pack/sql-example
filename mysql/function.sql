# my filter function


DELIMITER //  
CREATE FUNCTION GetEmployeeInformationByID(id INT)  
RETURNS VARCHAR(300)  
BEGIN  
    RETURN(SELECT CONCAT('employee name:',employee_name,'---','salary: ',employee_salary) FROM employees WHERE employee_id=id);  
END//  
DELIMITER ;  


DROP PROCEDURE IF EXISTS WhileLoop;
DELIMITER $$
CREATE  PROCEDURE   WhileLoop()

BEGIN


DELIMITER //  
CREATE FUNCTION filterByRange(gold INT)  
RETURNS INT
BEGIN  
    IF 10 < gold < 1000 THEN
        RETURN(1);
    ELSE
        RETURN(0);
    END IF  
END//
DELIMITER ;  


END$$
call WhileLoop();

select t.gold as gold, 
t.uid as uid FROM 
(SELECT case 
when gold BETWEEN 0 AND 200 then '0-200' 
when gold BETWEEN 200 AND 500 THEN '0-500' 
WHEN gold BETWEEN 500 AND 100000 THEN '500+' 
ELSE '100000+' 
END as tags FROM person)t GROUP BY t.tags;

