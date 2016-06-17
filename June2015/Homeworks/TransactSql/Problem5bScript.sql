USE Bank
GO

-- Drop procedure if exists
IF OBJECT_ID('DepositMoney', 'P') IS NOT NULL
	DROP PROCEDURE DepositMoney
GO

-- Create procedure
CREATE PROCEDURE DepositMoney(
	@AccountId int,
	@DepositAmmount money
)
AS
	BEGIN
		UPDATE
			Accounts
		SET
			Balance = Balance + @DepositAmmount
		WHERE
			Id = @AccountId
	END
GO

-- Execute procedure
EXECUTE DepositMoney 1, 500
GO

-- Check SELECT statement
SELECT
	*
FROM
	Accounts