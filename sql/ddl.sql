-- =========================================================
-- BANK ACCOUNT MANAGEMENT SYSTEM
-- ddl.sql : CREATE TABLE statements + constraints
-- PostgreSQL
-- =========================================================
-- Create and select the database first (psql):
--   CREATE DATABASE bank_account_management;
--   \c bank_account_management
-- Tables are created parent-first so every foreign key has a target.
-- NOTE: TRANSACTION is a reserved word in SQL, so the table is named
-- TRANSACTION_TABLE.

-- BRANCH
CREATE TABLE BRANCH (
    Branch_ID INT PRIMARY KEY,
    Branch_Name VARCHAR(100) NOT NULL,
    Branch_Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    PinCode VARCHAR(10),
    IFSCCode VARCHAR(20) UNIQUE
);

-- CUSTOMER
CREATE TABLE CUSTOMER (
    Customer_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(200),
    City VARCHAR(50),
    PinCode VARCHAR(10),
    Date_Of_Birth DATE,
    Branch_ID INT,
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);

-- EMPLOYEE
CREATE TABLE EMPLOYEE (
    Employee_ID INT PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Position VARCHAR(50),
    Branch_ID INT,
    FOREIGN KEY (Branch_ID) REFERENCES BRANCH(Branch_ID)
);

-- ACCOUNT
CREATE TABLE ACCOUNT (
    Account_Number BIGINT PRIMARY KEY,
    Account_Type VARCHAR(30) NOT NULL,
    Balance NUMERIC(12,2) DEFAULT 0.00,
    Open_Date DATE,
    Status VARCHAR(20) DEFAULT 'Active',
    Customer_ID INT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    CHECK (Balance >= 0)
);

-- TRANSACTION
CREATE TABLE TRANSACTION_TABLE (
    Transaction_ID INT PRIMARY KEY,
    Transaction_Date DATE NOT NULL,
    Transaction_Time TIME,
    Amount NUMERIC(12,2) NOT NULL,
    Type VARCHAR(20) NOT NULL,
    Description VARCHAR(200),
    Account_Number BIGINT NOT NULL,
    FOREIGN KEY (Account_Number) REFERENCES ACCOUNT(Account_Number),
    CHECK (Amount > 0),
    CHECK (Type IN ('Deposit', 'Withdraw', 'Transfer'))
);

-- LOAN
CREATE TABLE LOAN (
    Loan_ID INT PRIMARY KEY,
    Loan_Type VARCHAR(50) NOT NULL,
    Principle_Amount NUMERIC(12,2) NOT NULL,
    Interest_Rate NUMERIC(5,2),
    Start_Date DATE,
    End_Date DATE,
    Status VARCHAR(20),
    Customer_ID INT NOT NULL,
    Account_Number BIGINT NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Account_Number) REFERENCES ACCOUNT(Account_Number),
    CHECK (Principle_Amount > 0),
    CHECK (Interest_Rate >= 0)
);

-- BENEFICIARY
CREATE TABLE BENEFICIARY (
    Beneficiary_ID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Customer_ID INT NOT NULL,
    Account_Number BIGINT,
    Bank_Name VARCHAR(100),
    FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER(Customer_ID),
    FOREIGN KEY (Account_Number) REFERENCES ACCOUNT(Account_Number)
);

-- TRANSFER_TO (associative table for the M:N TRANSACTION <-> BENEFICIARY relationship)
CREATE TABLE TRANSFER_TO (
    Transaction_ID INT,
    Beneficiary_ID INT,
    PRIMARY KEY (Transaction_ID, Beneficiary_ID),
    FOREIGN KEY (Transaction_ID) REFERENCES TRANSACTION_TABLE(Transaction_ID),
    FOREIGN KEY (Beneficiary_ID) REFERENCES BENEFICIARY(Beneficiary_ID)
);
