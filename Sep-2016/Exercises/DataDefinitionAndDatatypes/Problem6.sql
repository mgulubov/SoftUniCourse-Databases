USE master

-- Drop existing connections
ALTER DATABASE 
	[Minions] 
SET 
	SINGLE_USER 
WITH ROLLBACK 
	IMMEDIATE
GO

-- Delete database if exists
DROP DATABASE IF EXISTS
	Minions
GO

-- Create database
CREATE DATABASE
	Minions
GO