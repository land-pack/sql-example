####example table below
##
##mysql> select * from person;
##+----+-------+------+
##| id | gold  | uid  |
##+----+-------+------+
##|  1 |   120 | 1001 |
##|  2 | 14440 | 1002 |
##|  3 |    40 | 1003 |
##|  4 |   490 | 1005 |
##+----+-------+------+
##


# After doing the follow query
#

SELECT gold,t.tags, uid 
FROM (SELECT *, case  
    when gold BETWEEN 0 AND 200 then '0-200'  
    when gold BETWEEN 200 AND 500 THEN '0-500'  
    WHEN gold BETWEEN 500 AND 100000 THEN '500+'  
    ELSE '100000+'  END as tags FROM person)t 
GROUP BY t.tags, uid;

##+-------+-------+------+
##| gold  | tags  | uid  |
##+-------+-------+------+
##|   120 | 0-200 | 1001 |
##|    40 | 0-200 | 1003 |
##|   490 | 0-500 | 1005 |
##| 14440 | 500+  | 1002 |
##+-------+-------+------+



# group by data range 

SELECT *, case
    when gold BETWEEN 0 AND 2000 then '0-2000'  
    when gold BETWEEN 2000 AND 5000 THEN '2001-5000'  
    WHEN gold BETWEEN 5000 AND 10000 THEN '5001-10000'  
    WHEN gold BETWEEN 10000 AND 20000 THEN '10001-20000'
    WHEN gold BETWEEN 20000 AND 50000 THEN '20001-50000'  
    WHEN gold BETWEEN 50000 AND 100000 THEN '50001-100000' 
    WHEN gold BETWEEN 100000 AND 500000 THEN '100001-500000'  
    WHEN gold BETWEEN 500000 AND 1000000 THEN '500001-1000000' 
    ELSE '1000001'  END as tags
FROM (
SELECT f_uid, abs(sum(f_golds)) as gold
FROM t_gold_log
WHERE f_crtime between "2017-04-01" AND "2017-09-14" AND f_inout in (1, 14)
GROUP BY f_uid)a

# （wwh02) 
SELECT b.tags, count(*) as users, (count(*)/44)  as avg_users,sum(gold) FROM (
SELECT gold, case
    when gold BETWEEN 0 AND 2000 then '0-2000'  
    when gold BETWEEN 2000 AND 5000 THEN '2001-5000'  
    WHEN gold BETWEEN 5000 AND 10000 THEN '5001-10000'  
    WHEN gold BETWEEN 10000 AND 20000 THEN '10001-20000'
    WHEN gold BETWEEN 20000 AND 50000 THEN '20001-50000'  
    WHEN gold BETWEEN 50000 AND 100000 THEN '50001-100000' 
    WHEN gold BETWEEN 100000 AND 500000 THEN '100001-500000'  
    WHEN gold BETWEEN 500000 AND 1000000 THEN '500001-1000000' 
    ELSE '1000001'  END as tags
FROM (
SELECT f_uid, abs(sum(f_golds)) as gold
FROM t_gold_log
WHERE f_inout in (1, 14) AND  f_crtime between "2017-08-1" AND "2017-09-14"
GROUP BY f_uid)a)b
GROUP BY b.tags;



#（wh02/every day per user)
SELECT c.tags, sum(users) as users, sum(counter) as counter, sum(counter) / 44 as avg_user,sum(golds) as goldss
FROM (
SELECT tags, dated, count(*) as users, count(*) as counter,sum(gold) as golds FROM (
SELECT gold, dated, case
    when gold BETWEEN 0 AND 2000 then '0-2000'  
    when gold BETWEEN 2000 AND 5000 THEN '2001-5000'  
    WHEN gold BETWEEN 5000 AND 10000 THEN '5001-10000'  
    WHEN gold BETWEEN 10000 AND 20000 THEN '10001-20000'
    WHEN gold BETWEEN 20000 AND 50000 THEN '20001-50000'  
    WHEN gold BETWEEN 50000 AND 100000 THEN '50001-100000' 
    WHEN gold BETWEEN 100000 AND 500000 THEN '100001-500000'  
    WHEN gold BETWEEN 500000 AND 1000000 THEN '500001-1000000' 
    ELSE '1000001'  END as tags
FROM (
SELECT f_uid, abs(sum(f_golds)) as gold, DATE(f_crtime) AS dated
FROM t_gold_log
WHERE f_inout in (1, 14) AND  f_crtime between "2017-08-12" AND "2017-09-14"
GROUP BY f_uid, dated)a)b
GROUP BY tags, dated)c
GROUP BY c.tags;


# query accodring the user level (which decide the recharge moneys)

# query vip ~ user numbers
SELECT b.tags, count(f_uid) as users, sum(moneys) as moneys
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
GROUP BY b.tags;


# query user exchange 
SELECT sum(f_consum) as totals
FROM t_exchangetkt_order
WHERE f_orderstatus > -1 AND f_consum_type=3 AND f_crtime BETWEEN "2017-02-20" AND "2017-09-21" AND f_uid in (
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
GROUP BY f_uid)a)b WHERE b.tags='vip6');


# query user gold log
SELECT sum(f_golds) as golds
FROM t_gold_log
WHERE f_inout in (2, 15) AND f_crtime BETWEEN "2017-02-20" AND "2017-09-21"  AND f_uid in (
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
GROUP BY f_uid)a)b WHERE b.tags='vip1')
GROUP BY f_inout;

