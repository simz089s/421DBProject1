/**
 * Trigger that checks upon update of specialization in healthpractitioner that this does not conflict
 * with the Pharmacist entity whose practitioners must be the only ones to be 
 * able to prescribe drugs
 */

CREATE OR REPLACE FUNCTION pharm_except() RETURNS trigger AS $$
    BEGIN
        IF NOT NEW.specialization = 'Pharmacist' AND EXISTS(SELECT FROM pharmacists p WHERE NEW.did = p.did)
            THEN RAISE EXCEPTION 'The specialization cannot be changed due to constraints on the pharmacists table';
        END IF;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;

DROP TRIGGER emp_audit ON healthpractitioners;

CREATE TRIGGER emp_audit
AFTER UPDATE ON healthpractitioners
	FOR EACH ROW 
	WHEN (OLD.specialization IS DISTINCT FROM NEW.specialization) 
  	EXECUTE PROCEDURE pharm_except();
   
