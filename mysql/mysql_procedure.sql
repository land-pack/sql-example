# query every user account left by mysql procedure
# SQL Functions
# MIN(), DATE_FORMAT, DATE_SUB(), DATE_ADD()
#


#Get the record during that day group by f_uid as early as possible

SELECT MIN(f_tid) as f_tid
FROM t_diamond_log
WHERE DATE_FORMAT(f_crtime, "%Y-%m-%d")="2017-07-27"
GROUP BY f_uid


# After fetched f_tid (auto increate primary key )  the early 
# record of each day, we can make up the miss record

SELECT f_uid, f_total, f_crtime, f_tid
FROM t_diamond_log
WHERE f_tid in (SELECT min(f_tid) as f_tid
FROM t_diamond_log
WHERE DATE_FORMAT(f_crtime, "%Y-%m-%d")="2017-07-27"
GROUP BY f_uid)

# and then we can insert those result to a new table (tmp table will be good choice)

INSERT INTO tmp_log(f_uid, f_total, f_crtime, f_tid)
SELECT f_uid, f_total, f_crtime, f_tid
FROM t_diamond_log
WHERE f_tid in (SELECT min(f_tid) as f_tid
FROM t_diamond_log
WHERE DATE_FORMAT(f_crtime, "%Y-%m-%d")="2017-09-06"
GROUP BY f_uid)

# Normally , we have a lot of record need to filter, so we need a loop
DROP PROCEDURE IF EXISTS WhileLoop;
DELIMITER $$
CREATE  PROCEDURE   WhileLoop()

BEGIN

set @start_date = "2017-07-28";
set @end_date = "2017-08-28";
WHILE @start_date < @end_date
DO

# if the users that day has make some trade
INSERT INTO tmp_log(f_uid, f_total, f_crtime, f_tid)
SELECT f_uid, f_total, DATE_FORMAT(f_crtime, "%Y-%m-%d") as f_crtime, f_tid
FROM t_diamond_log
WHERE f_tid in (SELECT min(f_tid) as f_tid
FROM t_diamond_log
WHERE DATE_FORMAT(f_crtime, "%Y-%m-%d")=@start_date
GROUP BY f_uid);
# if the users did not do any trade
INSERT INTO tmp_log(f_uid, f_total, f_crtime, f_tid)
SELECT f_uid, f_total, @start_date, f_tid 
FROM tmp_log
WHERE f_crtime=DATE_SUB(@start_date, INTERVAL 1 DAY) AND f_uid not in (
SELECT f_uid 
FROM tmp_log
WHERE f_crtime = @start_date);

SET @start_date = DATE_ADD(@start_date, INTERVAL 1 DAY);
END WHILE;       
END$$
call WhileLoop();
