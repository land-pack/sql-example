SELECT s1.f_matchid as matchid, s1.f_matchtime as 比赛时间, s1.vs as 对阵, s2.users as 参与用户, s2.golds as 总投注, s2.prizes as 总中奖, s3.pprizes as 总加奖
FROM 
# 查询赛事信息
(SELECT f_matchid, f_matchtime, concat(f_hometeam, 'VS', f_awayteam) as vs
FROM t_temp
WHERE f_matchid in (
SELECT f_matchid
FROM t_prize_record
WHERE f_crtime BETWEEN "2017-10-01" AND "2017-11-01"
GROUP BY f_matchid
HAVING f_matchid not in (1,0)))s1
inner join 

# 加奖比赛参与用户数
(SELECT f_matchid, count(distinct f_uid) as users, sum(f_golds) as golds, sum(f_prize) as prizes
FROM t_gold_order
WHERE f_orderstatus in (2,4) AND f_matchid in (
SELECT f_matchid
FROM t_prize_record
WHERE f_crtime BETWEEN "2017-10-01" AND "2017-11-01"
GROUP BY f_matchid
HAVING f_matchid not in (1,0))
GROUP BY f_matchid)s2
INNER JOIN 
(SELECT f_matchid, sum(f_award_num) as pprizes
FROM t_prize_record
WHERE f_matchid in (
SELECT f_matchid
FROM t_prize_record
WHERE f_crtime BETWEEN "2017-10-01" AND "2017-11-01"
GROUP BY f_matchid
HAVING f_matchid not in (1,0))
GROUP BY f_matchid)s3
ON s1.f_matchid=s2.f_matchid AND s2.f_matchid=s3.f_matchid;