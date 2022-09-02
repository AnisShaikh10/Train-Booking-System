-- To check all tables from user
select table_name from user_tables;

--------------------------------------------------------------------------------
-- Creating new Table Customers  Details
CREATE TABLE customers_details (cust_id int NOT NULL CONSTRAINT pk_cid PRIMARY KEY,first_name varchar(20), last_name varchar(20), contact_details int constraint conct_dtls check(contact_details>9), address varchar(30));

-- Table Description for Customers  Details
desc customers_details;

-- Auto Increment Query
CREATE sequence cus_id start with 1 increment by 1 cache 10;
drop SEQUENCE cus_id;

--Insering Data into Customers  Details
INSERT into customers_details values (CUS_ID.nextval,'Ajay','Kedia',98765432, 'Mumbai');

INSERT into customers_details values (CUS_ID.nextval,'Harshad','Metha',9115463, 'Gujrat');

INSERT into customers_details values (CUS_ID.nextval,'Mannu','Mudra',945624, 'Mumbai');

INSERT into customers_details values (CUS_ID.nextval,'Bhushan','Bhatt',985647, 'Gujrat');

INSERT into customers_details values (CUS_ID.nextval,'Rakesh','Junjunwala',91678, 'Hyderabad');


--Display Table Content
select * from customers_details;

--Delete Content from Table
DELETE from customers_details;
--------------------------------------------------------------------------------

-- Creating new Table Train
CREATE TABLE train (train_no int NOT NULL CONSTRAINT pk_tno PRIMARY Key, train_name varchar(20), seat_types VARCHAR(10), total_seats INT);

-- Table Description for Train Details
desc train;

--alter table train RENAME column departre_time to departure_time;

alter table train modify (departure_time varchar(10), arrival_time varchar(10));

--Insering Data into Train Details
INSERT INTO train VALUES (06601, 'MAO MAQ SPL', 'GN SL AC', 15);

INSERT INTO train VALUES (08048, 'VSG HWH SPL', 'GN SL AC', 15);

INSERT INTO train VALUES (01152, 'JANSHATABDI SPL', 'GN SL AC', 15);

INSERT INTO train VALUES (07340,'VSG YPR EXP', 'GN SL AC', 15);


--Display Table Content
select * from train;

--Delete Content from Table
DELETE from train;
--------------------------------------------------------------------------------

-- Creating new Table Train Details
CREATE TABLE train_details (train_no int CONSTRAINT pk_stid PRIMARY KEY CONSTRAINT fk_trno REFERENCES train(train_no), departure_date date, start_location varchar(20), departure_time VARCHAR(10), mid_location VARCHAR(20), end_location VARCHAR(20), arrival_time VARCHAR(10), available_seats int);

-- Table Description for Station Details
desc train_details;

--Insering Data into Station Details
INSERT INTO train_details VALUES (6601, '01-10-21', 'Margao', '2:30PM',  'Karwar', 'Manglore', '11:30PM', 15,);

INSERT INTO train_details VALUES (8048, '03-10-21', 'VASCO DA GAMA', '7:00AM', 'BRAHMAPUR', 'HOWRAH JN', '5:00AM', 15);

INSERT INTO train_details VALUES (1152, '04-10-21', 'Margao', '7:30AM',  'RATNAGIRI', 'C SHIVAJI MAH T', '2:00PM', 15);

INSERT INTO train_details VALUES (7340, '04-10-21', 'VASCO DA GAMA', '11:05PM', 'CASTLE ROCK', 'YESVANTPUR JN', '12:35PM', 15);


--Display Table Content
select * from train_details;

--Delete Content from Table
DELETE from train_details;
--------------------------------------------------------------------------------

-- Creating new Table Booking Details
CREATE table booking_details (book_id int NOT NULL Constraint pk_bkid primary key, traveling_date date, traveling_src varchar(20), traveling_dst varchar(20), traveling_time varchar(10), no_of_passengers int, seat_type varchar(10), book_status VARCHAR(10) DEFAULT 'Pending',cust_id int constraint fk_cid REFERENCES customers_details(cust_id), train_no int CONSTRAINT fk_train_no REFERENCES train_details(train_no));

