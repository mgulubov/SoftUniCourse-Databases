USE TableRelationsTestDatabase
GO
---------------------
---------------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	Persons
---------------------
DROP TABLE IF EXISTS
	Passports
GO
---------------------
---------------------
-- Create tables
CREATE TABLE
	Passports(
		PassportID INT NOT NULL
			CONSTRAINT PK_Passports_PassportID PRIMARY KEY,
		PassportNumber NVARCHAR(200) NOT NULL
	)
---------------------
CREATE TABLE
	Persons(
		PersonID INT NOT NULL
			CONSTRAINT PK_Persons_PersonID PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		Salary MONEY NOT NULL,
		PassportID INT
			CONSTRAINT FK_Persons_PassportID_Passports_PassportID REFERENCES Passports(PassportID)
	)
---------------------
---------------------
-- Insert values
INSERT INTO
	Passports
VALUES
	(101, 'N34FG21B'),
	(102, 'K65LO4R7'),
	(103, 'ZE657QP2')
---------------------
INSERT INTO
	Persons
VALUES
	(1, 'Roberto', 43300.00, 102),
	(2, 'Tom', 56100.00, 103),
	(3, 'Yana',	60200.00, 101)
---------------------
---------------------