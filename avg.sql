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


#查询平均日充值数据
SELECT f_money, count(*) as counter, TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as days, sum(f_money) as moneys ,count(*)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_counter,  sum(f_money)/TIMESTAMPDIFF(DAY,"2017-04-01", "2017-09-14") as average_money
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_platform='android' AND f_crtime between "2017-04-01" AND "2017-09-14"
GROUP BY f_money
