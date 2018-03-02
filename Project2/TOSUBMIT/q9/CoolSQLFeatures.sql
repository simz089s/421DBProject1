/*
 * Allows us to compare the average amount that each gender
 * spent on drugs vs what each individuals actually spent
 */
SELECT
	Rv.cid,
	I.gender,
	AVG( R.totalprice::NUMERIC ) OVER(
		PARTITION BY I.gender
	)
FROM
	receiptclientview Rv,
	individuals I,
	receipts R
WHERE
	I.cid = Rv.cid
	AND Rv.rid = R.rid;

/*
cid |gender |avg                  |
----|-------|---------------------|
66  |Male   |378.0200000000000000 |
51  |Male   |378.0200000000000000 |
93  |Female |197.9150000000000000 |
93  |Female |197.9150000000000000 |
*/

/*
 * See how much each age group based on year pays on average vs how much they actually pay
 * 
 */
SELECT
	I.cid,
	Ig.price,
	EXTRACT(
		YEAR
	FROM
		age(
			CURRENT_DATE,
			I.birthdate
		)
	),
	AVG( Ig.price::NUMERIC ) OVER(
		PARTITION BY EXTRACT(
			YEAR
		FROM
			age(
				CURRENT_DATE,
				I.birthdate
			)
		)
	)
FROM
	individuals I,
	subscriptions C,
	insuranceplans Ig
WHERE
	I.cid = C.cid
	AND C.planid = Ig.planid;
/*
cid |price     |date_part |avg                   |
----|----------|----------|----------------------|
93  |$644.38   |46        |644.3800000000000000  |
66  |$1,001.92 |47        |1001.9200000000000000 |
52  |$202.00   |51        |202.0000000000000000  |
56  |$202.00   |51        |202.0000000000000000  |
85  |$202.00   |53        |202.0000000000000000  |
57  |$202.00   |53        |202.0000000000000000  |
62  |$202.00   |55        |202.0000000000000000  |
87  |$202.00   |55        |202.0000000000000000  |
84  |$202.00   |57        |202.0000000000000000  |
64  |$202.00   |57        |202.0000000000000000  |
89  |$202.00   |57        |202.0000000000000000  |
60  |$202.00   |58        |202.0000000000000000  |
65  |$202.00   |58        |202.0000000000000000  |
53  |$202.00   |59        |412.7533333333333333  |
51  |$202.00   |59        |412.7533333333333333  |
51  |$834.26   |59        |412.7533333333333333  |
69  |$202.00   |63        |202.0000000000000000  |
83  |$202.00   |63        |202.0000000000000000  |
92  |$202.00   |63        |202.0000000000000000  |
100 |$215.13   |64        |206.3766666666666667  |
100 |$202.00   |64        |206.3766666666666667  |
78  |$202.00   |64        |206.3766666666666667  |
59  |$202.00   |65        |202.0000000000000000  |
95  |$202.00   |65        |202.0000000000000000  |
73  |$202.00   |66        |202.0000000000000000  |
68  |$202.00   |66        |202.0000000000000000  |
80  |$202.00   |67        |202.0000000000000000  |
*/