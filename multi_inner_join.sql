

# example data ==
mysql> select * from login_log;
+------+-------+--------+
| uid  | logid | status |
+------+-------+--------+
|  101 |     1 | ok     |
|  101 |     5 | ok     |
|  101 |     9 | ok     |
|  102 |     2 | pass   |
|  101 |     3 | ok     |
|  101 |     4 | ok     |
|  102 |     6 | pass   |
|  102 |     7 | pass   |
|  102 |     8 | pass   |
|  103 |    10 | ok     |
|  103 |    11 | pass   |
|  103 |    12 | verify |
+------+-------+--------+
mysql> select * from user;
+------+----------+
| uid  | name     |
+------+----------+
|  101 | Frank    |
|  102 | Jack     |
|  103 | Landpack |
|  104 | Hokey    |
|  105 | iq       |
+------+----------+
-- mysql> select * from  account;
+------+---------+
| uid  | money   |
+------+---------+
|  103 | 1000.00 |
|  102 | 1890.00 |
|  101 | 2230.00 |
|  104 |  430.00 |
+------+---------+
## after multi inner join
select a.uid , a.name, b.money, c.logid 
from (select * from user)a 
inner join (select * from account)b 
inner join (select uid, sum(logid) as logid from login_log GROUP BY uid)c 
on a.uid=b.uid and a.uid=c.uid;
# result show as below
+------+----------+---------+-------+
| uid  | name     | money   | logid |
+------+----------+---------+-------+
|  103 | Landpack | 1000.00 |    33 |
|  102 | Jack     | 1890.00 |    23 |
|  101 | Frank    | 2230.00 |    22 |
+------+----------+---------+-------+ 
# if use just want no login user join with part
SELECT a_uid, a_name, b_money, c.logid from (
select a.uid as a_uid, a.name as a_name, b.money as b_money
from (select * from user)a 
inner join (select * from account)b 
on a.uid=b.uid)d
LEFT JOIN (select uid, sum(logid) as logid from login_log GROUP BY uid)c 
ON d.a_uid=c.uid;

# and then you got 
+-------+----------+---------+-------+
| a_uid | a_name   | b_money | logid |
+-------+----------+---------+-------+
|   103 | Landpack | 1000.00 |    33 |
|   102 | Jack     | 1890.00 |    23 |
|   101 | Frank    | 2230.00 |    22 |
|   104 | Hokey    |  430.00 |  NULL |
+-------+----------+---------+-------+


# apply on some where

SELECT i.b_uid, i.a_type, i.c_total, i.b_level, d.moneys FROM (
SELECT b.f_uid as b_uid,a.f_type as a_type, c.f_total as c_total, b.f_level AS b_level FROM 
(
SELECT f_uid, f_type FROM t_user
WHERE f_uid in (
SELECT f_related_uid as f_uid
FROM t_500vips
WHERE f_level < 13 AND f_related_uid IS NOT NULL))a
INNER JOIN 
(SELECT f_related_uid as f_uid, f_level, f_consume_info
FROM t_500vips
WHERE f_level < 13 AND f_related_uid IS NOT NULL)b
INNER JOIN 
(SELECT f_uid, f_total FROM t_gold_account
WHERE f_uid in (
SELECT f_related_uid as f_uid
FROM t_500vips
WHERE f_level < 13 AND f_related_uid IS NOT NULL))c
ON a.f_uid=b.f_uid AND c.f_uid=b.f_uid)i
LEFT JOIN 
(SELECT f_uid, sum(f_money) as moneys FROM t_diamond_recharge 
WHERE f_orderstatus=1 AND  f_uid in (
SELECT f_related_uid as f_uid
FROM t_500vips
WHERE f_level < 13 AND f_related_uid IS NOT NULL)
GROUP BY f_uid)d
ON i.b_uid=d.f_uid;


