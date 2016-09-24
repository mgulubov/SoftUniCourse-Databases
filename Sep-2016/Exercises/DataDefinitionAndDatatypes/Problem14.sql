USE master
GO

-- Drop connections
ALTER DATABASE
	CarRental
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Drop database if exists
DROP DATABASE IF EXISTS
	CarRental
GO

-- Create database
CREATE DATABASE
	CarRental
GO

USE CarRental
GO

-- Create tables
CREATE TABLE
	Categories(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Categories_Id PRIMARY KEY,
		Category NVARCHAR(250) NOT NULL,
		DailyRate FLOAT(3),
		WeeklyRate FLOAT(3),
		MonthlyRate FLOAT(3),
		WeekendRate FLOAT(3)
	)
GO

CREATE TABLE
	Cars(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Cars_Id PRIMARY KEY,
		PlateNumber NVARCHAR(100) NOT NULL,
		Make NVARCHAR(150),
		Model NVARCHAR(150),
		CarYear SMALLINT,
		CategoryId INT NOT NULL
			CONSTRAINT FK_Cars_CategoryId_Categories REFERENCES Categories(Id),
		Doors TINYINT,
		Picture VARBINARY(MAX),
		Condition NVARCHAR(250),
		Available NVARCHAR(150)
	)

CREATE TABLE
	Employees(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Employees_Id PRIMARY KEY,
		FirstName NVARCHAR(150) NOT NULL,
		LastName NVARCHAR(150) NOT NULL,
		Title NVARCHAR(150),
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	Customers(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_Customers_Id PRIMARY KEY,
		DriverLicenceNumber NVARCHAR(250) NOT NULL,
		FullName NVARCHAR(300) NOT NULL,
		Address NVARCHAR(300),
		City NVARCHAR(300),
		ZIPCode NVARCHAR(300),
		Notes NVARCHAR(MAX)
	)

CREATE TABLE
	RentalOrders(
		Id INT NOT NULL IDENTITY
			CONSTRAINT PK_RentalOrders_Id PRIMARY KEY,
		EmployeeId INT NOT NULL
			CONSTRAINT FK_RentalOrders_EmployeeId_Employees REFERENCES Employees(Id),
		CustomerId INT NOT NULL
			CONSTRAINT FK_RentalOrders_CustomerId_Customers REFERENCES Customers(Id),
		CarId INT NOT NULL
			CONSTRAINT FK_RentalOrders_CarId_Cars REFERENCES Cars(Id),
		CarCondition NVARCHAR(250),
		TankLevel NVARCHAR(100),
		KilometrageStart INT,
		KilometrageEnd INT,
		TotalKilometrage INT,
		StartDate DATETIME,
		EndDate DATETIME,
		TotalDays SMALLINT,
		RateApplied FLOAT(3),
		TaxRate FLOAT(3),
		OrderStatus NVARCHAR(300),
		Notes NVARCHAR(MAX)
	)

-- Insert values
INSERT INTO
	Categories(Category)
VALUES
	('Economy'),
	('Medium'),
	('Premium')

INSERT INTO
	Cars(PlateNumber, CategoryId)
VALUES
	('CA8080', 1),
	('CA9090', 2),
	('CB1111', 3)

INSERT INTO
	Employees(FirstName, LastName)
VALUES
	('Miroslav', 'Galabov'),
	('John', 'Doe'),
	('Jane', 'Doe')

INSERT INTO
	Customers(DriverLicenceNumber, FullName)
VALUES
	('8762537839HH', 'Miroslav Galabov'),
	('82725163839JJ', 'John Doe'),
	('2158884458PP', 'Jane Doe')

INSERT INTO
	RentalOrders(EmployeeId, CustomerId, CarId)
VALUES
	(1, 1, 1),
	(2, 2, 2),
	(3, 3, 3)