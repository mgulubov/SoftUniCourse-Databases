USE Minions
GO

-- Drop constraints if exist
ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	PK_Users_Id
GO

ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	PK_Users_Comb_Id_Password
GO

-- Create new primary key constraint
ALTER TABLE
	Users
ADD CONSTRAINT
	PK_Users_Comb_Id_Password
PRIMARY KEY
	(Id, Password)
GO