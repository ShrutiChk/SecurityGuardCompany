create or replace view all_clients_view as 
	select * from clients
	UNION
	select * from clients@site_link;