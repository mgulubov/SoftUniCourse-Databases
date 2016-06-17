USE master
GO

-- Create database if it doesn't exist
IF NOT EXISTS (SELECT * FROM dbo.sysdatabases WHERE name = 'Bank')
	CREATE DATABASE Bank;
GO

USE Bank
GO

-- Drop tables if they exist
IF OBJECT_ID('Accounts') IS NOT NULL
	DROP TABLE Accounts
IF OBJECT_ID('Persons') IS NOT NULL
	DROP TABLE Persons
GO

-- Create tables
CREATE TABLE Persons(
	Id int IDENTITY NOT NULL,
	FirstName nvarchar(50) NOT NULL,
	LastName nvarchar(50) NOT NULL,
	SSN nvarchar(20) NOT NULL

	CONSTRAINT PK_Persons
		PRIMARY KEY CLUSTERED (Id)
)

CREATE TABLE Accounts(
	Id int IDENTITY NOT NULL,
	PersonId int NOT NULL,
	Balance money NOT NULL

	CONSTRAINT PK_Accounts
		PRIMARY KEY CLUSTERED (Id)
)

-- Add integrity constraints
ALTER TABLE 
	Accounts
WITH CHECK
ADD
	CONSTRAINT 
		FK_Accounts_Persons
	FOREIGN KEY 
		(PersonId)
	REFERENCES
		Persons(Id)
GO

-- Insert test records
INSERT INTO 
	Persons(FirstName, LastName, SSN)
VALUES
	('Miroslav', 'Galabov', '8711086901'),
	('Zornica', 'Goranova', '8708221754'),
	('Maya', 'Petkova', 'NaN')
GO

INSERT INTO
	Accounts(PersonId, Balance)
VALUES
	(1, 1500.01),
	(2, 25987.9272710001),
	(3, 0)
GO

-- Drop stored procedure if exists
IF OBJECT_ID('PrintFullNameOfAllPersons', 'P') IS NOT NULL
	DROP PROCEDURE PrintFullNameOfAllPersons
GO

-- Create stored procedure
CREATE PROCEDURE
	PrintFullNameOfAllPersons
AS
BEGIN
	SELECT
		CONCAT(p.FirstName, ' ', p.LastName)
			AS 'Full name'
	FROM
		Persons p
END
GO

-- Calling the stored procedure
EXECUTE PrintFullNameOfAllPersons
GO