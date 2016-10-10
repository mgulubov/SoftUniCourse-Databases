USE Diablo
GO
-----------
-----------
-- Drop trigger if exists
DROP TRIGGER IF EXISTS
	CheckOnUserItemPurchaseTrigger
GO
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_PurchaseItemsForUser
GO
-----------
-----------
-- Create trigger
CREATE TRIGGER
	CheckOnUserItemPurchaseTrigger
ON
	UserGameItems
AFTER INSERT
AS
BEGIN

	DECLARE @UserLevel INT
	DECLARE @ItemLevel INT

	BEGIN
		SELECT
			@UserLevel = ug.Level,
			@ItemLevel = i.MinLevel
		FROM
			inserted ins
				INNER JOIN
					Items i ON
						i.Id = ins.ItemId
				INNER JOIN
					UsersGames ug ON
						ug.Id = ins.UserGameId
	END

	BEGIN
		IF @UserLevel < @ItemLevel
			ROLLBACK TRANSACTION
	END
END
GO
-----------
-----------
-- Create procedure
CREATE PROCEDURE
	usp_PurchaseItemsForUser
		@ItemMinId INT,
		@ItemMaxId INT,
		@GameName NVARCHAR(100),
		@Username NVARCHAR(100)
AS
BEGIN
	DECLARE @UserGameLevel INT
	DECLARE @UserGameId INT
	DECLARE @UserGameCash MONEY
	DECLARE @ItemsPricesMinLevel TABLE (
		ItemId INT,
		ItemPrice MONEY,
		ItemMinLevel INT
	)

	BEGIN
		SELECT
			@UserGameLevel = ug.Level,
			@UserGameId = ug.Id
		FROM
			UsersGames ug
				INNER JOIN
					Games g ON
						g.Id = ug.GameId
		WHERE
			g.Name = @GameName
	END

	BEGIN
		INSERT INTO
			@ItemsPricesMinLevel
		SELECT
			Id AS ItemId,
			Price AS ItemPrice,
			MinLevel AS ItemMinLevel
		FROM
			Items
		WHERE
			Id >= @ItemMinId
				AND
			Id <= @ItemMaxId
	END

	BEGIN
		DECLARE ItemsCursor CURSOR
		FOR
			SELECT
				*
			FROM
				@ItemsPricesMinLevel

		DECLARE @ItemId INT
		DECLARE @ItemPrice MONEY
		DECLARE @ItemMinLevel INT
	END

	BEGIN
		OPEN ItemsCursor
		FETCH NEXT FROM
			ItemsCursor
		INTO
			@ItemId,
			@ItemPrice,
			@ItemMinLevel

		WHILE @@FETCH_STATUS = 0
			BEGIN
				BEGIN
					IF @ItemMinLevel > @UserGameLevel
						BEGIN
							FETCH NEXT FROM 
								ItemsCursor
							INTO
								@ItemId,
								@ItemPrice,
								@ItemMinLevel
							CONTINUE
						END
				END

				BEGIN
					SET @UserGameCash = (
						SELECT
							ug.Cash
						FROM
							UsersGames ug
								INNER JOIN
									Games g ON
										g.Id = ug.GameId
								INNER JOIN
									Users u ON
										u.Id = ug.UserId
						WHERE
							u.Username = @Username
								AND
							g.Name = @GameName
					)
				END

				BEGIN
					IF @UserGameCash < @ItemPrice
						BEGIN
							FETCH NEXT FROM 
								ItemsCursor
							INTO
								@ItemId,
								@ItemPrice,
								@ItemMinLevel
							CONTINUE
						END
				END

				BEGIN
					INSERT INTO
						UserGameItems
					VALUES
						(@ItemId, @UserGameId)
				END

				BEGIN
					IF NOT EXISTS
						(
							SELECT 
								* 
							FROM 
								UserGameItems 
							WHERE 
								ItemId = @ItemId 
									AND 
								UserGameId = @UserGameId
						)
						BEGIN
							FETCH NEXT FROM 
								ItemsCursor
							INTO
								@ItemId,
								@ItemPrice,
								@ItemMinLevel
							CONTINUE
						END
				END

				BEGIN
					UPDATE
						UsersGames
					SET
						Cash = Cash - @ItemPrice
					WHERE
						Id = @UserGameId
				END

				BEGIN
					FETCH NEXT FROM 
						ItemsCursor
					INTO
						@ItemId,
						@ItemPrice,
						@ItemMinLevel
					CONTINUE
				END
			END
	END
END
GO
-----------
-----------
-- Add additional cash and test
BEGIN TRANSACTION TestTransaction
	BEGIN
		UPDATE
			UsersGames
		SET
			Cash = Cash + 50000
		WHERE
			Id IN (
				SELECT
					ug.Id
				FROM
					UsersGames ug
						INNER JOIN
							Games g ON
								g.Id = ug.GameId
						INNER JOIN
							Users u ON
								u.Id = ug.UserId
				WHERE
					g.Name = 'Bali'
						AND
					u.Username IN ('baleremuda', 'loosenoise', 'inguinalself', 'buildingdeltoid')
			)
	END

	BEGIN
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=251, @ItemMaxId=299, @GameName='Bali', @Username='baleremuda' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=251, @ItemMaxId=299, @GameName='Bali', @Username='loosenoise' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=251, @ItemMaxId=299, @GameName='Bali', @Username='inguinalself' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=251, @ItemMaxId=299, @GameName='Bali', @Username='buildingdeltoid' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=251, @ItemMaxId=299, @GameName='Bali', @Username='monoxidecos' 
	END

	BEGIN
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=501, @ItemMaxId=539, @GameName='Bali', @Username='baleremuda' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=501, @ItemMaxId=539, @GameName='Bali', @Username='loosenoise' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=501, @ItemMaxId=539, @GameName='Bali', @Username='inguinalself' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=501, @ItemMaxId=539, @GameName='Bali', @Username='buildingdeltoid' 
		EXECUTE usp_PurchaseItemsForUser @ItemMinId=501, @ItemMaxId=539, @GameName='Bali', @Username='monoxidecos' 
	END
		
	SELECT
		u.Username,
		g.Name,
		ug.Cash,
		i.Name
	FROM
		UsersGames ug
			INNER JOIN
				Users u ON
					u.Id = ug.UserId
			INNER JOIN
				Games g ON
					g.Id = ug.GameId
			INNER JOIN
				UserGameItems ugi ON
					ugi.UserGameId = g.Id
			INNER JOIN
				Items i ON
					i.Id = ugi.ItemId
	WHERE
		g.Name = 'Bali'

ROLLBACK TRANSACTION TestTransaction
-----------
-----------
-- Drop trigger if exists
DROP TRIGGER IF EXISTS
	CheckOnUserItemPurchaseTrigger
GO
-----------
-----------
-- Drop procedure if exists
DROP PROCEDURE IF EXISTS
	usp_PurchaseItemsForUser
GO