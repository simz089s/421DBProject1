/*
 * Query to find the top 10 biggest spender for the year 2001
 * By calculating how much they paid in their plans total in the year divided 
 * by the number of plans they have for the entire year.
 */
SELECT
	s.cid,
	sum(p.price*(extract(month from s.enddate)-extract(month from s.startdate)))/count(*) AS totalspending
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