-- Table Description for Reservation Details
desc booking_details;


-- Auto Increment Query
CREATE sequence resv_id start with 1 increment by 1 cache 10;
drop SEQUENCE resv_id;



--Insering Data into Reservation Details
INSERT INTO booking_details  (book_id, traveling_date, traveling_src, traveling_dst, traveling_time, no_of_passengers, seat_type, cust_id, train_no)  VALUES (resv_id.nextval, '01-10-21', 'Margao', 'Manglore', '2:30PM', 1, 'GN', 1, 6601);

INSERT INTO booking_details  (book_id, traveling_date, traveling_src, traveling_dst, traveling_time, no_of_passengers, seat_type, cust_id, train_no) VALUES (resv_id.nextval, '01-10-21', 'Margao', 'Manglore', '1:30PM', 1, 'GN', 2, 6601);

INSERT INTO booking_details  (book_id, traveling_date, traveling_src, traveling_dst, traveling_time, no_of_passengers, seat_type, cust_id, train_no) VALUES (resv_id.nextval, '03-10-21', 'VASCO DA GAMA', 'BRAHMAPUR', '7:00AM', 1, 'SL', 3, 8048);

INSERT INTO booking_details  (book_id, traveling_date, traveling_src, traveling_dst, traveling_time, no_of_passengers, seat_type, cust_id, train_no) VALUES (resv_id.nextval, '04-10-21', 'Margao', 'C SHIVAJI MAH T', '7:30AM', 3, 'AC', 4, 1152);

INSERT INTO booking_details  (book_id, traveling_date, traveling_src, traveling_dst, traveling_time, no_of_passengers, seat_type, cust_id, train_no) VALUES (resv_id.nextval, '04-10-21', 'CASTLE ROCK', 'YESVANTPUR JN', '11:05PM', 2, 'GN', 5, 7340);


--Display Table Content
select * from booking_details;


--Delete Content from Table
DELETE from booking_details;

--------------------------------------------------------------------------------

-- Creating new Table Payment Status
Create table payment (pay_id int constraint pk_pid primary key, pay_mode varchar(10), pay_status varchar(10), book_id int constraint fk_bid REFERENCES booking_details(book_id));

-- Table Description for Payment Status
desc payment;

--Insering Data into Payment Status
INSERT INTO payment VALUES (1, 'UPI', 'Paid', 1);

INSERT INTO payment VALUES (2, 'Debit Card', 'Failed', 2);

INSERT INTO payment VALUES (3, 'CreditCard', 'Paid', 3);

INSERT INTO payment VALUES (4, 'Cash', 'Paid', 4);

INSERT INTO payment VALUES (5, 'NetBanking', 'Paid', 5);

INSERT INTO payment VALUES (6, 'UPI', 'Pending', 5);


--Display Table Content
select * from payment;

--Delete Content from Table
DELETE from payment;

DELETE from payment where pay_id=7;
--------------------------------------------------------------------------------

-- Creating new Table Ticket Details
CREATE table ticket_details (ticket_no int NOT NULL constraint pk_tcktno Primary Key, seat_no varchar(20) CONSTRAINT uq_stno unique, price INT, book_id int CONSTRAINT fk_bkid references booking_details(book_id));

-- Table Description for Ticket Details
desc ticket_details;


--Insering Data into Ticket Details
INSERT INTO ticket_details  VALUES (1001, 'G1', 200, 1);

INSERT INTO ticket_details  VALUES (1002, 'SL1', 400, 3);

INSERT INTO ticket_details  VALUES (1003, 'AC1 AC2 AC3', 3600, 4);

INSERT INTO ticket_details  VALUES (1004, 'G2 G3', 400, 5);

--Display Table Content
select * from ticket_details;

--Delete Content from Table
DELETE from ticket_details;

----------------------- Admin and Customers Queries ------------------------------------------

