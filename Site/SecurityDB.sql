clear screen;

--delete existing table
drop table guards cascade constraints;
drop table clients cascade constraints;
drop table manager cascade constraints;
drop table payment cascade constraints;
drop table complaint cascade constraints;
drop table guard_rating cascade constraints;
drop table service cascade constraints;

--Create tables of database
create table guards(
 gid     integer, 
 g_name   varchar2(30), 
 g_address varchar2(30),
 g_age  integer,
 g_gender varchar2(30),
 g_height number,
 g_sal number,
 g_branch varchar2(30),
 g_experience number,
 g_rating number,
 g_status varchar2(30),
 g_speciality varchar2(50),
        PRIMARY KEY (gid)
);


create table clients(
 cid     integer, 
 c_name varchar2(30), 
 c_address varchar2(30), 
 c_mail varchar2(30), 
 c_status varchar2(30),
 c_branch varchar2(30),
        PRIMARY KEY (cid)
);

create table manager(
 m_id integer, 
 position varchar2(30),
 m_name varchar2(30),
 branch varchar2(30),
        PRIMARY KEY (m_id)
);

create table payment(
 cid integer,
 gid integer,
 payment_amount number,
 payment_status varchar2(30),
 payment_date varchar2(30),
      FOREIGN KEY(cid) REFERENCES clients(cid), 
      FOREIGN KEY(gid) REFERENCES guards(gid)
);

create table complaint(
 cid integer,
 gid integer,
 com_info varchar2(30),
      FOREIGN KEY(cid) REFERENCES clients(cid), 
      FOREIGN KEY(gid) REFERENCES guards(gid)
);

create table guard_rating(
 cid integer,
 gid integer,
 rating number,
      FOREIGN KEY(cid) REFERENCES clients(cid), 
      FOREIGN KEY(gid) REFERENCES guards(gid)
);

create table service(
 cid integer,
 gid integer,
 start_date varchar2(30),
 end_date varchar2(30),
      FOREIGN KEY(cid) REFERENCES clients(cid), 
      FOREIGN KEY(gid) REFERENCES guards(gid)
);

--Insert data into the guard database
insert into guards values(1, 'Sham', 'Dhanmondi', 30,'Male',5.5,12000,'Dhaka',5,4,'Busy','Night Shift');
insert into guards values(2, 'Rahim', 'Begunbari', 39,'Male',6,18000,'Chittagong',8,4.5,'Busy','Night Shift');
insert into guards values(3, 'Maria', 'Saydabad', 28,'Female',5.1,15000,'Dhaka',2,3.5,'Free','Shopping mall');
insert into guards values(4, 'Abdur', 'Bosila', 32,'Male',5,10000,'Chittagong',2,3,'Free','Parking');
insert into guards values(5, 'Aysha', 'Beribad', 34,'Female',5.8,16000,'Chittagong',4,4.2,'Busy','University');
insert into guards values(6, 'Sobur', 'Bosila', 32,'Male',5.6,18000,'Chittagong',5,4.4,'Free','University');
insert into guards values(7, 'Razzak', 'Puran dhaka', 34,'Male',5,14000,'Dhaka',4,4.7,'Busy','Shopping mall');
insert into guards values(8, 'Amina', 'Jamtola', 30,'Female',5.5,14000,'Dhaka',3,4,'Free','Personal');
insert into guards values(9, 'Akbar', 'Kodomtoli', 28,'Male',5.9,10000,'Dhaka',1,3.9,'Free','Personal');
insert into guards values(10, 'Salman', 'new market',34,'Male',5.7,10000,'Chittagong',6,3.5,'Busy','School');
insert into guards values(11, 'Kashem', 'Gabtoli', 37,'Male',5.6,13000,'Dhaka',3,4.2,'Busy','Office');

--Insert data into the client database
insert into clients values(1,'Md.Rashed','Khilgaon','r@gmail.com','Service','Dhaka');
insert into clients values(2,'Abu khayer','Chittagong','ak@gmail.com','Service','Chittagong');
insert into clients values(3,'Sujon saif','jigatola','ss@gmail.com','Service','Dhaka');
insert into clients values(4,'Fatima Khan','New market','fk@gmail.com','Service','Chittagong');
insert into clients values(5,'Amazad Ali','Dholai khal','aa@gmail.com','Service','Dhaka');
insert into clients values(6,'Sadek Khan','Old bazar','sk@gmail.com','Service','Chittagong');
insert into clients values(7,'Rajia Sultana','Gulshan','rs@gmail.com','Old','Dhaka');
insert into clients values(8,'rayhan Khan','Bazar road','rk@gmail.com','Old','Chittagong');
insert into clients values(9,'Jahir Haq','Dhanmondi','jh@gmail.com','Old','Dhaka');
insert into clients values(10,'Raj Basu','Gulshan','rb@gmail.com','Old','Dhaka');

--Insert data into the manager database
insert into manager values(1,'MD','Abdullah','Dhaka');
insert into manager values(2,'GM','Rahman','Dhaka');
insert into manager values(3,'GM','Shorif','Chittagong');

--Insert data into the payment database
insert into payment values(1,1,14000,'Clear','2 September 2020');
insert into payment values(2,2,0,'Pending','');
insert into payment values(3,7,300000,'Clear','12 August 2020');
insert into payment values(4,5,49000,'Clear','1 August 2020');
insert into payment values(5,9,13000,'Clear','8 June 2020');
insert into payment values(6,10,12000,'Clear','26 August 2020');
insert into payment values(5,9,39000,'Clear','8 July 2020');
insert into payment values(7,8,85000,'Clear','1 February 2020');
insert into payment values(8,4,30000,'Clear','1 march 2020');
insert into payment values(9,3,32000,'Clear','1 May 2020');
insert into payment values(10,1,25000,'Clear','1 November 2019');

--Insert data into the complaint database
insert into complaint values(6,10,'Careless behaviour');

--Insert data into the guard_rating database
insert into guard_rating values(1,1,4.1);
insert into guard_rating values(2,2,4.5);
insert into guard_rating values(5,9,4.5);
insert into guard_rating values(6,10,2);
insert into guard_rating values(7,8,3.5);
insert into guard_rating values(8,4,4.5);
insert into guard_rating values(9,3,3.9);
insert into guard_rating values(10,1,4.2);


--Insert data into the service database
insert into service values(1,1,'1 September 2020','1 October 2020');
insert into service values(2,2,'5 September 2020','5 November 2020');
insert into service values(3,7,'12 August 2020','12 October 2020');
insert into service values(4,5,'1 August 2020','1 November 2020');
insert into service values(5,9,'1 June 2020','1 July 2020');
insert into service values(6,10,'26 August 2020','27 August 2020');
insert into service values(5,9,'2 July 2020','2 October 2020');
insert into service values(7,8,'12 February 2020','1 August 2020');
insert into service values(8,4,'2 March 2020','1 May 2020');
insert into service values(9,3,'1 May 2020','1 June 2020');
insert into service values(10,1,'1 November 2019','1 January 2020');

commit;

select * from guards;
select * from clients;
select * from manager;
select * from payment;
select * from complaint;
select * from guard_rating;
select * from service;