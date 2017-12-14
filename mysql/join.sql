#Create demo table 1
create table user (uid integer, name varchar(32));
#Create demo table 2
create table account (uid integer, money decimal(10, 2));

# Insert some demo data
insert into user (uid, name)VALUES(101, 'Frank');
insert into user (uid, name)VALUES(102, 'Jack');
insert into user (uid, name)VALUES(103, 'Landpack');
insert into user (uid, name)VALUES(104, 'Hokey');

-- +------+----------+
-- | uid  | name     |
-- +------+----------+
-- |  101 | Frank    |
-- |  102 | Jack     |
-- |  103 | Landpack |
-- |  104 | Hokey    |
-- +------+----------+

-- +------+---------+
-- | uid  | money   |
-- +------+---------+
-- |  103 | 1000.00 |
-- |  102 | 1890.00 |
-- |  101 | 2230.00 |
-- |  104 |  430.00 |
-- +------+---------+

#use inner join
 select u.uid, u.name, a.money FROM user u INNER JOIN account a ON u.uid=a.uid;

--  mysql> select u.uid, u.name, a.money
--     -> FROM user u
--     -> INNER JOIN
--     -> account a
--     -> ON u.uid=a.uid;
-- +------+----------+---------+
-- | uid  | name     | money   |
-- +------+----------+---------+
-- |  103 | Landpack | 1000.00 |
-- |  102 | Jack     | 1890.00 |
-- |  101 | Frank    | 2230.00 |
-- |  104 | Hokey    |  430.00 |
-- +------+----------+---------+


# if you want to do some filter
 select u.uid, u.name, a.money FROM user u 
 INNER JOIN account a ON u.uid=a.uid WHERE a.money > 1000;

-- +------+-------+---------+
-- | uid  | name  | money   |
-- +------+-------+---------+
-- |  101 | Frank | 2230.00 |
-- |  102 | Jack  | 1890.00 |
-- +------+-------+---------+

# add a record to user
insert into user (uid, name)VALUES(105, 'iq');
-- +------+----------+
-- | uid  | name     |
-- +------+----------+
-- |  101 | Frank    |
-- |  102 | Jack     |
-- |  103 | Landpack |
-- |  104 | Hokey    |
-- |  105 | iq       |
-- +------+----------+

# LEFT JOIN DEMO
select u.uid, u.name, a.money FROM user u LEFT JOIN account a ON u.uid=a.uid;

-- +------+----------+---------+
-- | uid  | name     | money   |
-- +------+----------+---------+
-- |  103 | Landpack | 1000.00 |
-- |  102 | Jack     | 1890.00 |
-- |  101 | Frank    | 2230.00 |
-- |  104 | Hokey    |  430.00 |
-- |  105 | iq       |    NULL |
-- +------+----------+---------+


#merge to select result
SELECT tu.f_username, ga.f_total
FROM t_user tu
INNER JOIN
t_gold_account ga
ON ga.f_uid=tu.f_uid
WHERE f_level > 0;


# use join to merge multi data to one table
SELECT a.f_uid, a.f_username, a.f_regtime,b.first_time,b.first_money
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
ON a.f_uid = b.f_uid;

