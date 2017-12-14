SELECT a.f_uid, a.min_time , b.f_crtime , b.prize , b.golds , b.prize - b.golds as profit, b.f_oid as oid
FROM
(SELECT f_uid, min(f_crtime) as min_time
FROM t_diamond_recharge
WHERE concat(f_uid, f_money) in (SELECT concat(f_uid, max(f_money)) as uid_money
FROM t_diamond_recharge
WHERE f_uid in (1109510,1114844,1253484,1210299) AND f_orderstatus=1
GROUP BY f_uid)
group by f_uid)a
INNER JOIN 
(SELECT f_uid, f_prize as prize , f_golds as golds, f_crtime, f_oid
FROM t_gold_order
WHERE f_uid in (1109510,1114844,1253484,1210299) AND f_orderstatus=2)b
ON a.f_uid=b.f_uid AND b.f_crtime < a.min_time) x1


