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
		PaymentDate DATETIME NOT NULL,
		AccountNumber NVARCHAR(500) NOT NULL,
		FirstDateOccupied DATETIME NOT NULL,
		LastDateOccupied DATETIME NOT NULL,
		TotalDays INT NOT NULL,
		AmountCharged MONEY NOT NULL,
		TaxRate SMALLMONEY NOT NULL,
		TaxAmount MONEY
	) 

