USE Bank
GO

-- Drop procedures if exists
IF OBJECT_ID('WithdrawMoney', 'P') IS NOT NULL
	DROP PROCEDURE WithdrawMoney
GO

-- Create procedures
CREATE PROCEDURE WithdrawMoney(
	@AccountId int,
	@WithdrawAmmount money
)
AS
	BEGIN
		UPDATE
			Accounts
		SET
			Balance = Balance - @WithdrawAmmount
		WHERE
			Id = @AccountId
	END
GO

-- Execute procedure
EXECUTE WithdrawMoney 1, 500.01
GO

-- Check SELECT statement
SELECT
	*
FROM
	Accounts
