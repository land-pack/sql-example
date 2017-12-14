SELECT f_uid, k4.f_username as 用户名, k4.f_regtime as 注册时间, k4.reg_weeks as 注册周, k4.tag as 标签,
GROUP_CONCAT(if(k4.weeks = 18, coalesce(k4.week_money,0), NULL)) AS '18周',  
GROUP_CONCAT(if(k4.weeks = 19, coalesce(k4.week_money,0), NULL)) AS '19周',
GROUP_CONCAT(if(k4.weeks = 20, coalesce(k4.week_money,0), NULL)) AS '20周',  
GROUP_CONCAT(if(k4.weeks = 21, coalesce(k4.week_money,0), NULL)) AS '21周',
GROUP_CONCAT(if(k4.weeks = 22, coalesce(k4.week_money,0), NULL)) AS '22周',  
GROUP_CONCAT(if(k4.weeks = 23, coalesce(k4.week_money,0), NULL)) AS '23周',
GROUP_CONCAT(if(k4.weeks = 24, coalesce(k4.week_money,0), NULL)) AS '24周',  
GROUP_CONCAT(if(k4.weeks = 25, coalesce(k4.week_money,0), NULL)) AS '25周',
GROUP_CONCAT(if(k4.weeks = 26, coalesce(k4.week_money,0), NULL)) AS '26周',  
GROUP_CONCAT(if(k4.weeks = 27, coalesce(k4.week_money,0), NULL)) AS '27周',
GROUP_CONCAT(if(k4.weeks = 28, coalesce(k4.week_money,0), NULL)) AS '28周',  
GROUP_CONCAT(if(k4.weeks = 29, coalesce(k4.week_money,0), NULL)) AS '29周',
GROUP_CONCAT(if(k4.weeks = 30, coalesce(k4.week_money,0), NULL)) AS '30周',  
GROUP_CONCAT(if(k4.weeks = 31, coalesce(k4.week_money,0), NULL)) AS '31周',
GROUP_CONCAT(if(k4.weeks = 32, coalesce(k4.week_money,0), NULL)) AS '32周',  
GROUP_CONCAT(if(k4.weeks = 33, coalesce(k4.week_money,0), NULL)) AS '33周',
GROUP_CONCAT(if(k4.weeks = 34, coalesce(k4.week_money,0), NULL)) AS '34周',  
GROUP_CONCAT(if(k4.weeks = 35, coalesce(k4.week_money,0), NULL)) AS '35周',
GROUP_CONCAT(if(k4.weeks = 36, coalesce(k4.week_money,0), NULL)) AS '36周',  
GROUP_CONCAT(if(k4.weeks = 37, coalesce(k4.week_money,0), NULL)) AS '37周',
GROUP_CONCAT(if(k4.weeks = 38, coalesce(k4.week_money,0), NULL)) AS '38周',  
GROUP_CONCAT(if(k4.weeks = 39, coalesce(k4.week_money,0), NULL)) AS '39周',
GROUP_CONCAT(if(k4.weeks = 40, coalesce(k4.week_money,0), NULL)) AS '40周',
GROUP_CONCAT(if(k4.weeks = 41, coalesce(k4.week_money,0), NULL)) AS '31周',
GROUP_CONCAT(if(k4.weeks = 42, coalesce(k4.week_money,0), NULL)) AS '32周',  
GROUP_CONCAT(if(k4.weeks = 43, coalesce(k4.week_money,0), NULL)) AS '33周',
GROUP_CONCAT(if(k4.weeks = 44, coalesce(k4.week_money,0), NULL)) AS '34周'
FROM (
SELECT k1.f_uid, k2.f_username, k2.f_regtime, k2.weeks as reg_weeks, k1.tag, k3.weeks as weeks, k3.moneys as week_money
FROM 
(SELECT a.*,  case 
	when a.moneys between 3500 and 10000 then '3.5k-1w'
    when a.moneys between 10000 and 50000 then '1w-5w'
    when a.moneys between 50000 and 100000 then '5w-10w'
    ELSE '10W+'
    END AS tag
FROM (
SELECT f_uid, sum(f_money) as  moneys
FROM t_diamond_recharge
where f_uid in (select f_uid from t_user where f_vip=5) AND f_orderstatus=1
group by f_uid)a)k1
inner join 
# 查用户注册时间，周
(select f_uid, f_username, f_regtime, week(f_regtime) as weeks 
from t_user where f_vip=5)k2
INNER JOIN 
#查询用户周充值
(SELECT f_uid, week(f_crtime) as weeks, sum(f_money) as moneys
FROM t_diamond_recharge
WHERE f_uid in (select f_uid from t_user where f_vip=5) AND f_orderstatus=1 AND f_crtime > "2017-05-01"
GROUP BY f_uid, week(f_crtime))k3
ON k1.f_uid=k2.f_uid AND k2.f_uid=k3.f_uid)k4
GROUP BY f_uid;