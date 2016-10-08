USE Bank
GO
-------------
-------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_TransferMoney
GO
-------------
-------------
-- Create procedure
CREATE PROCEDURE
	usp_TransferMoney
		@FromAccountId INT,
		@ToAccountId INT,
		@TransferAmount MONEY
AS
BEGIN

BEGIN TRY

	BEGIN TRANSACTION MainTransaction

		BEGIN
			IF @TransferAmount <= 0
				THROW 50001, 'Money amount cant be less than or equal to 0', 0
	
			IF @TransferAmount IS NULL
				THROW 50002, 'Money amount cant be NULL', 0
		END

		BEGIN
			IF NOT EXISTS(SELECT * FROM Accounts WHERE Id = @FromAccountId)
				THROW 50003, 'Invalid Account ID in FromAccountId', 0

			IF NOT EXISTS(SELECT * FROM Accounts WHERE Id = @ToAccountId)
				THROW 50004, 'Invalid Account ID in ToAccountId', 0
		END

		BEGIN
			IF (SELECT Balance FROM Accounts WHERE Id = @FromAccountId) < @TransferAmount
				THROW 50005, 'Invalid Tranasfer amount: Insufficient funds in FromAccount', 0
		END

		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION DeductMoneyTransaction
					BEGIN
						UPDATE
							Accounts
						SET
							Balance = Balance - @TransferAmount
						WHERE
							Id = @FromAccountId
					END
				COMMIT TRANSACTION DeductMoneyTransaction
			END TRY
			BEGIN CATCH
				PRINT ERROR_MESSAGE()
				ROLLBACK TRANSACTION DeductMoneyTransaction
			END CATCH
		END

		BEGIN
			BEGIN TRY
				BEGIN TRANSACTION AddMoneyTransaction
					BEGIN
						UPDATE
							Accounts
						SET
							Balance = Balance + @TransferAmount
						WHERE
							Id = @ToAccountId
					END
				COMMIT TRANSACTION AddMoneyTransaction
			END TRY
			BEGIN CATCH
				PRINT ERROR_MESSAGE()
				ROLLBACK TRANSACTION AddMoneyTransaction
			END CATCH
		END

	COMMIT TRANSACTION MainTransaction

END TRY
BEGIN CATCH
	PRINT ERROR_MESSAGE()
	ROLLBACK TRANSACTION MainTransaction
END CATCH

END
GO
-------------
-------------
-- Execute procedure
EXECUTE usp_TransferMoney
			@FromAccountId = 1,
			@ToAccountId = 2,
			@TransferAmount = 1
-------------
-------------
-- TEST
--SELECT * FROM Accounts WHERE Id = 1
--SELECT * FROM Accounts WHERE Id = 2
-------------
-------------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_TransferMoney
GO
-------------
-------------