set verify off;
SET SERVEROUTPUT ON;

DECLARE
	name guards.g_name%type := '&guard_name';
	age guards.g_age%type := '&guard_age';
	client_name clients.c_name%type := '&name';
	email clients.c_mail%type := '&email';
	g_no guards.gid%type;
	c_no clients.cid%type := 14;
	cnt NUMBER:=0;
	sts varchar(20);
	not_available exception;
	
	
BEGIN

	select gid into g_no from guards where g_name = name AND g_age = age AND g_branch = 'Dhaka';
	select g_status into sts from guards where gid = g_no;
	if(sts = 'Busy')then
	 raise not_available;
	end if;
	select count(*) into cnt from clients where c_name = client_name AND c_mail = email AND c_branch = 'Dhaka';
	
	if(cnt > 0)then
		select cid into c_no from clients where c_name = client_name AND c_mail = email AND c_branch = 'Dhaka';
		myPackage.makePayment(g_no,c_no);
	end if;
	if(cnt = 0 )then
		DBMS_OUTPUT.PUT_LINE('New client');
		insert into clients values(c_no,client_name,'Dhaka',email,'Service','Dhaka');
		commit;
		myPackage.makePayment(g_no,c_no);
		c_no := c_no + 1 ;
	end if;
	
	exception
		when no_data_found then
			DBMS_OUTPUT.PUT_LINE('No data found for guard');
		when not_available then
			DBMS_OUTPUT.PUT_LINE('Sorry.This guard is not available now.');
END;
/