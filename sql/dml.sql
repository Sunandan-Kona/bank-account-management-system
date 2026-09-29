-- =========================================================
-- BANK ACCOUNT MANAGEMENT SYSTEM
-- dml.sql : INSERT sample data (37 rows across 8 tables)
-- Run after ddl.sql
-- =========================================================

-- BRANCH
INSERT INTO BRANCH VALUES
(101,'Main Branch','MG Road','Kakinada','Andhra Pradesh','533001','BANK000101'),
(102,'Central Branch','RTC Complex Road','Rajahmundry','Andhra Pradesh','533101','BANK000102'),
(103,'City Branch','Beach Road','Visakhapatnam','Andhra Pradesh','530001','BANK000103'),
(104,'Town Branch','Station Road','Vijayawada','Andhra Pradesh','520001','BANK000104'),
(105,'Lake Branch','Lake View Road','Hyderabad','Telangana','500001','BANK000105');

-- CUSTOMER
INSERT INTO CUSTOMER VALUES
(1,'Rahul','Kumar','rahul@gmail.com','9876543210','MG Road','Kakinada','533001','2004-05-12',101),
(2,'Priya','Sharma','priya@gmail.com','9876543211','Main Road','Rajahmundry','533101','2003-08-20',102),
(3,'Arjun','Reddy','arjun@gmail.com','9876543212','Beach Road','Visakhapatnam','530001','2004-01-15',103),
(4,'Sneha','Patel','sneha@gmail.com','9876543213','MG Road','Vijayawada','520001','2003-11-25',104),
(5,'Kiran','Rao','kiran@gmail.com','9876543214','Banjara Hills','Hyderabad','500001','2004-03-10',105);

-- EMPLOYEE
INSERT INTO EMPLOYEE VALUES
(201,'Ramesh Kumar','9000000001','ramesh@bank.com','Manager',101),
(202,'Suresh Rao','9000000002','suresh@bank.com','Cashier',102),
(203,'Anita Sharma','9000000003','anita@bank.com','Manager',103),
(204,'Vikram Reddy','9000000004','vikram@bank.com','Clerk',104),
(205,'Meena Devi','9000000005','meena@bank.com','Cashier',105);

-- ACCOUNT
INSERT INTO ACCOUNT VALUES
(10000001,'Savings',25000.00,'2025-01-10','Active',1),
(10000002,'Savings',40000.00,'2025-02-15','Active',2),
(10000003,'Current',75000.00,'2025-03-20','Active',3),
(10000004,'Savings',15000.00,'2025-04-05','Active',4),
(10000005,'Current',90000.00,'2025-05-12','Active',5);

-- TRANSACTION
INSERT INTO TRANSACTION_TABLE VALUES
(301,'2026-09-01','10:30:00',5000.00,'Deposit','Cash deposit',10000001),
(302,'2026-09-02','11:15:00',2000.00,'Withdraw','ATM withdrawal',10000002),
(303,'2026-09-03','12:00:00',10000.00,'Transfer','Fund transfer',10000003),
(304,'2026-09-04','14:20:00',3000.00,'Deposit','Cheque deposit',10000004),
(305,'2026-09-05','16:10:00',5000.00,'Transfer','Online transfer',10000005);

-- LOAN
INSERT INTO LOAN VALUES
(401,'Home Loan',500000.00,7.50,'2026-01-01','2036-01-01','Active',1,10000001),
(402,'Education Loan',200000.00,6.50,'2026-02-01','2031-02-01','Active',2,10000002),
(403,'Personal Loan',150000.00,9.00,'2026-03-01','2029-03-01','Active',3,10000003),
(404,'Vehicle Loan',300000.00,8.00,'2026-04-01','2031-04-01','Active',4,10000004),
(405,'Personal Loan',100000.00,9.50,'2026-05-01','2029-05-01','Active',5,10000005);

-- BENEFICIARY
INSERT INTO BENEFICIARY VALUES
(501,'Amit Kumar',1,10000002,'ABC Bank'),
(502,'Neha Sharma',2,10000003,'XYZ Bank'),
(503,'Ravi Teja',3,10000004,'ABC Bank'),
(504,'Pooja Reddy',4,10000005,'XYZ Bank'),
(505,'Anil Kumar',5,10000001,'ABC Bank');

-- TRANSFER_TO
INSERT INTO TRANSFER_TO VALUES
(303,502),
(305,501);
