/*
 * Query to find the total price of each insurance plan
 * by adding up the prices of all the coverages within it
 */
SELECT
	s.cid,
	sum(p.price*(extract(month from s.enddate)-extract(month from s.startdate))) AS totalspending
FROM
	subscriptions s,
	insuranceplans p
WHERE
	s.planid = p.planid
	AND s.startdate > '2000-12-31'
	AND s.enddate < '2001-12-31'
GROUP BY s.cid
ORDER BY totalspending DESC
LIMIT 10
;