--Display All the Customer Details who have done Bookings
select customers_details.cust_id, customers_details.first_name, customers_details.contact_details, customers_details.address, booking_details.book_id, booking_details.traveling_date, booking_details.traveling_src, booking_details.traveling_dst, booking_details.no_of_passengers from booking_details left join customers_details on booking_details.cust_id = customers_details.cust_id;

--Dislpay Specific Customer details and their Booking Details  --For Admin and Customer
select * from customers_details c left join booking_details b on b.cust_id = c.cust_id where b.book_id = 1; 

--Display Total No. of People from each Location
select count(cust_id), address from customers_details GROUP BY address;

--Display Total No. of People traveling from specific Start Location
SELECT count(book_id), traveling_src from booking_details GROUP BY traveling_src;

--Display Booking Details of Customer having Nuumber of passengers greater then 2
select * from customers_details c,booking_details b where c.cust_id = b.cust_id and b.no_of_passengers > 1 order by b.cust_id asc;

--Tickect details of Customer whoes Booking has been Confirmed
select * from ticket_details t left join booking_details b on t.book_id = b.book_id where b.book_id = (SELECT book_id FROM payment where pay_status = 'Successful' and book_id = b.book_id);

--Display All Booking Details Booked On Specific Date
select * from booking_details where traveling_date = '04-10-21';

--Display All the Train with their Details  --For Admin and Customer
select t.train_no, t.train_name, t.seat_types, td.departure_date, td.start_location, td.departure_time, td.mid_location, td.end_location, td.arrival_time, t.total_seats, td.available_seats from train t left join train_details td on t.train_no = td.train_no;

--Display the Sum of Fare Price according to Train_no
select b.train_no,sum(price) from ticket_details t, booking_details b where t.book_id = b.book_id group by b.train_no;


----------------------Procedures AND Triggers-----------------------------------
set serveroutput on;

--Trigger to update Available Seats
CREATE OR REPLACE TRIGGER available_seats
BEFORE DELETE OR INSERT OR UPDATE 
of available_seats
ON train_details
FOR EACH ROW
WHEN(old.available_seats >0)
Declare
x number:=0;
Begin
        x := :old.train_no;
        dbms_output.put_line('Train.NO: '||x);
        dbms_output.put_line('OLD Available Seats: '||:OLD.available_seats);
        dbms_output.put_line('New Available Seats: '||:NEW.available_seats);
END;
/


-- Triggers to Update Booking Status
CREATE OR REPLACE TRIGGER booking_status
BEFORE DELETE OR INSERT OR UPDATE 
of book_status
ON booking_details
FOR EACH ROW
When(NEW.book_id > 0)
Begin
    dbms_output.put_line('Booking ID: '||:NEW.book_id);
    dbms_output.put_line('OLD Booking Status: '||:OLD.book_status);
    dbms_output.put_line('New Booking Status: '||:NEW.book_status);
    dbms_output.put_line('');
END;
/


--Procedure For Updating Booking Status and Available Seats When Paytem Is Successfull
Declare
    pid payment.pay_id%type:=1;
    pay_stat payment.pay_status%type;
    bkid payment.book_id%type;
    
    b_bkid BOOKING_DETAILS.book_id%type:=1;
    book_stat BOOKING_DETAILS.book_status%type;
    pssngr BOOKING_DETAILS.no_of_passengers%type;
    trno BOOKING_DETAILS.train_no%type;
    
    seats train_details.available_seats%type;
    td_trno train_details.train_no%type;
