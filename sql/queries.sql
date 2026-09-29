-- =========================================================
-- BANK ACCOUNT MANAGEMENT SYSTEM
-- queries.sql : CRUD, joins, aggregates, subqueries, views,
--               set operations, DCL and TCL (Q1-Q51, V1-V2)
-- Run after ddl.sql and dml.sql
-- =========================================================

-- QUERY 1: Display all customers
SELECT * FROM CUSTOMER;

-- QUERY 2: List active accounts
SELECT *
FROM ACCOUNT
WHERE Status = 'Active';

-- QUERY 3: Accounts with balance above 30000
SELECT *
FROM ACCOUNT
WHERE Balance > 30000;

-- QUERY 4: Accounts ordered by balance (highest first)
SELECT *
FROM ACCOUNT
ORDER BY Balance DESC;

-- QUERY 5: List all savings accounts
SELECT *
FROM ACCOUNT
WHERE Account_Type = 'Savings';

-- QUERY 6: Customer with account details
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       A.Account_Number, A.Account_Type, A.Balance
FROM CUSTOMER C
JOIN ACCOUNT A
ON C.Customer_ID = A.Customer_ID;

-- QUERY 7: Customer with branch details
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       B.Branch_Name, B.City
FROM CUSTOMER C
JOIN BRANCH B
ON C.Branch_ID = B.Branch_ID;

-- QUERY 8: Account with its transactions
SELECT A.Account_Number, A.Account_Type,
       T.Transaction_ID, T.Amount, T.Type
FROM ACCOUNT A
JOIN TRANSACTION_TABLE T
ON A.Account_Number = T.Account_Number;

-- QUERY 9: Customer with loan details
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       L.Loan_ID, L.Loan_Type, L.Principle_Amount
FROM CUSTOMER C
JOIN LOAN L
ON C.Customer_ID = L.Customer_ID;

-- QUERY 10: Employee with branch details
SELECT E.Employee_ID, E.Employee_Name, E.Position,
       B.Branch_Name, B.City
FROM EMPLOYEE E
JOIN BRANCH B
ON E.Branch_ID = B.Branch_ID;

-- QUERY 11: Total number of customers
SELECT COUNT(*) AS Total_Customers
FROM CUSTOMER;

-- QUERY 12: Total balance held by the bank
SELECT SUM(Balance) AS Total_Balance
FROM ACCOUNT;

-- QUERY 13: Average account balance
SELECT ROUND(AVG(Balance), 2) AS Average_Balance
FROM ACCOUNT;

-- QUERY 14: Highest account balance
SELECT MAX(Balance) AS Highest_Balance
FROM ACCOUNT;

-- QUERY 15: Lowest account balance
SELECT MIN(Balance) AS Lowest_Balance
FROM ACCOUNT;

-- QUERY 16: Number of accounts by type
SELECT Account_Type, COUNT(*) AS Total_Accounts
FROM ACCOUNT
GROUP BY Account_Type;

-- QUERY 17: Total balance by account type
SELECT Account_Type, SUM(Balance) AS Total_Balance
FROM ACCOUNT
GROUP BY Account_Type;

-- QUERY 18: Average balance by account type
SELECT Account_Type,
       ROUND(AVG(Balance), 2) AS Average_Balance
FROM ACCOUNT
GROUP BY Account_Type;

-- QUERY 19: Number of customers in each branch
SELECT Branch_ID, COUNT(*) AS Total_Customers
FROM CUSTOMER
GROUP BY Branch_ID;

-- QUERY 20: Account types having more than one account
SELECT Account_Type, COUNT(*) AS Total_Accounts
FROM ACCOUNT
GROUP BY Account_Type
HAVING COUNT(*) > 1;

-- QUERY 21: Accounts above the average balance
SELECT *
FROM ACCOUNT
WHERE Balance >
(SELECT AVG(Balance) FROM ACCOUNT);

-- QUERY 22: Customer holding the highest balance
SELECT C.Customer_ID, C.First_Name, C.Last_Name, A.Balance
FROM CUSTOMER C
JOIN ACCOUNT A
ON C.Customer_ID = A.Customer_ID
WHERE A.Balance =
(SELECT MAX(Balance) FROM ACCOUNT);

-- QUERY 23: Accounts with balance above 50000
SELECT *
FROM ACCOUNT
WHERE Balance > 50000;

-- QUERY 24: Customers having active loans
SELECT DISTINCT C.Customer_ID, C.First_Name, C.Last_Name
FROM CUSTOMER C
WHERE C.Customer_ID IN
(SELECT Customer_ID FROM LOAN
 WHERE Status = 'Active');

