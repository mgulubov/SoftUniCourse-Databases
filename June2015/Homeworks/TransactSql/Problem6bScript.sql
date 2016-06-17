USE Bank
GO

-- Drop triger if exists
IF (SELECT OBJECT_ID FROM sys.triggers WHERE name = 'TriggerLogAccountBalanceChange') IS NOT NULL
	DROP TRIGGER TriggerLogAccountBalanceChange
GO

-- Create trigger
CREATE TRIGGER
	TriggerLogAccountBalanceChange
ON
	[Accounts]
AFTER
	UPDATE
AS
BEGIN
	-- Declare variables
	DECLARE	@AccountId int
	DECLARE @OldSum money
	DECLARE @NewSum money

	-- Assign variable values
	SET @AccountId = (SELECT Id FROM inserted)
	SET @OldSum = (SELECT Balance FROM deleted)
	SET @NewSum = (SELECT Balance FROM inserted)

	-- Insert values into Logs IF Balance is different
	IF (@OldSum != @NewSum)
		INSERT INTO
			LOGS(AccountId, OldSum, NewSum)
		VALUES
			(@AccountId, @OldSum, @NewSum)
END
GO

-- Execute Update to activate trigger
UPDATE
	Accounts
SET
	Balance = 5
WHERE
	PersonId = 2

-- Select statement to check result
SELECT
	*
FROM
	Logs