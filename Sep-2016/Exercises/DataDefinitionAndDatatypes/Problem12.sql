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

ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	AK_Users_Username
GO

ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	CH_Users_Username
GO

-- Create new constraints
ALTER TABLE
	Users
ADD CONSTRAINT
	PK_Users_Id
PRIMARY KEY
	(Id)
GO

ALTER TABLE
	Users
ADD CONSTRAINT
	AK_Users_Username
UNIQUE
	(Username)
GO

ALTER TABLE
	Users
ADD CONSTRAINT
	CH_Users_Username
CHECK
	(LEN(Username) >= 3)
GO