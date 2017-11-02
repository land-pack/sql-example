select * from account_audit;



+----+-----+---------------------+---------+--------+
| id | uid | changedat           | money   | action |
+----+-----+---------------------+---------+--------+
|  1 | 101 | 2017-08-28 11:44:53 | 2230.00 | update |
|  2 | 105 | 2017-09-28 11:44:53 | 2338.00 | update |
|  3 | 102 | 2017-10-18 11:44:53 | 2311.99 | update |
|  4 | 103 | 2017-11-01 10:14:53 |   11.99 | update |
|  5 | 102 | 2017-12-01 10:14:53 | 1088.33 | update |
|  6 | 105 | 2017-08-28 11:44:53 |   88.33 | update |
+----+-----+---------------------+---------+--------+

# I want get each week average data ..

select week(changedat) as the_week, sum(money) /count(distinct uid) as average_money
from account_audit
group by week(changedat)


# and then I got 
+----------+---------------+
| the_week | average_money |
+----------+---------------+
|       35 |   1159.165000 |
|       39 |   2338.000000 |
|       42 |   2311.990000 |
|       44 |     11.990000 |
|       48 |   1088.330000 |
+----------+---------------+

# but the PMP said , you got do a split by user money level
# if user money > 2000 , put it to a, else put it to b
SELECT a.*, CASE
WHEN total_money > 2000 then '2k+'
ELSE '2k-' END as level FROM (
SELECT uid, sum(money) as total_money
FROM account_audit
GROUP BY uid)a;


# I got a list as below
+-----+-------------+-------+
| uid | total_money | level |
+-----+-------------+-------+
| 101 |     2230.00 | 2k+   |
| 102 |     3400.32 | 2k+   |
| 103 |       11.99 | 2k-   |
| 105 |     2426.33 | 2k+   |
+-----+-------------+-------+

# I know i can do this by many way, the simple one is like 
# below.

# 2k+ uid
SELECT uid
FROM (
SELECT uid, sum(money) as total_money
FROM account_audit
GROUP BY uid)a
WHERE total_money > 2000;


+-----+
| uid |
+-----+
| 101 |
| 102 |
| 105 |
+-----+
# 
# 2k- uid
SELECT uid
FROM (
SELECT uid, sum(money) as total_money
FROM account_audit
GROUP BY uid)a
WHERE total_money < 2000;


+-----+
| uid |
+-----+
| 103 |
+-----+

# ====

