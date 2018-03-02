/* Question 6 */
/* Make every individual who's older than 50
 * subscribe as a trial for a month to the senior healthplan (110) in case
 * they did not yet subscribe to it */
INSERT
	INTO
		subscriptions SELECT
			DISTINCT I.cid,
			110,
			'2018-02-28'::DATE,
			'2018-03-29'::DATE
		FROM
			individuals I
		WHERE
			age(
				CURRENT_DATE,
				I.birthdate
			)>= '50 years'
			AND NOT EXISTS(
				SELECT
					*
				FROM
					individuals It,
					subscriptions S
				WHERE
					It.cid = I.cid
					AND S.planid = 110
			);

/* Increase the price of every insurance plans every new year
 * by 1% to account for inflation */
UPDATE
	insuranceplans
SET
	price = price*1.01
WHERE
	EXTRACT(
		MONTH
	FROM
		CURRENT_DATE
	)= 1
	AND EXTRACT(
		DAY
	FROM
		CURRENT_DATE
	)= 1;

/* Delete all the drugs that are neither in any covers nor in prescriptions contents */
DELETE
FROM
	Drugs D
WHERE
	NOT EXISTS(
		SELECT
			C.duid
		FROM
			covers C,
			prescriptioncontents P
		WHERE
			C.duid = D.duid
			OR P.duid = D.duid
	);

/* Delete any pharmacists not registerd in the pharmacists table or if they have not given any receipts
 * or prescription */
DELETE
FROM
	healthpractitioners H
WHERE
	H.specialization = 'Pharmacist'
	AND NOT EXISTS(
		SELECT
			Ph.did
		FROM
			pharmacists Ph,
			receipts R,
			prescriptions Pr
		WHERE
			Ph.did = R.did
			AND(
				H.did = Ph.did
				OR Pr.did = Ph.did
			)
	);