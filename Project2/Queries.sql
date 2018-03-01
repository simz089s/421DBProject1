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
ORDER BY pid;

/*Shows the amount of money spent by both sexes*/
SELECT I.gender,AVG(R.totalprice::NUMERIC) 
FROM receipts R, prescriptions P, individuals I 
WHERE R.pid = P.Pid AND P.cid = I.cid 
GROUP BY I.gender;

/*Shows the average spent on plans by clients based on gender*/
SELECT I.gender,AVG(P.price::NUMERIC) 
FROM subscriptions S, individuals I, insuranceplans P
WHERE S.planid = P.planid AND I.cid = S.cid
GROUP BY I.gender;

SELECT I.birthdate
FROM 	insuranceclaims IC,	receipts R, pharmacists Ph, prescriptions Pr, clients C, individuals I
WHERE IC.rid = R.rid AND Ph.did = R.did
	AND Pr.pid = R.pid AND C.cid = Pr.cid AND C.cid IN(SELECT I.cid FROM individuals WHERE I.birthdate > '1971-01-01')
GROUP BY I.birthdate
ORDER BY I.birthdate;
--IN( SELECT I.cid
--FROM individuals I
--WHERE I.gender = 'Female' )
