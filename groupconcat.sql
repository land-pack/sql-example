# groupconcat(filed_name)


-- +------+-------+
-- | uid  | logid |
-- +------+-------+
-- |  101 |     1 |
-- |  101 |     5 |
-- |  101 |     9 |
-- |  102 |     2 |
-- |  101 |     3 |
-- |  101 |     4 |
-- |  102 |     6 |
-- |  102 |     7 |
-- |  102 |     8 |
-- +------+-------+

select GROUP_CONCAT(logid) as logid from login_log where uid=101;


 select uid, group_concat(logid) from login_log group by uid;
# Group_concat by uid
-- +------+---------------------+
-- | uid  | group_concat(logid) |
-- +------+---------------------+
-- |  101 | 1,5,9,3,4           |
-- |  102 | 2,6,7,8             |
-- +------+---------------------+