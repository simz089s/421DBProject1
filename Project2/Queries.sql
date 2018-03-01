/* Question 5 */

/*Get all the clients whose subscriptions are out of date */
SELECT cid
FROM clients
EXCEPT SELECT cid
FROM subscriptions S
WHERE S.enddate > '2018-01-01';

/* Project pid, cid, and name of female clients who have prescriptions, ordered by pid */
SELECT pid, I.cid, fname, lname
FROM prescriptions P, individuals I
WHERE P.cid = I.cid AND gender = 'Female'
--GROUP BY gender
ORDER BY pid;

/*Shows the amount of money spent by both sexes*/
SELECT I.gender,AVG(R.totalprice::NUMERIC) 
FROM receipts R, prescriptions P, individuals I 
WHERE R.pid = P.Pid AND P.cid = I.cid 
GROUP BY I.gender;

/*Shows the average money spent on plans by clients based on gender*/
SELECT I.gender,AVG(P.price::NUMERIC) 
FROM subscriptions S, individuals I, insuranceplans P
WHERE S.planid = P.planid AND I.cid = S.cid
GROUP BY I.gender;

/* Get individuals who have a birthdate in the 20th century and have been rembursed more than 20$ */
SELECT
	DISTINCT(I.birthdate),
	I.cid,
	SUM( Re.amount::NUMERIC )
FROM
	insuranceclaims IC,
	receipts R,
	individuals I,
	reimbursed Re,
	prescriptions P
WHERE
	IC.rid = R.rid
	AND Re.icid = IC.icid
	AND IC.rid = R.rid
	AND R.pid = P.pid
	AND P.cid = I.cid
	AND I.cid IN(
		SELECT
			cid
		FROM
			individuals
		WHERE
			I.birthdate < '2000-01-01'
	)
GROUP BY
	I.cid
HAVING
	SUM( Re.amount::NUMERIC )> 20;

