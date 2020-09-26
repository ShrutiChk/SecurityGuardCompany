set verify off;
SET SERVEROUTPUT ON;

DECLARE
	total_income number := 0;
	total_income2 number := 0;
	max_income number := 0;
	m_income number := 0 ;
	max_month varchar(30);
	grand_total number :=0;
	num NUMBER;
	income_summary number;
	p_id number ;
	m_inc number := 1;
	n number;
	m_name varchar(30);
	
BEGIN
	
	DBMS_OUTPUT.PUT_LINE('Monthly income of year 2020: ');
	myPackage.paymentMonthlyInfoTable;
	
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('No	|| Month_name	|| Amount	');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('');
	for r in (select * from Payment_monthly_info)loop
		DBMS_OUTPUT.PUT_LINE(r.payid||'	|| '||r.Month_name||'		||  '||r.Amount);
	end loop;
	
	
	select sum(amount) into total_income from Payment_monthly_info;

	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Income for year 2020 at Dhaka is : '|| total_income);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	
	for r in (select * from Payment_monthly_info)loop
		m_income := ((r.Amount*100)/total_income);
		if(m_income > max_income)then
			max_income := m_income;
			max_month := r.Month_name;
		end if;
	end loop;
	
	DBMS_OUTPUT.PUT_LINE('Most income percentage at Dhaka is from month : '|| max_month ||' is: '|| max_income);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	
	select sum(amount) into total_income2 from Payment_monthly_info@site_link;
	--DBMS_OUTPUT.PUT_LINE('Total Income for ctg is : '|| total_income2);
	
	if(total_income2 > total_income) then
		DBMS_OUTPUT.PUT_LINE('Chittagong branch has more income than Dhaka branch');
	else
		DBMS_OUTPUT.PUT_LINE('Dhaka branch has more income than Chittagong branch');
	end if;
	
	grand_total := total_income + total_income2;
	
	income_summary := myPackage.profitOrLoss(grand_total,num);
	
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Total Income for year 2020 is : '|| grand_total);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	if(num = 1) then
		DBMS_OUTPUT.PUT_LINE('Company is getting profit of taka: '||income_summary);
	else
		DBMS_OUTPUT.PUT_LINE('Company is getting loss of taka: '||income_summary);
	end if;
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	p_id := 1;
	for i in (select * from Payment_monthly_info)loop
		select Month_name,payid into m_name,p_id from Payment_monthly_info where payid = p_id;
		m_inc := myPackage.monthly_profitOrLoss(p_id,n);
		if(n = 1) then
			DBMS_OUTPUT.PUT_LINE('(+) Month: '||i.Month_name||' is getting profit of taka : '||m_inc);
		else
			DBMS_OUTPUT.PUT_LINE('(-) Month: '||i.Month_name||' is getting loss of taka : '||m_inc);
		end if;
		p_id := p_id + 1;
		n := 0;
		m_inc := 0;
	end loop;

EXCEPTION
	when zero_divide then
		dbms_output.put_line('Cannot be divided by zero'); 

END;
/
