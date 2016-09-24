USE Minions
GO

-- Delete all recrods
DELETE FROM Minions
DELETE FROM Towns
GO

-- Insert new records
SET IDENTITY_INSERT Towns ON
INSERT INTO
	Towns(Id, Name)
VALUES
	(1, 'Sofia'),
	(2, 'Plovdiv'),
	(3, 'Varna')
SET IDENTITY_INSERT Towns OFF
GO

SET IDENTITY_INSERT Minions ON
INSERT INTO
	Minions(Id, Name, Age, TownId)
VALUES
	(1, 'Kevin', 22, 1),
	(2, 'Bob', 15, 3),
	(3, 'Steward', NULL, 2)
SET IDENTITY_INSERT Minions OFF
GO