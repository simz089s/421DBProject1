/* Shows clients linked to receipts */
CREATE
	VIEW ReceiptClientView(
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

SELECT * FROM ReceiptClientView;

/* Shows reimbursed clients with their client ID, account number, total amount and date reimbursed
 * ordered by date */
CREATE VIEW ReimbursedClientsView(cid, account, amount, date)
AS SELECT C.cid, C.account, SUM(R.amount), R."date"
FROM clients C, reimbursed R
WHERE R.subid
IN(
	SELECT
		S.subid
	FROM
		subscriptions S
	WHERE
		S.cid = C.cid
)
GROUP BY
	C.cid, R."date"
ORDER BY
	R."date";

SELECT * FROM ReimbursedClientsView;

