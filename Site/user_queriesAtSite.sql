set verify off;
SET SERVEROUTPUT ON;

DECLARE
	age guards.g_age%type := '&age';
	gender guards.g_gender%type := '&gender';
	height guards.g_height%type := '&height';
	spc guards.g_speciality%type := '&speciality_MUST';
	needed_date varchar(50) := '&needed_date_dd_mm_yyyy';
	name guards.g_name%type;
	found_f number := 0;
	j number := 1;
	show_f number := 0 ;
BEGIN
	if( age is null) then
		show_f := 1;
		if(gender is null) then
			show_f := 2;
		end if;
		if(height is null) then
			show_f := 3;
		end if;
		if (spc is null) then
			show_f := 4;
		end if;
	end if;
	
	myPackage.availableGuards(show_f,age,gender,height,spc);
	
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Showing guards who will be free before needed date: ');
	for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating from guards 
		where (lower(g_speciality) = lower(spc)) AND g_status = 'Busy' 
		AND gid IN(select gid from service where to_date(end_date) < to_date(needed_date))) loop
		DBMS_OUTPUT.PUT_LINE('------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
								' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
								' , Experience: '||i.g_experience||' , Rating: '||i.g_rating);
			DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	end loop;
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	
	

END;
/
