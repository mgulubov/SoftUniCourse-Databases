USE Geography
GO

DECLARE @CursorCountryCode char(2)
DECLARE country_cursor CURSOR FOR
	SELECT
		c.CountryCode
	FROM
		Countries c
	WHERE
		(
			SELECT
				COUNT(cr.RiverId)
			FROM
				CountriesRivers cr
			WHERE
				cr.CountryCode = c.CountryCode
		) > 3

OPEN 
	country_cursor
FETCH NEXT FROM
	country_cursor
INTO
	@CursorCountryCode

WHILE
	@@FETCH_STATUS = 0
BEGIN
	UPDATE
		Countries
	SET
		IsDeleted = 1
	WHERE
		CountryCode = @CursorCountryCode

	FETCH NEXT FROM
		country_cursor
	INTO
		@CursorCountryCode
END

CLOSE 
	country_cursor
DEALLOCATE 
	country_cursor

