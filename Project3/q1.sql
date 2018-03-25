/**
 * Function that reimburses all clients that have not yet been reimbursed
 * provided that each reimbursement made does not exceed maxval,
 * that the receipt date and claim date are older than rda and ida,
 * and finally that they were holding at least 1 valid subsriptions at that time.
 * 
 * Returns the total amount of money reimbursed.
 */

CREATE OR REPLACE FUNCTION reimburse(maxval MONEY, rda DATE, ida DATE) RETURNS MONEY AS $$
DECLARE	
	-- Get the table containing all valid reimbursements except the re_amount
	claim_cur CURSOR FOR SELECT I.icid,Re.totalprice,P.cid,Re."date" FROM insuranceclaims I, receipts Re
	INNER JOIN prescriptions P ON Re.pid=P.pid WHERE NOT EXISTS(SELECT FROM reimbursed R WHERE R.icid = I.icid)
	AND I."date" < ida::date AND I.rid = Re.rid AND Re."date" < rda::date;
	icid INT;
	rec_amount MONEY;
	client INT;
	rdate DATE;
	counter MONEY DEFAULT '$0';
BEGIN
	OPEN claim_cur;
	LOOP
		FETCH claim_cur INTO icid,rec_amount,client,rdate;
		-- Check if the subscription was valid at the time of the receipt
		-- and if the amount does not exceed the amount entered
		IF(rec_amount<maxval AND EXISTS(SELECT FROM subscriptions S WHERE S.enddate > rdate AND S.cid = client))
			THEN
				-- Uses limit here as we are only interested to know if there exist at least one valid output
				INSERT INTO reimbursed VALUES ((SELECT S.subid FROM subscriptions S WHERE S.enddate > rdate AND S.cid = client LIMIT 1)
				,icid,rec_amount,CURRENT_Date);
				counter = counter+rec_amount;
		END IF;
		EXIT WHEN NOT FOUND;
	END LOOP;
	CLOSE claim_cur;
	RETURN counter;
END;
$$ LANGUAGE plpgsql;

SELECT reimburse('$100','3000-02-03','3000-02-03');

