USE Minions
GO

--Drop constraint if exists
ALTER TABLE
	Minions
DROP CONSTRAINT IF EXISTS
	FK_Minions_Towns
GO

-- Drop column if exists
ALTER TABLE
	Minions
DROP COLUMN IF EXISTS
	TownId
GO

-- Create column
ALTER TABLE
	Minions
ADD
	TownId INT NOT NULL
GO

-- Add constraint
ALTER TABLE
	Minions
ADD CONSTRAINT
	FK_Minions_Towns
FOREIGN KEY
	(TownId)
REFERENCES
	Towns(Id)
GO