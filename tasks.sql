SELECT f_inout, sum(f_golds) as golds
FROM t_gold_log
WHERE f_inout in (1, 14) AND f_crtime BETWEEN "2017-02-20" AND "2017-09-21"  
AND f_uid in (
	SELECT f_uid
		FROM (
		# query ..
			SELECT *, CASE 
				WHEN moneys BETWEEN 0 AND 100 then 'vip1'
				WHEN moneys BETWEEN 100 AND 500 then 'vip2'
				WHEN moneys BETWEEN 500 AND 1500 then 'vip3'
				WHEN moneys BETWEEN 1500 AND 3500 then 'vip4'
				WHEN moneys BETWEEN 3500 AND 50000 then 'vip5'
				ELSE 'vip6'  END as tags
			FROM (
				SELECT f_uid, sum(f_money) as moneys
				FROM t_diamond_recharge
				WHERE f_orderstatus=1 AND f_crtime BETWEEN "2017-02-20" AND "2017-09-21"
				GROUP BY f_uid)a)b 
				WHERE b.tags='vip2')
GROUP BY f_inout;