Begin

    -- Loop to go through all the values in the Tables  
    LOOP
        select pay_id, pay_status, book_id into pid, pay_stat, bkid from payment where pay_id = pid;
        select book_id, book_status, no_of_passengers, train_no into b_bkid, book_stat, pssngr, trno from booking_details where book_id = bkid;
        select train_no, available_seats into td_trno, seats from train_details where train_no = trno;
        
        -- Check if the payment is successful then Confoirm the Booking Status  
        IF pay_stat = 'Paid' THEN
        
            dbms_output.put_line('Pay ID: ' || pid || ' Pay Status:' || pay_stat);
            dbms_output.put_line('');
            update booking_details set book_status = 'Confirm' where book_id = (select book_id from payment where pay_status= 'Paid' and book_id = bkid) 
            and traveling_date = any(select departure_date from train_details where departure_date = booking_details.traveling_date) and train_no  = (select train_no from train_details where available_seats > 0 and train_no = booking_details.train_no);
            
            --Check the Available Seats
            IF seats <= 0 and pay_stat = 'Paid' THEN
                
                --If the available seats are Less then zero then Updating Available Seats to 0 
                update train_details set available_seats = 0 where available_seats <= 0;
                
                dbms_output.put_line('Seats are Full for Train No: ' || td_trno);
                dbms_output.put_line('');
                update booking_details set book_status = 'Waiting' where train_no = (select train_no from train_details where available_seats <= 0 and train_no = booking_details.train_no) 
                and book_id = (select book_id from payment where pay_status  = 'Paid' and book_id = booking_details.book_id);
            
            ELSE
                 --If the available seats are Greater then zero then Deduction of Available Seats With No_OF Passengers for a Particular Train 
                update train_details set available_seats = (Select t.available_seats - (Select sum(no_of_passengers) From booking_details Where book_status = 'Confirm' and train_no = t.train_no) as available_seats 
                From train_details t where train_no = trno) where train_no = trno;
                dbms_output.put_line('');
            END IF;
            
        --If payment status is failed the Updating Booking Status to Failed
         ELSIF pay_stat = 'Failed' THEN
            
            update booking_details set book_status = 'Failed' where book_id = (select pay_id from payment where book_id = booking_details.book_id and pay_status = 'Failed');
        
        END IF;
    
        pid:= pid+1;
        IF pid > 10 THEN
        EXIT;
        
        END IF;    
    END LOOP;
    
    Exception
    when no_data_found then
        dbms_output.put_line('Data Updated Successfuly');
    When others then
        dbms_output.put_line('Error!');
End;
/

--Procedure to View Ticket Details to Customer Based on Booking ID
Accept inpt Number PROMPT 'ENTER Book ID: ';
Declare
    user_input Number:= &inpt;
    tickt ticket_details%ROWTYPE;
Begin

    select * into tickt from ticket_details where book_id = user_input;
    dbms_output.put_line('Ticket_no: ' || tickt.ticket_no || ' Seat No: ' || tickt.seat_no || ' Price: ' || tickt.price);
    
    Exception
    WHEN OTHERS THEN
    dbms_output.put_line('ERROR!');
End;
/


--Procedure to Calculate Ticket Price 
Accept inpt Number Prompt 'Enter Book_Id';
Declare
    book booking_details%rowtype;
    ticket ticket_details%rowtype;
    price ticket_details.price%type;
    x number:= &inpt;
Begin
    select * into book from booking_details where book_status = 'Confirm' and book_id = x;
    select * into ticket from ticket_details where book_id = x;
    
    dbms_output.put_line('No of Passengers: ' || book.no_of_passengers );
    
    If book.seat_type = 'GN' then
    
        update ticket_details set price = 200 * book.no_of_passengers where book_id = x;
        
    ELSIF book.seat_type = 'SL' then
    
        update ticket_details set price = 400 * book.no_of_passengers where book_id = x;
        
    ELSIF book.seat_type = 'AC' then
    
        update ticket_details set price = 800 * book.no_of_passengers where book_id = x;
        
    End if;

    select price into price from ticket_details where book_id = x;
    dbms_output.put_line('Updated Price: ' || price);
    
    Exception
    when no_data_found then
        dbms_output.put_line('No such Book_ID');
    When others then
        dbms_output.put_line('Error!');
End;
/


--Case Statement for Checking Booking Status
Select
    Case
    When book_status = 'Failed' and pay_status = 'Failed' Then 
        'Booking Status = ''Failed''  Your payment was Unsuccessful!!, If any amount has been deducted you will receive refund in 2-3 Working Days.'       
    Else
         'Your Ticket has been booked Sussessfully, Your will receive your Ticket Shortly..'
    End as Booking_Status
From booking_details b, payment p where b.book_id = p.book_id and b.book_id = 2;


