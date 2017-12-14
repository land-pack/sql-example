# I have two table  as below show:

+------+----------+
| uid  | name     |
+------+----------+
|  101 | Frank    |
|  102 | Jack     |
|  103 | Landpack |
|  104 | Hokey    |
|  105 | iq       |
+------+----------+

# `login_log` table

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

# I want to know those user login counter
# status set ok is login success.

SELECT a.uid, a.name, b.counter
FROM 
(
	select uid, name
	from user
)a
INNER JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
ON a.uid=b.uid;


# and then i got
+------+----------+---------+
| uid  | name     | counter |
+------+----------+---------+
|  101 | Frank    |       5 |
|  102 | Jack     |       0 |
|  103 | Landpack |       1 |
+------+----------+---------+

# I have lost those people who have not login record ..
# how to avoid this happen .. 
# try left join
SELECT a.uid, a.name, b.counter
FROM 
(
	select uid, name
	from user
)a
LEFT JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
ON a.uid=b.uid;

+------+----------+---------+
| uid  | name     | counter |
+------+----------+---------+
|  101 | Frank    |       5 |
|  102 | Jack     |       0 |
|  103 | Landpack |       1 |
|  104 | Hokey    |    NULL |
|  105 | iq       |    NULL |
+------+----------+---------+
# I got NULL, I know I can use  COALESCE to replace NULL with 0

SELECT a.uid, a.name, COALESCE(b.counter, 0) as counter
FROM 
(
	select uid, name
	from user
)a
LEFT JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
ON a.uid=b.uid;
# After query again .
+------+----------+---------+
| uid  | name     | counter |
+------+----------+---------+
|  101 | Frank    |       5 |
|  102 | Jack     |       0 |
|  103 | Landpack |       1 |
|  104 | Hokey    |       0 |
|  105 | iq       |       0 |
+------+----------+---------+
# It seems everything work fine so far, but if I have a little complex query .
# I create a new table as user account .
mysql> select * from account;
+------+---------+
| uid  | money   |
+------+---------+
|  103 | 1000.00 |
|  102 | 1890.00 |
|  101 |  222.99 |
|  104 |  430.00 |
|  105 |   18.33 |
+------+---------+

# and then I try to query three table with only one sql 
SELECT a.uid, a.name, COALESCE(b.counter, 0) as counter, c.money
FROM 
(
	select uid, name
	from user
)a
LEFT JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
INNER JOIN 
(
	SELECT uid, money 
	FROM account
)c
ON a.uid=b.uid AND b.uid=c.uid;
# it's show a error .
# ERROR 1064 (42000): You have an error in your SQL syntax; 
# check the manual that corresponds to your MySQL server version 
# for the right syntax to use near '' at line 18 
# If i set both join as `inner join` is work fine.
SELECT a.uid, a.name, COALESCE(b.counter, 0) as counter, c.money
FROM 
(
	select uid, name
	from user
)a
INNER JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
INNER JOIN 
(
	SELECT uid, money 
	FROM account
)c
ON a.uid=b.uid AND b.uid=c.uid;
# I got a result as below :
+------+----------+---------+---------+
| uid  | name     | counter | money   |
+------+----------+---------+---------+
|  103 | Landpack |       1 | 1000.00 |
|  102 | Jack     |       0 | 1890.00 |
|  101 | Frank    |       5 |  222.99 |
+------+----------+---------+---------+
# But i lost some user data again ...
# I tried to adjust the position of the two `JOIN`
SELECT a.uid, a.name, COALESCE(b.counter, 0) as counter, c.money
FROM 
(
	select uid, name
	from user
)a
INNER JOIN 
(
	SELECT uid, money 
	FROM account
)c
LEFT JOIN 
(
	select uid, sum(status='ok') as counter
	FROM login_log
	group by uid
)b
ON a.uid=b.uid AND b.uid=c.uid;

#The results of the query are repeated
+------+----------+---------+---------+
| uid  | name     | counter | money   |
+------+----------+---------+---------+
|  101 | Frank    |       0 | 1000.00 |
|  102 | Jack     |       0 | 1000.00 |
|  103 | Landpack |       1 | 1000.00 |
|  104 | Hokey    |       0 | 1000.00 |
|  105 | iq       |       0 | 1000.00 |
|  101 | Frank    |       0 | 1890.00 |
|  102 | Jack     |       0 | 1890.00 |
|  103 | Landpack |       0 | 1890.00 |
|  104 | Hokey    |       0 | 1890.00 |
|  105 | iq       |       0 | 1890.00 |
|  101 | Frank    |       5 |  222.99 |
|  102 | Jack     |       0 |  222.99 |
|  103 | Landpack |       0 |  222.99 |
|  104 | Hokey    |       0 |  222.99 |
|  105 | iq       |       0 |  222.99 |
|  101 | Frank    |       0 |  430.00 |
|  102 | Jack     |       0 |  430.00 |
|  103 | Landpack |       0 |  430.00 |
|  104 | Hokey    |       0 |  430.00 |
|  105 | iq       |       0 |  430.00 |
|  101 | Frank    |       0 |   18.33 |
|  102 | Jack     |       0 |   18.33 |
|  103 | Landpack |       0 |   18.33 |
|  104 | Hokey    |       0 |   18.33 |
|  105 | iq       |       0 |   18.33 |
+------+----------+---------+---------+

# This is not the result I am looking for

SELECT a.uid, a.name, COALESCE(b.counter, 0) as counter, c.money
FROM 
(
	select uid, name
	from user
)a
INNER JOIN 
(
	SELECT uid, money 
	FROM account
)c
INNER JOIN 
(
select uid, sum(counter) as counter
FROM 
(select uid, sum(status='ok') as counter
FROM login_log
group by uid
union
select uid, 0
from user)f
group by uid
)b
ON a.uid=b.uid AND b.uid=c.uid;

# Got the results I expected
+------+----------+---------+---------+
| uid  | name     | counter | money   |
+------+----------+---------+---------+
|  103 | Landpack |       1 | 1000.00 |
|  102 | Jack     |       0 | 1890.00 |
|  101 | Frank    |       5 |  222.99 |
|  104 | Hokey    |       0 |  430.00 |
|  105 | iq       |       0 |   18.33 |
+------+----------+---------+---------+

# But I was wondering if there was hack technology to do this？