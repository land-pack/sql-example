# while + join + 


#==============================
# login user
SELECT count(distinct f_uid) as active
FROM t_user_login_log
WHERE DATE(f_logtime) = "2017-08-01";

#==============================
# recharge user
SELECT count(distinct f_uid) as recharge_user, sum(f_money) as recharge, sum(f_money)/count(distinct f_uid) as arpu
FROM t_diamond_recharge 
WHERE f_orderstatus=1 AND DATE(f_crtime) = "2017-08-01";

#===============================
# new user 
SELECT COUNT(f_uid) as new_user
FROM t_user
WHERE DATE(f_regtime) = "2017-08-01";

#================================
# lost user (15 day no login )
SELECT MAX(f_logid) as f_logid
FROM t_user_login_log
WHERE DATE(f_logtime) = DATE_SUB("2017-09-16", INTERVAL 15 DAY);

SELECT MIN(f_logid) as f_logid
FROM t_user_login_log
WHERE DATE(f_logtime) = DATE_SUB("2017-09-16", INTERVAL 15 DAY);

# After get the f_logid and then try below query

SELECT f_uid, max(f_logid) as max_logid
FROM t_user_login_log
GROUP BY f_uid
HAVING max(f_logid) BETWEEN 384102 AND 395379;


# COMBINE 
SELECT count(*) as lost_user
FROM (
SELECT f_uid
FROM t_user_login_log
GROUP BY f_uid
HAVING max(f_logid) BETWEEN 384102 AND 395379)a;

#===========================

#  no login for a long time user has come back user
SELECT DISTINCT f_uid as f_uid
FROM t_user_login_log
WHERE DATE(f_logtime) = "2017-09-01";

# 15 DAYS HAVED LOGIN USERS..
# THOSE NO LOGIN USER LOGIN AGAIN AFTER 15DAYS

SELECT DISTINCT f_uid as f_uid
FROM t_user_login_log
WHERE DATE(f_logtime) = "2017-08-17" AND f_uid NOT IN 
(
	SELECT f_uid FROM t_user WHERE f_regtime="2017-08-17"
) AND 
f_uid NOT IN 
(SELECT f_uid
FROM t_user_login_log
WHERE DATE(f_logtime) BETWEEN DATE_SUB("2017-08-17", INTERVAL 15 DAY) AND DATE_SUB("2017-08-17", INTERVAL 1 DAY))
GROUP BY f_uid;


try
	execute(sql)
	commit
catch:
	rollback
else:
	#success
	update_to_redis
#=======================