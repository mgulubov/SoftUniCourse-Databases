USE Geography
GO

----------------------
----------------------
-- Drop tables
DROP TABLE IF EXISTS
	Monasteries

-- Drop constraints
ALTER TABLE
	Countries
DROP CONSTRAINT IF EXISTS
	DF_Countries_IsDeleted

-- Drop columns
ALTER TABLE
	Countries
DROP COLUMN IF EXISTS
	IsDeleted
GO
----------------------
----------------------
-- 1. Create a table Monasteries(Id, Name, CountryCode). Use auto-increment for the primary key. 
-- Create a foreign key between the tables Monasteries and Countries.
CREATE TABLE Monasteries(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(250) NOT NULL,
	CountryCode CHAR(2)

	CONSTRAINT
		FN_Monasteries_Countries
	FOREIGN KEY
		(CountryCode)
	REFERENCES
		Countries(CountryCode)
)
GO
----------------------
----------------------
-- 2. Execute the following SQL script (it should pass without any errors):
INSERT INTO Monasteries(Name, CountryCode) VALUES
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
----------------------
----------------------
-- 3. Write a SQL command to add a new Boolean column IsDeleted in the Countries table (defaults to false). 
-- Note that there is no "Boolean" type in SQL server, so you should use an alternative.
----------------------
-- Add new column
ALTER TABLE
	Countries
ADD
	IsDeleted TINYINT
GO
----------------------
-- Add default value constraint
ALTER TABLE
	Countries
ADD CONSTRAINT
	DF_Countries_IsDeleted
DEFAULT 0 FOR IsDeleted
GO
----------------------
-- Set all values for new column to default
UPDATE
	Countries
SET
	IsDeleted = 0
GO
----------------------
-- Make IsDeleted NOT NULL
ALTER TABLE
	Countries
ALTER COLUMN
	IsDeleted TINYINT NOT NULL
GO
----------------------
----------------------
-- 4. Write and execute a SQL command to mark as deleted all countries that have more than 3 rivers.
----------------------
-- Declare Table variable
DECLARE @CountriesWithMoreThanThreeRivers TABLE(
	CountryCode CHAR(2)
)
----------------------
-- Insert values into Table variable
INSERT INTO
	@CountriesWithMoreThanThreeRivers
SELECT
	c.CountryCode
FROM
	Countries c
		INNER JOIN
			CountriesRivers cr ON
				cr.CountryCode = c.CountryCode
GROUP BY
	c.CountryCode
HAVING
	COUNT(cr.RiverId) > 3
----------------------
-- Update Countries table
UPDATE
	Countries
SET
	IsDeleted = 1
WHERE
	CountryCode IN (
		SELECT
			CountryCode
		FROM
			@CountriesWithMoreThanThreeRivers
	)
GO
----------------------
----------------------
-- 5. Write a query to display all monasteries along with their countries sorted by monastery name. 
-- Skip all deleted countries and their monasteries. Submit for evaluation the result grid with headers.
SELECT
	m.Name AS Monastery,
	c.CountryName AS Country
FROM
	Monasteries m
		INNER JOIN
			Countries c ON
				c.CountryCode = m.CountryCode
				AND
				c.IsDeleted != 1
ORDER BY
	m.Name ASC
GO


