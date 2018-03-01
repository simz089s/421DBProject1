/* Alter table again for Q8 */
ALTER TABLE
	individuals ADD /*CONSTRAINT individuals_cid_check*/ CHECK(
		cid > 0
	);

INSERT
	INTO
		individuals
	VALUES(
		0,
		'a',
		'b',
		'2000-01-01',
		'Other'
	);

/*-------------------------------------------------------------------*/
ALTER TABLE
	companies ADD /*CONSTRAINT companies_cid_check*/
	CHECK(
		companies.numemploy > 0
	);

INSERT
	INTO
		companies
	VALUES(
		51,
		'Inc. Co.',
		-1
	);

