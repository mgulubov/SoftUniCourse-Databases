USE Minions
GO

-- Drop constraint if exists
ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	DF_Users_LastLoginTime
GO

-- Add constraint
ALTER TABLE
	Users
ADD CONSTRAINT
	DF_Users_LastLoginTime
DEFAULT
	GETDATE()
FOR
	LastLoginTime
GO