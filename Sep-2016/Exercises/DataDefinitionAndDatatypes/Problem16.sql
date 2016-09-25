USE master
GO

-- Drop connections
ALTER DATABASE
	SoftUni
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Drop database if exists
DROP DATABASE IF EXISTS
	SoftUni
GO

-- Create database
CREATE DATABASE
	SoftUni
GO

USE SoftUni
GO

-- Create tables
CREATE TABLE
	Towns(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Towns_Id PRIMARY KEY,
		Name NVARCHAR(250) NOT NULL
	)

CREATE TABLE
	Addresses(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Addresses_Id PRIMARY KEY,
		AddressText NVARCHAR(500),
		TownId INT NOT NULL
			CONSTRAINT FK_Addresses_TownId_Towns REFERENCES Towns(Id)
	)

CREATE TABLE
	Departments(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Departments_Id PRIMARY KEY,
		Name NVARCHAR(250) NOT NULL
	)

CREATE TABLE
	Employees(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Employees_Id PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		MiddleName NVARCHAR(150) NOT NULL,
		LastName NVARCHAR(150) NOT NULL,
		JobTitle NVARCHAR(150),
		DepartmentId INT NOT NULL
			CONSTRAINT FK_Employees_DepartmentId_Departments REFERENCES Departments(Id),
		HireDate DATE,
		Salary FLOAT(2),
		AddressId INT
			CONSTRAINT FK_Employees_AddressId_Addresses REFERENCES Addresses(Id)
	)