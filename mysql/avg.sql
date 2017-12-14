# avg for recharge 
SELECT f_money, avg(f_money) as day_money
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_platform='android'
GROUP BY f_money

# avg counter 
SELECT f_money,  count(*)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_counter,  sum(f_money)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_money
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_platform='android' AND f_crtime between "2017-04-01" AND "2017-09-14"
GROUP BY f_money


#query avg 
SELECT f_money, count(*) as counter, TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as days, sum(f_money) as moneys ,count(*)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_counter,  sum(f_money)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_money
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_platform='android' AND f_crtime between "2017-04-01" AND "2017-09-14"
GROUP BY f_money


#query user place
SELECT f_uid, sum(f_golds) as golds
FROM t_gold_log
WHERE f_crtime between "2017-04-01" AND "2017-09-14" AND f_inout in (1, 14)
GROUP BY f_uid


# request (wwh01)
SELECT f_money, count(distinct f_uid) as users,count(*) as counter, TIMESTAMPDIFF(DAY,"2017-08-01", "2017-09-14") as days, sum(f_money) as moneys ,count(*)/TIMESTAMPDIFF(DAY,"2017-08-01", "2017-09-14") as average_counter,  sum(f_money)/TIMESTAMPDIFF(DAY,"2017-08-01", "2017-09-14") as average_money
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_platform='android' AND f_crtime between "2017-08-01" AND "2017-09-14"
GROUP BY f_money