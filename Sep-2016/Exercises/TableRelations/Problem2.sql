USE TableRelationsTestDatabase
GO
------------------
------------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	Models
------------------
DROP TABLE IF EXISTS
	Manufacturers
------------------
------------------
-- Create tables
CREATE TABLE
	Manufacturers(
		ManufacturerID INT NOT NULL
			CONSTRAINT PK_Manufacturers_ManufacturerID PRIMARY KEY,
		Name NVARCHAR(150) NOT NULL,
		EstablishedOn DATE NOT NULL
	)
------------------
CREATE TABLE
	Models(
		ModelID INT NOT NULL
			CONSTRAINT PK_Models_ModelID PRIMARY KEY,
		Name NVARCHAR(150) NOT NULL,
		ManufacturerID INT NOT NULL
			CONSTRAINT FK_Models_ManufacturerID_Manufacturers_ManufacturerID REFERENCES Manufacturers(ManufacturerID)
	)
------------------
------------------
-- Insert values
INSERT INTO
	Manufacturers
VALUES
	(1, 'BMW', CONVERT(DATE, '07/03/1916', 103)),
	(2, 'Tesla', CONVERT(DATE, '01/01/2003', 103)),
	(3, 'Lada', CONVERT(DATE, '01/05/1966', 103))
------------------
INSERT INTO
	Models
VALUES
	(101, 'X1',	1),
	(102, 'i6',	1),
	(103, 'Model S', 2),
	(104, 'Model X', 2),
	(105, 'Model 3', 2),
	(106, 'Nova', 3)
------------------
------------------
select * from Models
select * from Manufacturers