/*
 * Query to find the total price of each insurance plan
 * by adding up the prices of all the coverages within it
 */

SELECT pname AS plan_name, CAST(SUM(price) AS decimal) AS total_price
FROM insuranceplans
GROUP BY pname
;
