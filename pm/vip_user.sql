SELECT s1.f_uid as 用户ID, s1.f_username as 用户名, s2.moneys 累计充值, s3.moneys as 月充值 , s4.consums as 月兑换,
s5.f_total as 金币剩余, s6.f_total as 钻石剩余, s7.f_total as 兑换券剩余, s8.login_time as 最后登录, s9.crtime as 最后充值,
s10.regtime as 注册时间
FROM (
#查询用户名
SELECT f_uid,f_username,f_realname
FROM t_user
WHERE f_uid in (SELECT f_uid
FROM t_user
WHERE f_level!=0 or f_vip=5))s1
INNER JOIN 
#大户累计充值
(SELECT f_uid, sum(f_money) as moneys
FROM t_diamond_recharge
WHERE f_uid in ( 
SELECT f_uid
FROM t_user
WHERE f_level!=0 or f_vip=5) AND f_orderstatus=1
GROUP BY f_uid)s2
inner JOIN 
# 某个月份的充值
(SELECT f_uid , sum(moneys) as moneys
FROM (
SELECT f_uid, sum(f_money) as moneys
FROM t_diamond_recharge
WHERE f_uid in ( 
SELECT f_uid
FROM t_user
WHERE f_level!=0 or f_vip=5) AND f_orderstatus=1 AND DATE_FORMAT(f_crtime, "%Y-%m") = "2017-10"
GROUP BY f_uid
UNION 
#填充无数据的用户
SELECT f_uid, 0
FROM t_user
WHERE f_level!=0 or f_vip=5)k1
GROUP BY f_uid
)s3
INNER JOIN

(SELECT f_uid , sum(consumes) as consums
FROM (
SELECT f_uid, sum(f_consum) as consumes
FROM t_exchangetkt_order
WHERE f_uid in ( 
SELECT f_uid
FROM t_user
WHERE f_level!=0 or f_vip=5) AND f_orderstatus>0 AND DATE_FORMAT(f_crtime, "%Y-%m") = "2017-10" AND f_consum_type=3
GROUP BY f_uid
UNION
SELECT f_uid, 0
FROM t_user
WHERE f_level!=0 or f_vip=5)k2
GROUP BY f_uid)s4
INNER JOIN 
#金币剩余
(SELECT f_uid, f_total 
FROM t_gold_log
WHERE f_tid in (
SELECT f_tid FROM (
SELECT f_uid, max(f_tid) as f_tid
FROM t_gold_log
WHERE f_uid in (select f_uid FROM t_user WHERE f_level!=0 or f_vip=5) AND f_crtime < "2017-11-01"
GROUP BY f_uid)a))s5
INNER JOIN 
(
SELECT f_uid, f_total
FROM t_diamond_log
WHERE f_tid in (
SELECT f_tid
FROM 
(SELECT f_uid, max(f_tid) as f_tid
FROM t_diamond_log
WHERE f_uid in (select f_uid FROM t_user WHERE f_level!=0 or f_vip=5) AND f_crtime < "2017-11-01"
GROUP BY f_uid)b)
)s6
INNER JOIN
# 兑换券剩余
(SELECT f_uid, f_total
FROM t_exchangetkt_log
WHERE f_tid in 
(SELECT f_tid
FROM (
SELECT f_uid, max(f_tid) as f_tid
FROM t_exchangetkt_log
WHERE f_uid in (select f_uid FROM t_user WHERE f_level!=0 or f_vip=5) AND f_crtime < "2017-11-01"
GROUP BY f_uid)c))s7
INNER JOIN 
# 最后登录时间
(SELECT f_uid, max(f_logtime) as login_time
FROM t_user_login_log
WHERE f_uid in (select f_uid FROM t_user WHERE f_level!=0 or f_vip=5) 
GROUP BY f_uid)s8
INNER JOIN
(SELECT f_uid, max(f_crtime) as crtime
FROM t_diamond_order
WHERE f_uid in (select f_uid FROM t_user WHERE f_level!=0 or f_vip=5) 
GROUP BY f_uid
)s9
INNER JOIN
(SELECT f_uid, min(f_regtime) as regtime
FROM t_user 
WHERE f_uid in ( 
SELECT f_uid
FROM t_user
WHERE f_level!=0 or f_vip=5)
GROUP BY f_uid)s10

ON s1.f_uid=s2.f_uid AND s1.f_uid=s3.f_uid AND s3.f_uid=s4.f_uid AND s4.f_uid=s5.f_uid 
AND s5.f_uid=s6.f_uid AND s6.f_uid=s7.f_uid AND s7.f_uid=s8.f_uid AND s8.f_uid=s9.f_uid
AND s9.f_uid=s10.f_uid;
