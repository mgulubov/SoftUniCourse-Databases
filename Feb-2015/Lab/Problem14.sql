USE Forum
GO

-----------------------
-----------------------
-- 1. Create a view "AllQuestions" in the database that holds information about questions and users 
-- Drop view if exist
DROP VIEW IF EXISTS
	AllQuestions
GO

CREATE VIEW
	AllQuestions
AS
SELECT
	u.Id AS UId,
	u.Username,
	u.FirstName,
	u.LastName,
	u.Email,
	u.PhoneNumber,
	q.Id AS QId,
	q.Title,
	q.Content,
	q.CategoryId,
	q.UserId,
	q.CreatedOn
FROM
	Users u
		FULL OUTER JOIN
			Questions q ON
				q.UserId = u.Id
GO

--SELECT * FROM AllQuestions
--GO
-----------------------
-----------------------
-- 2. Using the view above, create a stored function "fn_ListUsersQuestions" that returns a table, 
-- holding all users in descending order as first column, along with all titles of their questions (in ascending order), 
-- separated by ", " as second column.
-----------------------
-- Drop functions if exist
DROP FUNCTION IF EXISTS
	FN_ListUsersQuestions

DROP FUNCTION IF EXISTS
	FN_GetQuestionTitlesForUser
GO
-----------------------
-- Create functions
CREATE FUNCTION
	FN_GetQuestionTitlesForUser(
		@Username NVARCHAR(MAX),
		@TitlesSeparator NVARCHAR(10)
	)
RETURNS
	NVARCHAR(MAX)
AS
BEGIN

DECLARE @TitlesString NVARCHAR(MAX) = (
	SELECT
		(
			CASE
				WHEN aq.Title IS NULL
				THEN 'NULL'
				ELSE aq.Title + @TitlesSeparator
			END
		) AS [text()]
	FROM
		AllQuestions aq
	WHERE
		aq.Username = @Username
	ORDER BY
		aq.Title DESC
	FOR
		XML PATH('')
)

SET @TitlesString = (
	CASE
		WHEN @TitlesString = 'NULL'
		THEN 'NULL'
		ELSE SUBSTRING(@TitlesString, 0, LEN(@TitlesString))
	END
)

RETURN @TitlesString

END
GO

CREATE FUNCTION
	FN_ListUsersQuestions()
RETURNS @UsersQuestions TABLE(
	UserName NVARCHAR(MAX),
	Questions NVARCHAR(MAX)
)
AS
BEGIN

DECLARE usernames_cursor CURSOR
FOR
	SELECT
		DISTINCT(aq.Username)
	FROM
		AllQuestions aq
	ORDER BY
		aq.Username ASC

DECLARE @Username NVARCHAR(MAX)

OPEN usernames_cursor
FETCH NEXT FROM
	usernames_cursor
INTO
	@Username

WHILE @@FETCH_STATUS = 0
BEGIN
	INSERT INTO
		@UsersQuestions
	VALUES
		(
			@Username,
			dbo.FN_GetQuestionTitlesForUser(@Username, ', ')
		)

	FETCH NEXT FROM
		usernames_cursor
	INTO
		@Username
END

CLOSE usernames_cursor
DEALLOCATE usernames_cursor

RETURN

END
GO

SELECT * FROM dbo.FN_ListUsersQuestions()
GO