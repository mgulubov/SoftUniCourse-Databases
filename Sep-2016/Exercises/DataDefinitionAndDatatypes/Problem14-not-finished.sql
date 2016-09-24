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
		DailyRate FLOAT(3) NOT NULL,
		WeeklyRate FLOAT(3) NOT NULL,

	)