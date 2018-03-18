/* Function that remburses all clients that have not yet been rembursed
 * Provided that each rembursments made does not exceed maxval
 * and that the receipt (rda) and claim date (ida) where done before a dates
 * Returns the total amount of money rembursed
 */
CREATE OR REPLACE FUNCTION remburse(maxval MONEY, rda DATE, ida DATE) RETURNS MONEY AS $$
DECLARE	
	--Get the table containing for all valid rembursments except the re_amount
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
		--Check if the subscriptions was valid at the time of the reciept
		-- And if the amount does not exceed the amount enterd
		IF(rec_amount<maxval AND EXISTS(SELECT FROM subscriptions S WHERE S.enddate > rdate AND S.cid = client))
			THEN
				--Uses limit to only get one output as subid
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


SELECT remburse('$100','3000-02-03','3000-02-03');