-- QUERY 25: Change the phone number of customer 1
UPDATE CUSTOMER
SET Phone = '9999999999'
WHERE Customer_ID = 1;

-- QUERY 26: Verify the updated customer
SELECT *
FROM CUSTOMER
WHERE Customer_ID = 1;

-- QUERY 27: Mark account 10000004 as Inactive
UPDATE ACCOUNT
SET Status = 'Inactive'
WHERE Account_Number = 10000004;

-- QUERY 28: Verify the updated account
SELECT *
FROM ACCOUNT
WHERE Account_Number = 10000004;

-- QUERY 29: Remove beneficiary 505
DELETE FROM BENEFICIARY
WHERE Beneficiary_ID = 505;

-- QUERY 30: Verify the beneficiary is deleted
SELECT *
FROM BENEFICIARY
WHERE Beneficiary_ID = 505;

-- QUERY 31: All customers with or without accounts
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       A.Account_Number, A.Balance
FROM CUSTOMER C
LEFT JOIN ACCOUNT A
ON C.Customer_ID = A.Customer_ID;

-- QUERY 32: Customer, account and branch together
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       A.Account_Number, A.Balance, B.Branch_Name
FROM CUSTOMER C
JOIN ACCOUNT A
ON C.Customer_ID = A.Customer_ID
JOIN BRANCH B
ON C.Branch_ID = B.Branch_ID;

-- QUERY 33: Transfer transactions with beneficiaries
SELECT T.Transaction_ID, T.Amount, T.Type,
       B.Beneficiary_ID, B.Name AS Beneficiary_Name, B.Bank_Name
FROM TRANSACTION_TABLE T
JOIN TRANSFER_TO TT
ON T.Transaction_ID = TT.Transaction_ID
JOIN BENEFICIARY B
ON TT.Beneficiary_ID = B.Beneficiary_ID;

-- QUERY 34: Categorise accounts by balance
SELECT Account_Number, Balance,
  CASE
    WHEN Balance >= 50000 THEN 'High Balance'
    WHEN Balance >= 25000 THEN 'Medium Balance'
    ELSE 'Low Balance'
  END AS Balance_Category
FROM ACCOUNT;

-- QUERY 35: Customers having an active loan
SELECT C.Customer_ID, C.First_Name, C.Last_Name
FROM CUSTOMER C
WHERE EXISTS
(SELECT 1 FROM LOAN L
 WHERE L.Customer_ID = C.Customer_ID
 AND L.Status = 'Active');

-- VIEW 1: Customer-account view (non-updatable, joins two tables)
CREATE VIEW Customer_Account_View AS
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       A.Account_Number, A.Account_Type,
       A.Balance, A.Status
FROM CUSTOMER C
JOIN ACCOUNT A
ON C.Customer_ID = A.Customer_ID;
SELECT * FROM Customer_Account_View;

-- VIEW 2: Customer-loan view (non-updatable, joins two tables)
CREATE VIEW Customer_Loan_View AS
SELECT C.Customer_ID, C.First_Name, C.Last_Name,
       L.Loan_ID, L.Loan_Type, L.Principle_Amount,
       L.Interest_Rate, L.Status
FROM CUSTOMER C
JOIN LOAN L
ON C.Customer_ID = L.Customer_ID;
SELECT * FROM Customer_Loan_View;

-- QUERY 36: Customer and account on the common column Customer_ID
SELECT Customer_ID, First_Name, Account_Number, Balance
FROM CUSTOMER NATURAL JOIN ACCOUNT;

-- QUERY 37: Employees with their branch (WHERE-clause form)
SELECT E.Employee_Name, E.Position, B.Branch_Name
FROM EMPLOYEE E, BRANCH B
WHERE E.Branch_ID = B.Branch_ID;

-- QUERY 38: All beneficiaries, with transfers if any
SELECT B.Beneficiary_ID, B.Name, TT.Transaction_ID
FROM TRANSFER_TO TT
RIGHT JOIN BENEFICIARY B
ON TT.Beneficiary_ID = B.Beneficiary_ID;

-- QUERY 39: All accounts and all transactions
SELECT A.Account_Number, T.Transaction_ID, T.Amount
FROM ACCOUNT A
FULL OUTER JOIN TRANSACTION_TABLE T
ON A.Account_Number = T.Account_Number;

