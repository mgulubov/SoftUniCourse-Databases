USE Bank
GO
-------------
-------------
-- Drop trigger if exists
DROP TRIGGER IF EXISTS
	LogAccountBalanceChangeTrigger
GO
-------------
-------------
-- Drop table if exists
DROP TABLE IF EXISTS
	Logs
GO
-------------
-------------
-- Create table
CREATE TABLE
	Logs(
		LogId INT IDENTITY NOT NULL
			CONSTRAINT PK_Logs_LogId PRIMARY KEY,
		AccountId INT NOT NULL
			CONSTRAINT FK_Logs_AccountId_Accounts_Id FOREIGN KEY REFERENCES Accounts(Id),
		OldSum MONEY NOT NULL,
		NewSum MONEY NOT NULL
	)
GO
-------------
-------------
-- Create trigger
CREATE TRIGGER
	LogAccountBalanceChangeTrigger
ON
	Accounts
AFTER UPDATE
AS
BEGIN

	IF UPDATE(Balance)
		BEGIN
			DECLARE @AccountId INT
			DECLARE @NewSum MONEY
			DECLARE @OldSum MONEY

			SELECT
				@AccountId = ins.Id,
				@NewSum = ins.Balance,
				@OldSum = del.Balance
			FROM
				INSERTED ins,
				DELETED del

			INSERT INTO
				Logs
			VALUES
				(@AccountId, @OldSum, @NewSum)
		END
END
GO
-------------
-------------
-- TEST
BEGIN TRANSACTION TestTransaction

SELECT * FROM Logs
UPDATE Accounts SET Balance = 0.1 WHERE Id = 1
UPDATE Accounts SET AccountHolderId = 2 WHERE Id = 1
SELECT * FROM Logs

ROLLBACK TRANSACTION TestTransaction
-------------
-------------
-- Drop trigger if exists
DROP TRIGGER IF EXISTS
	LogAccountBalanceChangeTrigger
GO
-------------
-------------
-- Drop table if exists
DROP TABLE IF EXISTS
	Logs
GO
-------------
-------------