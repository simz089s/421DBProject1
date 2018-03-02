/* Question 5 */

/*Get all the clients whose subscriptions are out of date */
SELECT cid
FROM clients
EXCEPT SELECT cid
FROM subscriptions S
WHERE S.enddate > '2018-01-01'
LIMIT 50;

/* See how many of each drug each female individual was prescribed */
SELECT Distinct D.duid, count(*)
FROM prescriptions P, individuals I, prescriptioncontents Pc, drugs D
WHERE P.cid = I.cid AND I.gender = 'Female' AND Pc.pid = P.pid
GROUP BY D.duid
ORDER BY D.duid
LIMIT 50;


/*Shows the average money spent by both sexes on our insurance plans*/
SELECT I.gender,AVG(R.totalprice::NUMERIC) 
FROM receipts R, prescriptions P, individuals I 
WHERE R.pid = P.Pid AND P.cid = I.cid 
GROUP BY I.gender;


/*Shows the average money spent on plans by clients based on gender*/
SELECT I.gender,AVG(P.price::NUMERIC) 
FROM subscriptions S, individuals I, insuranceplans P
WHERE S.planid = P.planid AND I.cid = S.cid
GROUP BY I.gender;


/* Get adult individuals who have been reimbursed more than 20$ */
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
			age(current_date, I.birthdate) >= '18 years'
	)
GROUP BY
	I.cid
HAVING
	SUM( Re.amount::NUMERIC )> 20
LIMIT 50;


