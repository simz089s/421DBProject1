-- Project the name of every table that contains a column named ''
SELECT
	table_name
FROM
	information_schema.columns
WHERE
	column_name = 'address';

-- Project the sorted number of used rows of all the tables in our schema (cs421g24)
-- Can be useful to check which empty tables are left and how many rows each have
SELECT
	schemaname,
	relname,
	n_live_tup
FROM
	pg_stat_user_tables
WHERE
	schemaname = 'cs421g24'
ORDER BY
	n_live_tup,
	relname;

-- Just some normal projection
SELECT
	*
FROM
	healthpractitioners
WHERE
	specialization='Pharmacist'
--ORDER BY
	;

-- Delete table rows
-- Please be careful and passively sanitize (neutralize) these kind of SQL statements when you aren't using them
DELETE
FROM
	
WHERE
	id < 0;

-- Drop single table
-- Once again be careful and neutralize the SQL statement when done...
DROP
	TABLE
		;

-- Table altering (also careful)
ALTER TABLE
	cs421g24.prescriptions ALTER COLUMN did TYPE INT8
		USING did::INT8;

