USE Geography
GO

-- Drop table if exists
IF OBJECT_ID('Monasteries') IS NOT NULL
	DROP TABLE Monasteries

-- Create table
CREATE TABLE Monasteries(
	Id int NOT NULL IDENTITY,
	Name nvarchar(100) NOT NULL,
	CountryCode char(2) NOT NULL

	CONSTRAINT
		PK_Monasteries
			PRIMARY KEY CLUSTERED (Id)
)

-- Add integrity constraints
ALTER TABLE
	Monasteries
WITH CHECK
ADD
	CONSTRAINT
		FK_Monasteries_Countries
	FOREIGN KEY
		(CountryCode)
	REFERENCES
		Countries(CountryCode)
GO

-- Add values
INSERT INTO 
	Monasteries(Name, CountryCode) 
VALUES
	('Rila Monastery “St. Ivan of Rila”', 'BG'), 
	('Bachkovo Monastery “Virgin Mary”', 'BG'),
	('Troyan Monastery “Holy Mother''s Assumption”', 'BG'),
	('Kopan Monastery', 'NP'),
	('Thrangu Tashi Yangtse Monastery', 'NP'),
	('Shechen Tennyi Dargyeling Monastery', 'NP'),
	('Benchen Monastery', 'NP'),
	('Southern Shaolin Monastery', 'CN'),
	('Dabei Monastery', 'CN'),
	('Wa Sau Toi', 'CN'),
	('Lhunshigyia Monastery', 'CN'),
	('Rakya Monastery', 'CN'),
	('Monasteries of Meteora', 'GR'),
	('The Holy Monastery of Stavronikita', 'GR'),
	('Taung Kalat Monastery', 'MM'),
	('Pa-Auk Forest Monastery', 'MM'),
	('Taktsang Palphug Monastery', 'BT'),
	('Sümela Monastery', 'TR')
GO

-- Alter table
ALTER TABLE
	Countries
ADD
	IsDeleted bit NOT NULL DEFAULT(0)
GO
