#
mysql> select * from user_table;
+--------+------+------+
| name   | dep  | uid  |
+--------+------+------+
| frank  | IT   | 1001 |
| jack   | IT   | 1002 |
| Sissel | FA   | 1003 |
| Li     | IT   | 1004 |
| Mok    | PM   | 1005 |
+--------+------+------+

# money_log table 
mysql> select * from money_log;
+------+-------+
| uid  | money |
+------+-------+
| 1001 |  9989 |
| 1001 |    89 |
| 1001 |   189 |
| 1002 |   389 |
+------+-------+

# aggre
SELECT uid, sum(money) as moneys
FROM money_log
WHERE uid in (
	SELECT uid 
	FROM user_table
	WHERE dep='IT'
) 
GROUP BY uid;

# The result is given those.
+------+--------+
| uid  | moneys |
+------+--------+
| 1001 |  10267 |
| 1002 |    389 |
+------+--------+

# What I expect is :
+------+--------+
| uid  | moneys |
+------+--------+
| 1001 |  10267 |
| 1002 |    389 |
| 1004 |    0   |
+------+--------+


# 
select u.uid, coalesce(sum(m.money),0) as money
from user_table u
left join money_log m on u.uid = m.uid  
where u.dep = 'IT'
group by u.uid

