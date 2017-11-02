#查询用户的周平均充值
#分4类用户查询
SELECT tag, 
sum(coalesce(k5.w18, 0)) AS 第18周总充值, sum(k5.k5.w18 is Not NULL) as 第18周总充值人数, (sum(coalesce(k5.w18, 0)) / sum(k5.k5.w18 is Not NULL)) as 第18周平均充值,
sum(coalesce(k5.w19, 0)) AS 第19周总充值, sum(k5.k5.w19 is Not NULL) as 第19周总充值人数, (sum(coalesce(k5.w19, 0)) / sum(k5.k5.w19 is Not NULL)) as 第19周平均充值,
sum(coalesce(k5.w20, 0)) AS 第20周总充值, sum(k5.k5.w20 is Not NULL) as 第20周总充值人数, (sum(coalesce(k5.w20, 0)) / sum(k5.k5.w20 is Not NULL)) as 第20周平均充值,
sum(coalesce(k5.w21, 0)) AS 第21周总充值, sum(k5.k5.w21 is Not NULL) as 第21周总充值人数, (sum(coalesce(k5.w21, 0)) / sum(k5.k5.w21 is Not NULL)) as 第21周平均充值,
sum(coalesce(k5.w22, 0)) AS 第22周总充值, sum(k5.k5.w22 is Not NULL) as 第22周总充值人数, (sum(coalesce(k5.w22, 0)) / sum(k5.k5.w22 is Not NULL)) as 第22周平均充值,
sum(coalesce(k5.w23, 0)) AS 第23周总充值, sum(k5.k5.w23 is Not NULL) as 第23周总充值人数, (sum(coalesce(k5.w23, 0)) / sum(k5.k5.w23 is Not NULL)) as 第23周平均充值,
sum(coalesce(k5.w24, 0)) AS 第24周总充值, sum(k5.k5.w24 is Not NULL) as 第24周总充值人数, (sum(coalesce(k5.w24, 0)) / sum(k5.k5.w24 is Not NULL)) as 第24周平均充值,
sum(coalesce(k5.w25, 0)) AS 第25周总充值, sum(k5.k5.w25 is Not NULL) as 第25周总充值人数, (sum(coalesce(k5.w25, 0)) / sum(k5.k5.w25 is Not NULL)) as 第25周平均充值,
sum(coalesce(k5.w26, 0)) AS 第26周总充值, sum(k5.k5.w26 is Not NULL) as 第26周总充值人数, (sum(coalesce(k5.w26, 0)) / sum(k5.k5.w26 is Not NULL)) as 第26周平均充值,
sum(coalesce(k5.w27, 0)) AS 第27周总充值, sum(k5.k5.w27 is Not NULL) as 第27周总充值人数, (sum(coalesce(k5.w27, 0)) / sum(k5.k5.w27 is Not NULL)) as 第27周平均充值,
sum(coalesce(k5.w28, 0)) AS 第28周总充值, sum(k5.k5.w28 is Not NULL) as 第28周总充值人数, (sum(coalesce(k5.w28, 0)) / sum(k5.k5.w28 is Not NULL)) as 第28周平均充值,
sum(coalesce(k5.w29, 0)) AS 第29周总充值, sum(k5.k5.w29 is Not NULL) as 第29周总充值人数, (sum(coalesce(k5.w29, 0)) / sum(k5.k5.w29 is Not NULL)) as 第29周平均充值,
sum(coalesce(k5.w30, 0)) AS 第30周总充值, sum(k5.k5.w30 is Not NULL) as 第30周总充值人数, (sum(coalesce(k5.w30, 0)) / sum(k5.k5.w30 is Not NULL)) as 第30周平均充值,
sum(coalesce(k5.w31, 0)) AS 第31周总充值, sum(k5.k5.w31 is Not NULL) as 第31周总充值人数, (sum(coalesce(k5.w31, 0)) / sum(k5.k5.w31 is Not NULL)) as 第31周平均充值,
sum(coalesce(k5.w32, 0)) AS 第32周总充值, sum(k5.k5.w32 is Not NULL) as 第32周总充值人数, (sum(coalesce(k5.w32, 0)) / sum(k5.k5.w32 is Not NULL)) as 第32周平均充值,
sum(coalesce(k5.w33, 0)) AS 第33周总充值, sum(k5.k5.w33 is Not NULL) as 第33周总充值人数, (sum(coalesce(k5.w33, 0)) / sum(k5.k5.w33 is Not NULL)) as 第33周平均充值,
sum(coalesce(k5.w34, 0)) AS 第34周总充值, sum(k5.k5.w34 is Not NULL) as 第34周总充值人数, (sum(coalesce(k5.w34, 0)) / sum(k5.k5.w34 is Not NULL)) as 第34周平均充值,
sum(coalesce(k5.w35, 0)) AS 第35周总充值, sum(k5.k5.w35 is Not NULL) as 第35周总充值人数, (sum(coalesce(k5.w35, 0)) / sum(k5.k5.w35 is Not NULL)) as 第35周平均充值,
sum(coalesce(k5.w36, 0)) AS 第36周总充值, sum(k5.k5.w36 is Not NULL) as 第36周总充值人数, (sum(coalesce(k5.w36, 0)) / sum(k5.k5.w36 is Not NULL)) as 第36周平均充值,
sum(coalesce(k5.w37, 0)) AS 第37周总充值, sum(k5.k5.w37 is Not NULL) as 第37周总充值人数, (sum(coalesce(k5.w37, 0)) / sum(k5.k5.w37 is Not NULL)) as 第37周平均充值,
sum(coalesce(k5.w38, 0)) AS 第38周总充值, sum(k5.k5.w38 is Not NULL) as 第38周总充值人数, (sum(coalesce(k5.w38, 0)) / sum(k5.k5.w38 is Not NULL)) as 第38周平均充值,
sum(coalesce(k5.w39, 0)) AS 第39周总充值, sum(k5.k5.w39 is Not NULL) as 第39周总充值人数, (sum(coalesce(k5.w39, 0)) / sum(k5.k5.w39 is Not NULL)) as 第39周平均充值,
sum(coalesce(k5.w40, 0)) AS 第40周总充值, sum(k5.k5.w40 is Not NULL) as 第40周总充值人数, (sum(coalesce(k5.w40, 0)) / sum(k5.k5.w40 is Not NULL)) as 第40周平均充值,
sum(coalesce(k5.w41, 0)) AS 第41周总充值, sum(k5.k5.w41 is Not NULL) as 第41周总充值人数, (sum(coalesce(k5.w41, 0)) / sum(k5.k5.w41 is Not NULL)) as 第41周平均充值,
sum(coalesce(k5.w42, 0)) AS 第42周总充值, sum(k5.k5.w42 is Not NULL) as 第42周总充值人数, (sum(coalesce(k5.w42, 0)) / sum(k5.k5.w42 is Not NULL)) as 第42周平均充值,
sum(coalesce(k5.w43, 0)) AS 第43周总充值, sum(k5.k5.w43 is Not NULL) as 第43周总充值人数, (sum(coalesce(k5.w43, 0)) / sum(k5.k5.w43 is Not NULL)) as 第43周平均充值,
sum(coalesce(k5.w44, 0)) AS 第44周总充值, sum(k5.k5.w44 is Not NULL) as 第44周总充值人数, (sum(coalesce(k5.w44, 0)) / sum(k5.k5.w44 is Not NULL)) as 第44周平均充值
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