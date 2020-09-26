create or replace package myPackage as

	procedure availableGuards(show_f in NUMBER,age in guards.g_age%type,gender in guards.g_gender%type,
												height in guards.g_height%type,spc in guards.g_speciality%type);
	
	procedure makePayment(g_no in NUMBER , c_no in NUMBER);
	
	procedure paymentMonthlyInfoTable;
	
	procedure procShow;
	
end myPackage;
/