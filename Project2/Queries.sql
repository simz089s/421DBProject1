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

SELECT * FROM clients

/* Question 5 */
SELECT cid FROM clients EXCEPT SELECT cid FROM subscriptions S WHERE S.enddate > '2018-01-01';  
