USE Minions
GO

-- Drop table if exists
DROP TABLE IF EXISTS
	People
GO

-- Create table
CREATE TABLE
	People(
		Id INT NOT NULL IDENTITY PRIMARY KEY,
		Name NVARCHAR(200) NOT NULL,
		Picture VARBINARY(2000),
		Height FLOAT(2),
		Weight FLOAT(2),
		Gender CHAR(1) NOT NULL,
		Birthdate DATE NOT NULL,
		Biography NVARCHAR(MAX),

		CONSTRAINT
			CH_Gender_Values
		CHECK
			(Gender IN ('m', 'f'))
	)
GO

-- Insert records
INSERT INTO
	People(Name, Gender, Birthdate)
VALUES
	('Zori', 'f', '01/01/1987'),
	('Zori2', 'f', '01/01/1987'),
	('Zori3', 'f', '01/01/1987'),
	('Zori4', 'f', '01/01/1987'),
	('Zori5', 'f', '01/01/1987')
GO
