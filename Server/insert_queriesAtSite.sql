set verify off;
SET SERVEROUTPUT ON;
DECLARE
	match_cnt number :=0;

BEGIN

	for R in (select * from guards where g_branch = 'Chittagong')loop
		select count(*) into match_cnt from guards@site_link where gid = R.gid;
		if(match_cnt = 0) then
			insert into guards@site_link values(R.gid,R.g_name,R.g_address,R.g_age,R.g_gender,R.g_height,R.g_sal,R.g_branch,R.g_experience,
			R.g_rating,R.g_status,R.g_speciality);
			commit;
		end if;

	end loop ;
	
	match_cnt :=0;
	for R in (select * from clients where c_branch = 'Chittagong')loop
		select count(*) into match_cnt from clients@site_link where cid = R.cid;
		if(match_cnt = 0) then
			insert into clients@site_link values(R.cid,R.c_name,R.c_address,R.c_mail,R.c_status,R.c_branch);
			commit;
		end if;
	end loop ;
	
	match_cnt :=0;
	for R in (select * from manager where branch = 'Chittagong')loop
		select count(*) into match_cnt from manager@site_link where m_id = R.m_id;
		if(match_cnt = 0) then
			insert into manager@site_link values(R.m_id,R.position,R.m_name,R.branch);
			commit;
		end if;
	end loop ;
	
	match_cnt :=0;
	for R in (select * from payment where cid IN(select cid from clients where c_branch = 'Chittagong'))loop
		select count(*) into match_cnt from payment@site_link where cid = R.cid;
		if(match_cnt = 0) then
			insert into payment@site_link values(R.cid,R.gid,R.payment_amount,R.payment_status,R.payment_date);
			commit;
		end if;
	end loop ;
	
	match_cnt :=0;
	for R in (select * from complaint where cid IN(select cid from clients where c_branch = 'Chittagong'))loop
		select count(*) into match_cnt from complaint@site_link where cid = R.cid;
		if(match_cnt = 0) then
			insert into complaint@site_link values(R.cid,R.gid,R.com_info);
			commit;
		end if;
	end loop ;
	
	match_cnt :=0;
	for R in (select * from guard_rating where cid IN(select cid from clients where c_branch = 'Chittagong'))loop
		select count(*) into match_cnt from guard_rating@site_link where cid = R.cid;
		if(match_cnt = 0) then
			insert into guard_rating@site_link values(R.cid,R.gid,R.rating);
			commit;
		end if;
	end loop ;
	
	match_cnt :=0;
	for R in (select * from service where cid IN(select cid from clients where c_branch = 'Chittagong'))loop
		select count(*) into match_cnt from service@site_link where cid = R.cid;
		if(match_cnt = 0) then
			insert into service@site_link values(R.cid,R.gid,R.start_date,R.end_date);
			commit;
		end if;
	end loop ;
	

	

END;
/