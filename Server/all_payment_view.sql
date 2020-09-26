create or replace view all_payment_view as 
	select * from payment
	UNION
	select * from payment@site_link;