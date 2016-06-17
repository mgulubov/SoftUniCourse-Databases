USE Bank
GO

-- Drop procedure if it exists
IF OBJECT_ID('AdjustAccountBalanceOfPerson', 'P') IS NOT NULL
	DROP PROCEDURE AdjustAccountBalanceOfPerson
GO

-- Create procedure
CREATE PROCEDURE AdjustAccountBalanceOfPerson(
	@AccountId int,
	@InterestRateParam money
)
AS
BEGIN
	-- Declare variables
	DECLARE @CurrentBalance money
	DECLARE @NumberOfMonthsParam int
	DECLARE @InterestRateResult money
	DECLARE @NewBalance money
	-- Assign variable values
	SET
		@CurrentBalance = (
			SELECT
				a.Balance
			FROM
				Accounts a
			WHERE
				a.Id = @AccountId
		)
	SET
		@NumberOfMonthsParam = 1

	EXECUTE CalcSumWithInterestRate
				@CurrentBalance,
				@InterestRateParam,
				@NumberOfMonthsParam,
				@InterestRateResult OUTPUT

	-- Calc new balance
	SET
		@NewBalance = (@CurrentBalance + @InterestRateResult)

	-- Insert new balance
	UPDATE
		Accounts
	SET
		Balance = @NewBalance
	WHERE
		Id = @AccountId
END
GO

-- Call stored procedure
EXECUTE AdjustAccountBalanceOfPerson 1, 0.5
GO

-- Check result
SELECT * FROM Accounts
GO

		