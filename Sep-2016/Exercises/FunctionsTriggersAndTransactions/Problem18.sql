USE Diablo
GO
-----------
-----------
-- Drop function if exists
DROP FUNCTION IF EXISTS
	fn_CashInUsersGames
GO
-----------
-----------
-- Create function
CREATE FUNCTION
	ufn_CashInUsersGames(
		@GameName NVARCHAR(250)
	)
RETURNS @Result TABLE(
	CashSum MONEY
)
AS
BEGIN

	DECLARE @GamesWithRowNums TABLE(
		Cash MONEY,
		RowNum INT
	)
	INSERT INTO
		@GamesWithRowNums
	SELECT
		ug.Cash,
		ROW_NUMBER() OVER(ORDER BY ug.Cash DESC) AS RowNum 
	FROM
		UsersGames ug
			INNER JOIN
				Games g ON
					g.Id = ug.GameId
	WHERE
		g.Name = @GameName

	INSERT INTO
		@Result
	SELECT
		SUM(grn.Cash)
	FROM
		@GamesWithRowNums grn
	WHERE
		grn.RowNum % 2 = 1

	RETURN

END
GO

SELECT * from dbo.ufn_CashInUsersGames('Love in a mist')