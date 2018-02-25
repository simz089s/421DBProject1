INSERT
	INTO
		clients
	VALUES(
		2,
		'j.dupond@mail.com',
		'4389352104',
		'apt 5 rue des fleurs H16 2l8 Montreal',
		'100-030-121213'
	);

INSERT
	INTO
		clients
	VALUES(
		0,
		'name@domain.io',
		'(420) 3601111',
		'123 My House',
		'9999999999'
	);

SELECT
	*
FROM
	clients
ORDER BY
	cid;

INSERT
	INTO
		subscriptions
	VALUES(
		1,
		0,
		1,
		'2010-01-20',
		'2015-01-19'
	);
