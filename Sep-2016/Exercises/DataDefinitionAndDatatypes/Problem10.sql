USE Minions
GO

-- Drop constraint if exists
ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	CH_Users_Password
GO

-- Ensure passwords are longer than 5 chars
UPDATE
	Users
SET
	Password = 'default'
WHERE
	LEN(Password) < 5
GO

-- Add constraint
ALTER TABLE
	Users
ADD CONSTRAINT
	CH_Users_Password
CHECK
	(LEN(Password) >= 5)
GO
