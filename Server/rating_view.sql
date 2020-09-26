create or replace view rating_view(Guard_Name, Client_Name, Rating, Branch) as 
	select G.g_name, C.c_name, R.rating ,G.g_branch
	from ((clients C INNER JOIN guard_rating R
	ON C.cid = R.cid) INNER JOIN guards G ON G.gid = R.gid);