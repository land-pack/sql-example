# user NOT IN 
SELECT f_uid
FROM t_user_login_log
WHERE DATE(f_logtime) = "2017-08-3" AND f_uid NOT IN (
SELECT distinct f_uid
FROM t_user_login_log
WHERE DATE(f_logtime) = "2017-08-2");


# second way (use union)

SELECT a.f_uid FROM
(
	SELECT f_uid from t_user_login_log WHERE DATE(f_logtime) = "2017-08-2"
    UNION ALL 
    SELECT f_uid from t_user_login_log WHERE DATE(f_logtime) = "2017-08-3"
)a
GROUP BY a.f_uid HAVING count(a.f_uid)=1;




