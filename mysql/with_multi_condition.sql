#     =========mission 1 ==
SELECT a.f_uid, a.f_username, a.f_regtime,b.first_time,b.first_money,
d2.moneys as total_moneys, c.exchange_time, c.tickets, d.consums, e.f_crtime as free_wheel_time, f.f_crtime as wheel_time,
g.f_crtime as max_rcg_time, g.max_money, h.counter, h.total_recharge, h1.alive_days
FROM (
SELECT f_uid, f_username, f_regtime
FROM t_user 
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154))a
INNER JOIN 
# first recharge time
(SELECT f_uid, f_crtime as first_time, f_money as first_money 
FROM t_diamond_recharge WHERE 
f_oid in (
		SELECT i.min_oid as f_oid 
        FROM (SELECT f_uid, min(f_oid) as min_oid
				FROM t_diamond_recharge 
				WHERE f_uid in (1102802,1132903,1225783,1246853,1098154) AND f_orderstatus=1
				GROUP BY f_uid)i
))b

INNER JOIN
# THAT DAY RECAHRGE TOTALS
(
select q1.f_uid as f_uid, sum(f_money) as moneys from t_diamond_recharge q1, 
(SELECT f_uid, min(f_crtime) as f_crtime
FROM t_diamond_recharge
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154) AND f_orderstatus=1
group by f_uid) w1
where  
q1.f_uid = w1.f_uid and date(q1.f_crtime) = date(w1.f_crtime)
group by q1.f_uid)d2

INNER JOIN
# first exchange oid
(SELECT f_uid , f_crtime as exchange_time, f_consum as tickets
FROM t_exchangetkt_order WHERE f_oid 
in (
SELECT min(f_oid) as f_oid
FROM t_exchangetkt_order
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154) AND f_orderstatus=1 AND f_consum_type=3
GROUP BY f_uid))c

INNER JOIN
# first day exchange
(select q.f_uid as f_uid, sum(f_consum) as consums from t_exchangetkt_order q, 
(SELECT f_uid, min(f_crtime) as f_crtime
FROM t_exchangetkt_order
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154) AND f_orderstatus=1 AND f_consum_type=3
group by f_uid) w
where  
q.f_uid = w.f_uid and date(q.f_crtime) = date(w.f_crtime)
group by q.f_uid)d
INNER JOIN
#first time play wheel
(SELECT f_uid, f_crtime 
FROM t_wheel_order 
WHERE f_oid in (
SELECT min(f_oid) as f_oid
FROM t_wheel_order
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154)
GROUP BY f_uid))e

INNER JOIN 
# the first time to play 5w or 6w wheel 
(SELECT f_uid, f_crtime 
FROM t_wheel_order 
WHERE f_oid in (
SELECT COALESCE(min(f_oid), f_uid) as f_oid
FROM t_wheel_order
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154) and f_golds in (60000, 50000)
GROUP BY f_uid))f

INNER JOIN 
# the biggest value to recharge
(SELECT f_uid, min(f_crtime) AS f_crtime , max(f_money) as max_money
FROM t_diamond_recharge 
WHERE f_orderstatus=1 AND f_uid in (1102802,1132903,1225783,1246853,1098154) AND f_money in (1000.0000, 648.0000)
GROUP BY f_uid)g
INNER JOIN 
# recharge time counter
(SELECT f_uid, count(f_uid) as counter, sum(f_money) as total_recharge
FROM t_diamond_recharge
WHERE f_orderstatus=1 AND f_uid in (1102802,1132903,1225783,1246853,1098154)
group BY f_uid)h
INNER JOIN
# alive days
(SELECT f_uid, datediff(curdate(), f_regtime) as alive_days
FROM t_user
WHERE f_uid in (1102802,1132903,1225783,1246853,1098154))h1
ON a.f_uid = b.f_uid AND b.f_uid=d2.f_uid AND b.f_uid=c.f_uid AND c.f_uid=d.f_uid 
AND d.f_uid=e.f_uid AND e.f_uid=f.f_uid AND f.f_uid=g.f_uid AND g.f_uid=h.f_uid 
AND h.f_uid=h1.f_uid;

