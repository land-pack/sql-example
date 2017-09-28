
select a.uid, a.score, a.created
from minTable a
INNER JOIN 
(select uid, max(score) as max_score from minTable group by uid)b
ON a.uid=b.uid and a.score=b.max_score;

SELECT c.uid, c.score, min(c.created) as min_created
FROM (
select a.uid, a.score, a.created
from minTable a
INNER JOIN 
(select uid, max(score) as max_score from minTable group by uid)b
ON a.uid=b.uid and a.score=b.max_score)c GROUP BY c.uid, c.score;