-- QUERY 40: Accounts above the average of their own account type
SELECT A.Account_Number, A.Account_Type, A.Balance
FROM ACCOUNT A
WHERE A.Balance >
(SELECT AVG(A2.Balance) FROM ACCOUNT A2
 WHERE A2.Account_Type = A.Account_Type);

-- QUERY 41: Simple single-table view; UPDATE passes through to ACCOUNT
CREATE VIEW Active_Account_View AS
SELECT Account_Number, Account_Type, Balance, Status
FROM ACCOUNT
WHERE Status = 'Active';
UPDATE Active_Account_View
SET Balance = Balance + 1000
WHERE Account_Number = 10000001;
SELECT * FROM Active_Account_View;

-- QUERY 42: Aggregate view; UPDATE is rejected
CREATE VIEW Branch_Summary_View AS
SELECT B.Branch_ID, B.Branch_Name,
       COUNT(C.Customer_ID) AS Total_Customers
FROM BRANCH B
LEFT JOIN CUSTOMER C
ON B.Branch_ID = C.Branch_ID
GROUP BY B.Branch_ID, B.Branch_Name;
SELECT * FROM Branch_Summary_View;
UPDATE Branch_Summary_View
SET Total_Customers = 10
WHERE Branch_ID = 101;
-- Expected: ERROR - views containing GROUP BY are not updatable

-- QUERY 43: All customers and employees as one list
SELECT First_Name AS Person_Name, 'Customer' AS Role
FROM CUSTOMER
UNION
SELECT Employee_Name, 'Employee'
FROM EMPLOYEE
ORDER BY Role, Person_Name;

-- QUERY 44: Accounts having a transfer and also a loan
SELECT Account_Number FROM TRANSACTION_TABLE
WHERE Type = 'Transfer'
INTERSECT
SELECT Account_Number FROM LOAN
ORDER BY Account_Number;

-- QUERY 45: Accounts with no transfer transaction
SELECT Account_Number FROM ACCOUNT
EXCEPT
SELECT Account_Number FROM TRANSACTION_TABLE
WHERE Type = 'Transfer'
ORDER BY Account_Number;

-- QUERY 46: Give a clerk role read and insert rights on transactions
CREATE ROLE clerk_role;
GRANT SELECT, INSERT
ON TRANSACTION_TABLE
TO clerk_role;

-- QUERY 47: Withdraw the insert right again
REVOKE INSERT
ON TRANSACTION_TABLE
FROM clerk_role;

-- QUERY 48: Make a fund transfer permanent
BEGIN;
UPDATE ACCOUNT SET Balance = Balance - 2000
WHERE Account_Number = 10000002;
UPDATE ACCOUNT SET Balance = Balance + 2000
WHERE Account_Number = 10000001;
COMMIT;
SELECT Account_Number, Balance FROM ACCOUNT
WHERE Account_Number IN (10000001, 10000002)
ORDER BY Account_Number;

-- QUERY 49: Mark a point inside a running transaction
BEGIN;
UPDATE ACCOUNT SET Balance = Balance - 500
WHERE Account_Number = 10000003;
SAVEPOINT sp_after_debit;
UPDATE ACCOUNT SET Balance = Balance + 500
WHERE Account_Number = 10000005;  -- wrong account

-- QUERY 50: Undo the wrong credit, then complete correctly
ROLLBACK TO SAVEPOINT sp_after_debit;
UPDATE ACCOUNT SET Balance = Balance + 500
WHERE Account_Number = 10000004;
COMMIT;
SELECT Account_Number, Balance FROM ACCOUNT
WHERE Account_Number IN (10000003, 10000004, 10000005)
ORDER BY Account_Number;

-- QUERY 51: Final verification - row count of every table
SELECT 'BRANCH' AS Table_Name, COUNT(*) AS Row_Count FROM BRANCH
UNION ALL
SELECT 'CUSTOMER', COUNT(*) FROM CUSTOMER
UNION ALL
SELECT 'EMPLOYEE', COUNT(*) FROM EMPLOYEE
UNION ALL
SELECT 'ACCOUNT', COUNT(*) FROM ACCOUNT
UNION ALL
SELECT 'TRANSACTION_TABLE', COUNT(*) FROM TRANSACTION_TABLE
UNION ALL
SELECT 'LOAN', COUNT(*) FROM LOAN
UNION ALL
SELECT 'BENEFICIARY', COUNT(*) FROM BENEFICIARY
UNION ALL
SELECT 'TRANSFER_TO', COUNT(*) FROM TRANSFER_TO;
