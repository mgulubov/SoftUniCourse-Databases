USE master
GO
--------------
--------------
-- Create database if not exist
IF DB_ID('Bank') IS NULL
	BEGIN
		CREATE DATABASE
			Bank
	END
GO
--------------
--------------
-- Switch databases
USE Bank
GO
--------------
--------------
-- Drop foreign keys if exist
IF OBJECT_ID('Accounts') IS NOT NULL
	BEGIN
		ALTER TABLE
			Accounts
		DROP CONSTRAINT IF EXISTS
			FK_Accounts_AccountHolderId_AccountHolders_Id
	END
GO
--------------
--------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	AccountHolders

DROP TABLE IF EXISTS
	Accounts
GO
--------------
--------------
-- Create tables
CREATE TABLE
	AccountHolders(
		Id INT IDENTITY NOT NULL
			CONSTRAINT PK_AccountHolders_Id PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		LastName NVARCHAR(150) NOT NULL,
		SSN NVARCHAR(50) NOT NULL
	)

CREATE TABLE
	Accounts(
		Id INT IDENTITY NOT NULL
			CONSTRAINT PK_Accounts_Id PRIMARY KEY,
		AccountHolderId INT NOT NULL
			CONSTRAINT FK_Accounts_AccountHolderId_AccountHolders_Id FOREIGN KEY REFERENCES AccountHolders(Id),
		Balance MONEY NOT NULL
			CONSTRAINT DEF_Accounts_Balance DEFAULT 0
	)
GO
--------------
--------------
-- Insert values
INSERT INTO
	AccountHolders
VALUES
	('Susan', 'Cane', '1111111'),
	('Kim', 'Novac', '222222222'),
	('Jimmy', 'Henderson', '333333333'),
	('John', 'Doe', '44444444')

INSERT INTO
	Accounts
VALUES
	(1, 2200),
	(2, 2200),
	(3, 0),
	(4, 15)
GO
--------------
-------------- 