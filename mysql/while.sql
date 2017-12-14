# Normally , we have a lot of record need to filter, so we need a loop
DROP PROCEDURE IF EXISTS WhileLoop;
DELIMITER $$
CREATE  PROCEDURE   WhileLoop()

BEGIN

set @start_date = "2017-07-28";
set @end_date = "2017-08-28";
WHILE @start_date < @end_date
DO
# LOOP QUERY & INSERT NEW RECORD



SET @start_date = DATE_ADD(@start_date, INTERVAL 1 DAY);
END WHILE;       
END$$
call WhileLoop();





# we need a tmp table to save query result each time
CREATE TABLE tmp_user_info(active integer, recharge decimal(20,2), arpu decimal(10, 2), 
new_user integer, back_user integer, ttrade integer, ttrade_gold decimal(10,2), vgues_trade integer,
vtrade_gold decimal(10,2), cg_wechat decimal(10,2),  cg_alipay decimal(10,2), cg_other decimal(10,2), 
cg_apple decimal(10,2));
