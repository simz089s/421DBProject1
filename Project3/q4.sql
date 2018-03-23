-- For table 1

/*
 * Query to extract number of new subscriptions per month
 * in the year 2018, sorted by month. Months which have
 * no new subscriptions are not included in the result.
 */
SELECT EXTRACT(MONTH FROM startdate), count(subid)
FROM subscriptions S
WHERE
	EXTRACT(YEAR FROM startdate) = 2018
GROUP BY EXTRACT(MONTH FROM startdate)
ORDER BY EXTRACT(MONTH FROM startdate)
;

