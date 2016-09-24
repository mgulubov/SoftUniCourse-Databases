USE master
GO

-- Drop connections
ALTER DATABASE
	Hotel
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Drop database if exists
DROP DATABASE IF EXISTS
	Hotel
GO

-- Create database
CREATE DATABASE
	Hotel
GO

USE Hotel
GO

-- Create tables
CREATE TABLE
	Employees(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Employees_Id PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		LastName NVARCHAR(150) NOT NULL,
		Title NVARCHAR(250),
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	Customers(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Customers_Id PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		LastName NVARCHAR(150) NOT NULL,
		PhoneNumber NVARCHAR(250),
		EmergencyName NVARCHAR(250),
		EmergencyNumber NVARCHAR(250),
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	RoomStatus(
		RoomStatus NVARCHAR(150) NOT NULL
			CONSTRAINT PK_RoomStatus_RoomStatus PRIMARY KEY,
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	RoomTypes(
		RoomType NVARCHAR(150) NOT NULL
			CONSTRAINT PK_RoomTypes_RoomType PRIMARY KEY,
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	BedTypes(
		BedType NVARCHAR(150) NOT NULL
			CONSTRAINT PK_BedTypes_BedType PRIMARY KEY,
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	Rooms(
		RoomNumber SMALLINT NOT NULL,
		RoomType NVARCHAR(150) NOT NULL
			CONSTRAINT FK_Rooms_RoomType_RoomTypes REFERENCES RoomTypes(RoomType),
		BedType NVARCHAR(150) NOT NULL
			CONSTRAINT FK_Rooms_BedType_BedTypes REFERENCES BedTypes(BedType),
		Rate SMALLINT,
		RoomStatus NVARCHAR(150) NOT NULL
			CONSTRAINT FK_Rooms_RoomStatus_RoomStatus REFERENCES RoomStatus(RoomStatus),
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	Payments(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Payments_Id PRIMARY KEY,
		EmployeeId INT NOT NULL
			CONSTRAINT FK_Payments_EmployeeId_Employees REFERENCES Employees(Id),
		PaymentDate DATETIME,
		AccountNumber NVARCHAR(500),
		FirstDateOccupied DATETIME,
		LastDateOccupied DATETIME,
		TotalDays INT,
		AmountCharged MONEY,
		TaxRate SMALLMONEY,
		TaxAmount MONEY,
		PaymentTotal MONEY,
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	Occupancies(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Occupancies_Id PRIMARY KEY,
		EmployeeId INT NOT NULL
			CONSTRAINT FK_Occupancies_EmployeeId_Employees REFERENCES Employees(Id),
		DateOccupied DATETIME,
		AccountNumber NVARCHAR(200),
		RoomNumber SMALLINT,
		RateApplied FLOAT(3),
		PhoneCharge FLOAT(3),
		Notes NVARCHAR(MAX)
	)

-- Insert Values
INSERT INTO
	Employees(FirstName, LastName)
VALUES
	('Miroslav', 'Galabov'),
	('John', 'Doe'),
	('Jane', 'Doe')

INSERT INTO
	Customers(FirstName, LastName)
VALUES
	('Miroslav', 'Galabov'),
	('John', 'Doe'),
	('Jane', 'Doe')

INSERT INTO
	RoomStatus(RoomStatus)
VALUES
	('Occupied'),
	('Available'),
	('Not Available')

INSERT INTO
	RoomTypes(RoomType)
VALUES
	('Single'),
	('Double'),
	('Apartment')

INSERT INTO
	BedTypes(BedType)
VALUES
	('Single'),
	('Double'),
	('King Size')

INSERT INTO
	Rooms(RoomNumber, RoomType, BedType, RoomStatus)
VALUES
	(1, 'Single', 'Single', 'Occupied'),
	(2, 'Double', 'Double', 'Available'),
	(3, 'Apartment', 'King Size', 'Not Available')

INSERT INTO
	Payments(EmployeeId)
VALUES
	(1),
	(2),
	(3)

INSERT INTO
	Occupancies(EmployeeId)
VALUES
	(1),
	(2),
	(3)

