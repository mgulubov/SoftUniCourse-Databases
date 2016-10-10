USE Bank
GO
-------------
-------------
-- Drop triggers if exist
DROP TRIGGER IF EXISTS
	AddEmailOnAccountBalanceLog

DROP TRIGGER IF EXISTS
	LogAccountBalanceChangeTrigger

GO
-------------
-------------
-- Drop table if exists
DROP TABLE IF EXISTS
	NotificationEmails

DROP TABLE IF EXISTS
	Logs

GO
-------------
-------------
-- Create tables
CREATE TABLE
	Logs(
		LogId INT IDENTITY NOT NULL
			CONSTRAINT PK_Logs_LogId PRIMARY KEY,
		AccountId INT NOT NULL
			CONSTRAINT FK_Logs_AccountId_Accounts_Id FOREIGN KEY REFERENCES Accounts(Id),
		OldSum MONEY NOT NULL,
		NewSum MONEY NOT NULL
	)

CREATE TABLE
	NotificationEmails(
		Id INT IDENTITY NOT NULL
			CONSTRAINT PK_NotificationEmails_Id PRIMARY KEY,
		Recipient INT NOT NULL
			CONSTRAINT FK_NotificationEmails_Recepient_Accounts_Id FOREIGN KEY REFERENCES Accounts(Id),
		Subject NVARCHAR(500),
		Body NVARCHAR(MAX)
	)
GO
-------------
-------------
-- Create triggers
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

CREATE TRIGGER
	AddEmailOnAccountBalanceLog
ON
	Logs
AFTER INSERT
AS
BEGIN

	DECLARE @RecepientId INT
	DECLARE @Curdate DATETIME
	DECLARE @OldSum MONEY
	DECLARE @NewSum MONEY

	DECLARE @Subject NVARCHAR(150)
	DECLARE @Body NVARCHAR(MAX)

	BEGIN
		SELECT
			@RecepientId = ins.AccountId,
			@Curdate = GETDATE(),
			@OldSum = ins.OldSum,
			@NewSum = ins.NewSum
		FROM
			INSERTED ins
	END

	BEGIN
		SET @Subject = (
			SELECT
				CONCAT('Balance change for account: ', @RecepientId)
		)

		SET @Body = (
			SELECT
				CONCAT(
						'On ', 
						CONVERT(NVARCHAR, @Curdate, 100),
						' your balance was changed from ',
						@OldSum,
						' to ',
						@NewSum, '.')
		)
	END

	BEGIN
		INSERT INTO
			NotificationEmails
		VALUES
			(
				@RecepientId, 
				@Subject,
				@Body
			)
	END
END
GO
-------------
-------------
-- TEST
BEGIN TRANSACTION TestTransaction

SELECT * FROM NotificationEmails
UPDATE Accounts SET Balance = 0.1 WHERE Id = 1
UPDATE Accounts SET AccountHolderId = 2 WHERE Id = 1
SELECT * FROM NotificationEmails

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