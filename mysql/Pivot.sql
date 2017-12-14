# The Example data
#
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

# group by status

select uid, status, count(uid) 
from login_log
group by uid, status

# result show
+------+--------+------------+
| uid  | status | count(uid) |
+------+--------+------------+
|  101 | ok     |          5 |
|  102 | pass   |          4 |
|  103 | ok     |          1 |
|  103 | pass   |          1 |
|  103 | verify |          1 |
+------+--------+------------+

# do a rotation with query result

select uid, sum(status='pass') as pass, sum(status='ok') as ok, 
sum(status='verify') as verify
from login_log
group by uid

# result show as below :
+------+------+------+--------+
| uid  | pass | ok   | verify |
+------+------+------+--------+
|  101 |    0 |    5 |      0 |
|  102 |    4 |    0 |      0 |
|  103 |    1 |    1 |      1 |
+------+------+------+--------+