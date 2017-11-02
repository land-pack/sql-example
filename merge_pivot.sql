SELECT tag, 
sum(coalesce(k5.w18, 0)) AS w18money, sum(k5.k5.w18 is Not NULL) as w18user, (sum(coalesce(k5.w18, 0)) / sum(k5.k5.w18 is Not NULL)) as w18avg
FROM (
SELECT f_uid, k4.f_username as 用户名, k4.f_regtime as 注册时间, k4.reg_weeks as 注册周, k4.tag as tag,
GROUP_CONCAT(if(k4.weeks = 18, k4.week_money, NULL)) AS w18,  
GROUP_CONCAT(if(k4.weeks = 19, k4.week_money, NULL)) AS w19,
GROUP_CONCAT(if(k4.weeks = 20, k4.week_money, NULL)) AS w20,  
GROUP_CONCAT(if(k4.weeks = 21, k4.week_money, NULL)) AS w21,
GROUP_CONCAT(if(k4.weeks = 22, k4.week_money, NULL)) AS w22,  
GROUP_CONCAT(if(k4.weeks = 23, k4.week_money, NULL)) AS w23,
GROUP_CONCAT(if(k4.weeks = 24, k4.week_money, NULL)) AS w24,  
GROUP_CONCAT(if(k4.weeks = 25, k4.week_money, NULL)) AS w25,
GROUP_CONCAT(if(k4.weeks = 26, k4.week_money, NULL)) AS w26,  
GROUP_CONCAT(if(k4.weeks = 27, k4.week_money, NULL)) AS w27,
GROUP_CONCAT(if(k4.weeks = 28, k4.week_money, NULL)) AS w28,  
GROUP_CONCAT(if(k4.weeks = 29, k4.week_money, NULL)) AS w29,
GROUP_CONCAT(if(k4.weeks = 30, k4.week_money, NULL)) AS w30,  
GROUP_CONCAT(if(k4.weeks = 31, k4.week_money, NULL)) AS w31,
GROUP_CONCAT(if(k4.weeks = 32, k4.week_money, NULL)) AS w32,  
GROUP_CONCAT(if(k4.weeks = 33, k4.week_money, NULL)) AS w33,
GROUP_CONCAT(if(k4.weeks = 34, k4.week_money, NULL)) AS w34,  
GROUP_CONCAT(if(k4.weeks = 35, k4.week_money, NULL)) AS w35,
GROUP_CONCAT(if(k4.weeks = 36, k4.week_money, NULL)) AS w36,  
GROUP_CONCAT(if(k4.weeks = 37, k4.week_money, NULL)) AS w37,
GROUP_CONCAT(if(k4.weeks = 38, k4.week_money, NULL)) AS w38,  
GROUP_CONCAT(if(k4.weeks = 39, k4.week_money, NULL)) AS w39,
GROUP_CONCAT(if(k4.weeks = 40, k4.week_money, NULL)) AS w40,
GROUP_CONCAT(if(k4.weeks = 41, k4.week_money, NULL)) AS w41,
GROUP_CONCAT(if(k4.weeks = 42, k4.week_money, NULL)) AS w42,  
GROUP_CONCAT(if(k4.weeks = 43, k4.week_money, NULL)) AS w43,
GROUP_CONCAT(if(k4.weeks = 44, k4.week_money, NULL)) AS w44
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
GROUP BY f_uid)k5
group by tag;