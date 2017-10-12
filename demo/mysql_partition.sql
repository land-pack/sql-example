
# Create a partition table for test (partition by range)
CREATE TABLE part_tab ( c1 int default NULL, c2 varchar(30) default NULL, c3 date default NULL) engine=myisam 
PARTITION BY RANGE (year(c3)) (PARTITION p0 VALUES LESS THAN (1995),
PARTITION p1 VALUES LESS THAN (1996) , PARTITION p2 VALUES LESS THAN (1997) ,
PARTITION p3 VALUES LESS THAN (1998) , PARTITION p4 VALUES LESS THAN (1999) ,
PARTITION p5 VALUES LESS THAN (2000) , PARTITION p6 VALUES LESS THAN (2001) ,
PARTITION p7 VALUES LESS THAN (2002) , PARTITION p8 VALUES LESS THAN (2003) ,
PARTITION p9 VALUES LESS THAN (2004) , PARTITION p10 VALUES LESS THAN (2010),
PARTITION p11 VALUES LESS THAN MAXVALUE ); 


# No partion table
create table no_part_tab (c1 int(11) default NULL,c2 varchar(30) default NULL,c3 date default NULL) engine=myisam;

# insert 800w data for test

delimiter //
CREATE PROCEDURE load_part_tab()
       begin
    declare v int default 0;
    while v < 8000000
    do
        insert into part_tab
        values (v,'testing partitions',adddate('1995-01-01',(rand(v)*36520) mod 3652));
         set v = v + 1;
    end while;
    end
    //
delimiter ;
call load_part_tab();

# load data to no partition table
insert into no_part_tab select * from part_tab; 


# query test ( no_part_tab)
 select count(*) from no_part_tab where c3 > date '1995-01-01' and c3 < date '1995-12-31'; 


# query test ( part_tab)
 select count(*) from part_tab where c3 > date '1995-01-01' and c3 < date '1995-12-31'; 



# =================for act production
CREATE TABLE `t_gold_log_partition` (
  `f_tid` bigint(20) NOT NULL AUTO_INCREMENT ,
  `f_oid` bigint(20) NOT NULL DEFAULT '0' ,
  `f_uid` bigint(20) NOT NULL ,
  `f_inout` bigint(20) NOT NULL,
  `f_golds` bigint(20) DEFAULT '0' ,
  `f_total` bigint(20) DEFAULT NULL ,
  `f_crtime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `f_remark` varchar(1024) NOT NULL DEFAULT '' ,
  PRIMARY KEY (`f_tid`, `f_crtime`)
)engine=myisam
PARTITION BY RANGE (UNIX_TIMESTAMP(f_crtime)) (PARTITION p0 VALUES LESS THAN (UNIX_TIMESTAMP("2016-06-01 00:00:00")),
PARTITION p1 VALUES LESS THAN (UNIX_TIMESTAMP("2016-07-01 00:00:00")) , PARTITION p2 VALUES LESS THAN (UNIX_TIMESTAMP("2016-08-01 00:00:00")) ,
PARTITION p3 VALUES LESS THAN (UNIX_TIMESTAMP("2016-09-01 00:00:00")) , PARTITION p4 VALUES LESS THAN (UNIX_TIMESTAMP("2016-10-01 00:00:00")) ,
PARTITION p5 VALUES LESS THAN (UNIX_TIMESTAMP("2016-11-01 00:00:00")) , PARTITION p6 VALUES LESS THAN (UNIX_TIMESTAMP("2016-12-01 00:00:00")) ,

PARTITION p7 VALUES LESS THAN (UNIX_TIMESTAMP("2017-01-01 00:00:00")) , PARTITION p8 VALUES LESS THAN (UNIX_TIMESTAMP("2017-02-01 00:00:00")) ,
PARTITION p9 VALUES LESS THAN (UNIX_TIMESTAMP("2017-03-01 00:00:00")) , PARTITION p10 VALUES LESS THAN (UNIX_TIMESTAMP("2017-04-01 00:00:00")),
PARTITION p11 VALUES LESS THAN (UNIX_TIMESTAMP("2017-05-01 00:00:00")) , PARTITION p12 VALUES LESS THAN (UNIX_TIMESTAMP("2017-06-01 00:00:00")),
PARTITION p13 VALUES LESS THAN (UNIX_TIMESTAMP("2017-07-01 00:00:00")) , PARTITION p14 VALUES LESS THAN (UNIX_TIMESTAMP("2017-08-01 00:00:00")),
PARTITION p15 VALUES LESS THAN (UNIX_TIMESTAMP("2017-09-01 00:00:00")) , PARTITION p16 VALUES LESS THAN (UNIX_TIMESTAMP("2017-10-01 00:00:00")),
PARTITION p17 VALUES LESS THAN (UNIX_TIMESTAMP("2017-11-01 00:00:00")) , PARTITION p18 VALUES LESS THAN (UNIX_TIMESTAMP("2017-12-01 00:00:00")),
PARTITION p20 VALUES LESS THAN MAXVALUE );