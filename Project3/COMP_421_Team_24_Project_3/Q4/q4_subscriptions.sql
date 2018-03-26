/*
 * Query to extract number of new subscriptions per month
 * in the year 2018, sorted by month. First part of the query
 * gets months which have new subscriptions and second part
 * gets the month numbers which have 0 new subscriptions.
 * (Also, casting the month to int)
 */
SELECT CAST(EXTRACT(MONTH FROM startdate) AS int) AS MONTH, count(subid) AS num_new_subscriptions
FROM subscriptions S
WHERE
	EXTRACT(YEAR FROM startdate) = 2018
GROUP BY EXTRACT(MONTH FROM startdate)

UNION

SELECT column1 AS MONTH, 0 AS num_new_subscriptions
FROM (VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10), (11), (12)) months
EXCEPT
(
	SELECT CAST(EXTRACT(MONTH FROM startdate) AS int), 0 AS num_new_subscriptions
	FROM subscriptions S
	WHERE
		EXTRACT(YEAR FROM startdate) = 2018
	GROUP BY EXTRACT(MONTH FROM startdate)
)

ORDER BY MONTH
;
