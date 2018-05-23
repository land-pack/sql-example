# How to optimize your query

I am going to create a database name as `optimize_test`, and i will create a simple table by following instruction:

    create table user(id int auto_increment not null, name varchar(16), created timestamp default current_timestamp(), primary key(id));


Fill the table with some junk data

    CREATE PROCEDURE junk_data() BEGIN   DECLARE i INT DEFAULT 100;    WHILE i < 100000 DO     INSERT INTO  user(name) VALUES (concat('name_', i));     SET i = i + 1;   END WHILE; END$$
    DELIMITER ;
    call junk_data();


Try to query with some way:



>mysql> select * from user where name='name_10002';
>+------+------------+---------------------+
>| id   | name       | created             |
>+------+------------+---------------------+
>| 9903 | name_10002 | 2018-05-23 23:21:47 |
>+------+------------+---------------------+
>1 row in set (0.04 sec)

A little complex query :


>mysql> select * from user where name in ('name_1001', 'name_20001');
>+-------+------------+---------------------+
>| id    | name       | created             |
>+-------+------------+---------------------+
>|   902 | name_1001  | 2018-05-23 23:21:45 |
>| 19902 | name_20001 | 2018-05-23 23:21:49 |
>+-------+------------+---------------------+
>2 rows in set (0.07 sec)

try to explain what is going on with this query:

>mysql> explain select * from user where name in ('name_1001', 'name_20001');
>+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
>| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra       |
>+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
>|  1 | SIMPLE      | user  | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 97455 |    20.00 | Using where |
>+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
>1 row in set, 1 warning (0.01 sec)


Like query
==============
To test if use like query is also good at this kind of table without index


mysql> select * from user where name like '%1000%';
+-------+------------+---------------------+
| id    | name       | created             |
+-------+------------+---------------------+
|   901 | name_1000  | 2018-05-23 23:21:45 |
|  9901 | name_10000 | 2018-05-23 23:21:47 |
|  9902 | name_10001 | 2018-05-23 23:21:47 |
|  9903 | name_10002 | 2018-05-23 23:21:47 |
|  9904 | name_10003 | 2018-05-23 23:21:47 |
|  9905 | name_10004 | 2018-05-23 23:21:47 |
|  9906 | name_10005 | 2018-05-23 23:21:47 |
|  9907 | name_10006 | 2018-05-23 23:21:47 |
|  9908 | name_10007 | 2018-05-23 23:21:47 |
|  9909 | name_10008 | 2018-05-23 23:21:47 |
|  9910 | name_10009 | 2018-05-23 23:21:47 |
| 10901 | name_11000 | 2018-05-23 23:21:47 |
| 20901 | name_21000 | 2018-05-23 23:21:50 |
| 30901 | name_31000 | 2018-05-23 23:21:52 |
| 40901 | name_41000 | 2018-05-23 23:21:54 |
| 50901 | name_51000 | 2018-05-23 23:21:56 |
| 60901 | name_61000 | 2018-05-23 23:21:58 |
| 70901 | name_71000 | 2018-05-23 23:22:00 |
| 80901 | name_81000 | 2018-05-23 23:22:02 |
| 90901 | name_91000 | 2018-05-23 23:22:04 |
+-------+------------+---------------------+
20 rows in set (0.05 sec)

mysql> explain select * from user where name like '%1000%';
+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows  | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
|  1 | SIMPLE      | user  | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 97455 |    11.11 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+-------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


CREATE INDEX name_index ON user(name);

After create a index, and we can do query again..


mysql> explain select * from user where name='name_10001'
    -> ;
+----+-------------+-------+------------+------+---------------+------------+---------+-------+------+----------+-------+
| id | select_type | table | partitions | type | possible_keys | key        | key_len | ref   | rows | filtered | Extra |
+----+-------------+-------+------------+------+---------------+------------+---------+-------+------+----------+-------+
|  1 | SIMPLE      | user  | NULL       | ref  | name_index    | name_index | 51      | const |    1 |   100.00 | NULL  |
+----+-------------+-------+------------+------+---------------+------------+---------+-------+------+----------+-------+
1 row in set, 1 warning (0.01 sec)
