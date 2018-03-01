/* Question 5 */

/*  */
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

--IN( SELECT I.cid
--FROM individuals I
--WHERE I.gender = 'Female' )

