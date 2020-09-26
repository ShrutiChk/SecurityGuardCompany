set verify off;
set serveroutput on;
create or replace package body myPackage as

		
	procedure availableGuards(show_f in NUMBER,age in guards.g_age%type,gender in guards.g_gender%type,
												height in guards.g_height%type,spc in guards.g_speciality%type)
	is

	found_f number := 0;
	j number := 1;
	begin
			
		if(show_f = 0) then
			for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating from guards 
						where (g_age >= age) AND (lower(g_gender) = lower(gender)) AND (g_height >= height) 
						AND (lower(g_speciality) = lower(spc)) AND (g_status = 'Free'))loop
				DBMS_OUTPUT.PUT_LINE('Guard  '|| j );
				j := j+1;
				
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
									' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
									' , Experience: '||i.g_experience||' , Rating: '||i.g_rating);
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				found_f := 1;
			end loop;
		elsif(show_f = 1) then
			for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating from guards 
						where (lower(g_gender) = lower(gender)) AND (g_height >= height) 
						AND (lower(g_speciality) = lower(spc)) AND (g_status = 'Free'))loop
				DBMS_OUTPUT.PUT_LINE('Guard  '|| j );
				j := j+1;
				
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
									' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
									' , Experience: '||i.g_experience||' , Rating: '||i.g_rating);
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				found_f := 1;
			end loop;
		elsif(show_f = 2) then
			for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating from guards 
						where (g_height >= height) AND (lower(g_speciality) = lower(spc)) 
						AND (g_status = 'Free'))loop
				DBMS_OUTPUT.PUT_LINE('Guard  '|| j );
				j := j+1;
				
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
									' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
									' , Experience: '||i.g_experience||' , Rating: '||i.g_rating);
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				found_f := 1;
			end loop;
		elsif(show_f = 3) then
			for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating from guards 
						where (lower(g_speciality) = lower(spc)) AND (g_status = 'Free'))loop
				DBMS_OUTPUT.PUT_LINE('Guard  '|| j );
				j := j+1;

				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
									' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
									' , Experience: '||i.g_experience||' , Rating: '||i.g_rating);
				DBMS_OUTPUT.PUT_LINE('------------------------------------------');
				found_f := 1;
			end loop;
		end if;
		
		if(found_f = 0 OR show_f = 4) then
			DBMS_OUTPUT.PUT_LINE('Sorry No guards are found according to your choice');
			DBMS_OUTPUT.PUT_LINE('Showing available guards: ');
			myPackage.procShow;
			
			
		end if;

	end availableGuards;
	
	procedure makePayment(g_no in NUMBER , c_no in NUMBER)
	is

	sal guards.g_sal%type;
	begin
			
		select g_sal into sal from guards where gid = g_no;
		insert into payment values(c_no,g_no,sal+500,'Clear','19 September 2020'); 
		update guards set g_status = 'Busy' where gid = g_no;
		DBMS_OUTPUT.PUT_LINE('Booking Done');
		
		exception
		 when no_data_found then
			DBMS_OUTPUT.PUT_LINE('No data found');

	end makePayment;
	
	
	procedure paymentMonthlyInfoTable
	is

	m_total number := 0;
	rowno number := 0;	
	BEGIN
		
		execute immediate 'truncate table Payment_monthly_info';
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%January%2020' 
					AND cid IN(select cid from clients );
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(1,'January',m_total);
		
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%February%2020'
					AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(2,'February',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%March%2020' 
					AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(3,'March',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%April%2020'
					AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(4,'April',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%May%2020'
						AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(5,'May',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%June%2020'
					AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(6,'June',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%July%2020' 
						AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(7,'July',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%August%2020'
						AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(8,'August',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%Septem%2020'
							AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(9,'September',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%Octo%2020'
								AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(10,'October',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%Novem%2020'
							AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(11,'November',m_total);
		
		m_total := 0;
		rowno := 0;
		select SUM(payment_amount),count(*) into m_total ,rowno from payment where payment_date LIKE '%Decem%2020'
								AND cid IN(select cid from clients);
		if(rowno = 0)then
			m_total :=0;
		end if;
		insert into Payment_monthly_info values(12,'December',m_total);
		commit;
		
	END paymentMonthlyInfoTable;
		
	
	procedure procShow
	is
	
	j number := 1;
	begin
		
		for i in (select g_name,g_age,g_gender,g_height,g_sal, g_experience,g_rating,g_speciality from guards 
					where g_status = 'Free')loop
			DBMS_OUTPUT.PUT_LINE('Guard  '|| j );
			j := j+1;
			
			DBMS_OUTPUT.PUT_LINE('------------------------------------------');
			DBMS_OUTPUT.PUT_LINE('Guard name: '||i.g_name||' , Age:'||i.g_age||
								' , Gender: '||i.g_gender||' , Height: '||i.g_height||' , Salary: '||i.g_sal||
								' , Experience: '||i.g_experience||' , Rating: '||i.g_rating||' , Speciality: '||i.g_speciality);
			DBMS_OUTPUT.PUT_LINE('------------------------------------------');
			
		end loop;

	end procShow;


end myPackage;
/