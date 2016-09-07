USE Forum
GO

-- Drop constraints if exist
ALTER TABLE
	Users
DROP CONSTRAINT IF EXISTS
	FN_Users_Towns
GO

-- Drop Column if exists
ALTER TABLE
	Users
DROP COLUMN IF EXISTS
	TownId
GO

-- Drop table if exists
DROP TABLE IF EXISTS
	Towns
GO
--------------------------------
--------------------------------
-- 1. Create a table Towns(Id, Name). Use auto-increment for the primary key. 
-- Add a new column TownId in the Users table to link each user to some town (non-mandatory link). 
-- Create a foreign key between the Users and Towns tables.
CREATE TABLE Towns(
	Id INT IDENTITY PRIMARY KEY,
	Name NVARCHAR(250) NOT NULL
)
GO

ALTER TABLE
	Users
ADD
	TownId INT
GO

ALTER TABLE
	Users
ADD CONSTRAINT
	FN_Users_Towns
FOREIGN KEY 
	(TownId)
REFERENCES
	Towns(Id)
GO
--------------------------------
--------------------------------
-- 2. Execute the following SQL script (it should pass without any errors):
INSERT INTO 
	Towns(Name) 
VALUES 
	('Sofia'), ('Berlin'), ('Lyon')

UPDATE 
	Users 
SET 
	TownId = (
				SELECT 
					Id 
				FROM 
					Towns 
				WHERE 
					Name='Sofia'
			)

INSERT INTO 
	Towns 
VALUES
	('Munich'), ('Frankfurt'), ('Varna'), ('Hamburg'), ('Paris'), ('Lom'), ('Nantes')
GO
--------------------------------
--------------------------------
-- 3. Write and execute a SQL command that changes the town to "Paris" for all users with registration date at Friday.
DECLARE @ParisTownId INT = (
	SELECT
		t.Id
	FROM
		Towns t
	WHERE
		t.Name = 'Paris'
)

UPDATE
	Users
SET
	TownId = @ParisTownId
WHERE
	DATEPART(WEEKDAY, RegistrationDate) = 6
GO
--------------------------------
--------------------------------
-- 4. Write and execute a SQL command that changes the question to “Java += operator” of Answers, answered at Monday or Sunday in February.
DECLARE @TargetQuestionId INT = (
	SELECT
		q.Id
	FROM
		Questions q
	WHERE
		q.Title = 'Java += operator'
)

UPDATE
	Answers
SET
	QuestionId = @TargetQuestionId
WHERE
	DATEPART(WEEKDAY, CreatedOn) IN (1, 2)
	AND
	MONTH(CreatedOn) = 2
GO
--------------------------------
--------------------------------
-- 5. Delete all answers with negative sum of votes.
DECLARE @IdsOfAnswersWithNegativeVote TABLE(
	AnswerId INT
)

INSERT INTO
	@IdsOfAnswersWithNegativeVote
SELECT
	a.Id AS AnswerId
FROM
	Answers a
		INNER JOIN
			Votes v ON
				v.AnswerId = a.Id
	GROUP BY
		a.Id
	HAVING
		SUM(v.Value) < 0

DELETE FROM
	Votes
WHERE
	AnswerId IN (
		SELECT
			AnswerId
		FROM
			@IdsOfAnswersWithNegativeVote
	)

DELETE FROM
	Answers
WHERE
	Id IN (
		SELECT
			AnswerId
		FROM
			@IdsOfAnswersWithNegativeVote
	)
GO
--------------------------------
--------------------------------
-- 6. Add a new question holding the following information: 
-- Title="Fetch NULL values in PDO query", 
-- Content="When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?", 
-- CreatedOn={current date and time}, 
-- Owner="darkcat", 
-- Category="Databases".
DECLARE @DarkCatUserId INT = (
	SELECT
		u.Id
	FROM
		Users u
	WHERE
		u.Username = 'darkcat'
)

DECLARE @DatabasesCategoryId INT = (
	SELECT
		c.Id
	FROM
		Categories c
	WHERE
		c.Name = 'Databases'
)

INSERT INTO
	Questions(
		Title,
		Content,
		CreatedOn,
		UserId,
		CategoryId
	)
VALUES
	(
		'Fetch NULL values in PDO query',
		'When I run the snippet, NULL values are converted to empty strings. How can fetch NULL values?',
		GETDATE(),
		@DarkCatUserId,
		@DatabasesCategoryId
	)
GO
--------------------------------
--------------------------------
-- 7. Find the count of the answers for the users from town. Display the town name, username and answers count. 
-- Sort the results by answers count in descending order, then by username. Name the columns exactly like in the table below. 
SELECT
	t.Name AS Town,
	u.Username,
	COUNT(a.Id) AS AnswersCount
FROM
	Towns t
		LEFT JOIN
			Users u ON
				u.TownId = t.Id
		LEFT JOIN
			Answers a ON
				a.UserId = u.Id
GROUP BY
	t.Name,
	u.Username
ORDER BY
	COUNT(a.Id) DESC,
	u.Username
--------------------------------
--------------------------------