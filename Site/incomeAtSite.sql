set verify off;
SET SERVEROUTPUT ON;

DECLARE
	m_total number := 0;
	rowno number := 0;
	total_income number := 0;
	total_income2 number := 0;
	max_income number := 0;
	m_income number := 0 ;
	max_month varchar(30);
	
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
	DBMS_OUTPUT.PUT_LINE('');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('Income for year 2020 at Chittagong is : '|| total_income);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	
	for r in (select * from Payment_monthly_info)loop
		m_income := ((r.Amount*100)/total_income);
		if(m_income > max_income)then
			max_income := m_income;
			max_month := r.Month_name;
		end if;
	end loop;
	DBMS_OUTPUT.PUT_LINE('Most income percentage at Chittagong is from month : '|| max_month);
	DBMS_OUTPUT.PUT_LINE('------------------------------------------');
	
exception
when zero_divide then
		dbms_output.put_line('Cannot be divided by zero');


END;
/