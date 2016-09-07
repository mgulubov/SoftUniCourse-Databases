USE Ads
GO

-- Drop views if exist
DROP VIEW IF EXISTS
	AllAds
GO

-- Drop functions if exist
DROP FUNCTION IF EXISTS
	FN_ListUsersAds
GO

DROP FUNCTION IF EXISTS
	FN_GetDatesForUserNameAsXML
GO

-- Create a view "AllAds" in the database that holds information about ads: id, title, author (username), date, town name, category name and status, sorted by id. 
CREATE VIEW
	AllAds
AS
SELECT
	a.Id,
	a.Title,
	u.UserName AS Author,
	a.Date,
	t.Name AS Town,
	c.Name AS Category,
	s.Status
FROM
	Ads a
		RIGHT JOIN
			AspNetUsers u ON
				u.Id = a.OwnerId
		LEFT JOIN
			Towns t ON
				t.Id = a.TownId
		LEFT JOIN
			Categories c ON
				c.Id = a.CategoryId
		LEFT JOIN
			AdStatuses s ON
				s.Id = a.StatusId
GO
--------------------------------------
--------------------------------------
-- 1.Using the view above, create a stored function "fn_ListUsersAds" that returns a table, holding all users in descending order as first column, along with all dates of their ads (in ascending order) in format "yyyyMMdd", separated by "; " as second column.
CREATE FUNCTION
	FN_GetDatesForUserNameAsXML(
	@UserName NVARCHAR(MAX)
)
RETURNS NVARCHAR(MAX)
AS
BEGIN

DECLARE @DatesXML NVARCHAR(250) = (
	SELECT
		(
			CASE
				WHEN aa.Date IS NULL
				THEN 'NULL'
				ELSE FORMAT(aa.Date, 'yyyyMMdd') + '; '
			END
		) AS [text()]
	FROM
		AllAds aa
	WHERE
		aa.Author = @UserName
	ORDER BY
		aa.Date ASC
	FOR
		XML PATH('')
)

SET @DatesXML = (
	CASE 
		WHEN @DatesXML = 'NULL'
		THEN @DatesXML
		ELSE SUBSTRING(@DatesXML, 0, LEN(@DatesXML))
	END
)

RETURN @DatesXML

END
GO

CREATE FUNCTION
	FN_ListUsersAds()
RETURNS @ResultTable TABLE(
	UserName NVARCHAR(MAX),
	AdDates NVARCHAR(MAX)
)
AS
BEGIN

DECLARE authors_usernames_cursor CURSOR
FOR
	SELECT
		DISTINCT(aa.Author)
	FROM
		AllAds aa
	ORDER BY
		aa.Author DESC

DECLARE @AuthorUserName NVARCHAR(MAX)

OPEN 
	authors_usernames_cursor

FETCH NEXT FROM 
	authors_usernames_cursor
INTO
	@AuthorUserName

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO
		@ResultTable
	VALUES(
		@AuthorUserName,
		dbo.FN_GetDatesForUserNameAsXML(@AuthorUserName)
	)
	
	FETCH NEXT FROM
		authors_usernames_cursor
	INTO
		@AuthorUserName
END

CLOSE authors_usernames_cursor
DEALLOCATE authors_usernames_cursor

RETURN

END
GO
------------------------------
------------------------------
SELECT * FROM AllAds
SELECT * FROM dbo.FN_ListUsersAds()