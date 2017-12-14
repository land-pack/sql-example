
SELECT q1.f_uid, q1.golds, q1.first_time, q1.max_golds, q2.first_max_time, q3.f_golds, q3.prize_crtime
FROM (
SELECT f_uid, sum(f_golds) as golds, min(f_crtime) as first_time, min(f_golds) as max_golds
FROM t_gold_log
WHERE f_golds < 0 and f_inout=1 AND f_uid in (1109510,1114844,1253484,1210299)
GROUP BY f_uid)q1
INNER JOIN 
(
SELECT c.f_uid, min(c.f_crtime) as first_max_time, c.max_golds
FROM (
SELECT a.f_uid, a.f_crtime , b.max_golds FROM t_gold_log a
INNER JOIN 
# max place golds on single order
(SELECT f_uid, min(f_golds) as max_golds 
FROM t_gold_log WHERE f_golds < 0 and f_inout=1 AND f_uid in (1109510,1114844,1253484,1210299)
GROUP BY f_uid)b
ON a.f_uid=b.f_uid AND b.max_golds=a.f_golds)c
group by f_uid)q2

INNER JOIN 
# max prize on single order
(SELECT c.f_uid, c.f_golds, min(c.f_crtime) as prize_crtime
FROM
(SELECT a.f_uid, a.f_golds, a.f_crtime
FROM t_gold_log a
INNER JOIN
(SELECT f_uid, max(f_golds) as max_prize
FROM t_gold_log
WHERE f_inout=2 AND f_golds > 0 AND f_uid in (1109510,1114844,1253484,1210299)
GROUP BY f_uid)b
ON a.f_uid=b.f_uid AND a.f_golds=b.max_prize)c
GROUP BY c.f_uid, c.f_golds)q3
ON q1.f_uid=q2.f_uid AND q2.f_uid=q3.f_uid;