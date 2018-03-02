SELECT DISTINCT Rv.cid,AVG(R.totalprice::NUMERIC) OVER (PARTITION BY I.cid)
FROM receiptclientview Rv, individuals I,receipts R WHERE 
I.cid = Rv.cid AND age(current_date,I.birthdate)>'50 years'; 