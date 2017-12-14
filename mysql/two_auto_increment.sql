# I want to auto increment id

create table money_audit (
 	id int unsigned auto_increment, 
 	uid int unsigned, 
 	money decimal(10,2), 
 	primary key (id), 
 	unique key (uid,  id)
)ENGINE=MyISAM;


create table money_audit (
 	id int unsigned auto_increment,
 	pid int unsigned auto_increment,
 	uid int unsigned, 
 	money decimal(10,2), 
 	primary key (id), 
 	unique key (uid,  pid)
)ENGINE=MyISAM;



+----+---+------+-------+
| id |pid|uid  | money  |
+----+---+------+-------+
|  1 | 1 | 101 | 200.00 |
|  2 | 2 | 101 | 100.00 |
|  3 | 1 | 102 | 300.00 |
|  4 | 3 | 101 | 300.00 |
|  5 | 2 | 102 | 500.00 |
+----+---+-----+--------+