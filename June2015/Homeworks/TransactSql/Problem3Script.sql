USE Bank
GO

-- Drop procedure if exists
IF OBJECT_ID('CalcSumWithInterestRate', 'P') IS NOT NULL
	DROP PROCEDURE CalcSumWithInterestRate
GO

-- Create procedure
CREATE PROCEDURE CalcSumWithInterestRate(
	@Sum money,
	@InterestRate money,
	@NumberOfMonths int,
	@CalculatedSum money OUTPUT
)
AS
	BEGIN
		SELECT
			@CalculatedSum = @Sum * @InterestRate * @NumberOfMonths
		RETURN
	END
GO

-- Declare variables
DECLARE @CalculatedSumResult money
DECLARE @SumParam money
DECLARE @InterestRateParam money
DECLARE @NumberOfMonthsParam int

-- Assign variable values
SELECT
	@SumParam = (
		SELECT
			a.Balance
		FROM
			Accounts a
				INNER JOIN
					Persons p
				ON
					a.PersonId = p.Id
		WHERE
			p.Id = 1
	),
	@InterestRateParam = 0.005,
	@NumberOfMonthsParam = 3

-- Execute stored procedure
EXECUTE 
	CalcSumWithInterestRate 
		@SumParam, 
		@InterestRateParam, 
		@NumberOfMonthsParam, 
		@CalculatedSumResult OUTPUT

-- Select stored procedure result
SELECT @CalculatedSumResult