#查找登陆日志中，最后登录的一条记录
#查找到logid (唯一索引键后)
SELECT min(f_logid) as latest, max(f_logid) as lasttime
FROM t_user_login_log
WHERE f_logtime BETWEEN "2017-08-01" AND "2017-08-02";

#通过索引卡死范围
SELECT f_uid, f_logid
FROM t_user_login_log
GROUP BY f_uid
HAVING MAX(f_logid) BETWEEN 193518 and 196125;


#查询这些用户的相关用户信息(分类确认来源，平台等)
SELECT *
FROM t_user 
WHERE f_uid in (
SELECT f_uid
FROM t_user_login_log
GROUP BY f_uid
HAVING MAX(f_logid) BETWEEN 7501379 and 7516830);



#查询特定用户信息
SELECT f_inout, sum(f_golds)
FROM t_gold_log
WHERE f_uid=1540335
GROUP BY f_inout;


SELECT *
FROM t_gold_log
WHERE f_uid=1540344；