set verify off;
SET SERVEROUTPUT ON;

DECLARE

BEGIN
	
	DBMS_OUTPUT.PUT_LINE('Guards with ratings less than 3: ');
	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Guard_Name	||' || 'Client_Name	||' || 'Rating	||' || 'Branch	||');
	DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------------');
	for r in (select Guard_Name, Client_Name, Rating, Branch from myview where Rating < 4)loop
		DBMS_OUTPUT.PUT_LINE(r.Guard_Name||'		' ||r.Client_Name||'		'||r.Rating||'		'||r.Branch);
	
	end loop;
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Showing all Clients: ');
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Client_Name		||' || 'Client_Address		||' || 'Mail			||' || 'Status	||'|| 'Branch	||');
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	for i in (select * from all_clients_view)loop
		DBMS_OUTPUT.PUT_LINE(i.c_name||'			' ||i.c_address||'		'||i.c_mail||'		'||i.c_status||'		'||i.c_branch);
	end loop;
	
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Showing all payments: ');
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Client_ID ||' || 'Guard_ID ||' || 'Amount		||' || 'Status	||'|| 'Date		||');
	DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------------------------');
	for j in (select * from all_payment_view)loop
		DBMS_OUTPUT.PUT_LINE(j.cid||' 		 '||j.gid||' 	'||j.payment_amount||'		'||j.payment_status||'		'||j.payment_date);
	end loop;
	
END;
/

