CREATE
	VIEW ReceiptClient(
		cid,
		rid
	) AS SELECT
		c.cid,
		r.rid
	FROM
		clients c,
		receipts r,
		prescriptions p
	WHERE
		r.pid = p.pid
		AND p.cid = c.cid;

SELECT * FROM ReceiptClient;