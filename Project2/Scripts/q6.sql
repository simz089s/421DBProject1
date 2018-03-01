/* Question 6 */

/*Made every senior subscribe as a trial to the senior healthplan*/
INSERT INTO subscriptions
SELECT DISTINCT I.cid,110,'2018-02-28'::Date,'2018-03-29'::Date FROM individuals I WHERE age(current_date, I.birthdate) >= '50 years';

