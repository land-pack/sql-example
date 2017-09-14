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

