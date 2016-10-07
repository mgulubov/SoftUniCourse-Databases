USE SoftUni
GO
-----------
-----------
-- Drop function if exists
DROP FUNCTION IF EXISTS
	ufn_IsWordComprised
GO
-----------
-----------
-- Create function
CREATE FUNCTION
	ufn_IsWordComprised(
		@setOfLetters NVARCHAR(MAX),
		@word NVARCHAR(MAX)
	)
RETURNS CHAR(1)
AS
BEGIN

DECLARE @WordChars TABLE(
	WordChar CHAR(1)
)
DECLARE @LettersChars TABLE(
	LetterChar CHAR(1)
)

INSERT INTO
	@WordChars
SELECT
	SUBSTRING(Word.Word, vals.number + 1, 1) AS WordChar
FROM
	(SELECT @word Word) AS Word
		INNER JOIN
			master..spt_values vals ON 
				vals.number < LEN(Word.Word)
WHERE
	vals.type = 'P'

INSERT INTO
	@LettersChars
SELECT
	SUBSTRING(Word.Word, vals.number + 1, 1) AS LetterChar
FROM
	(SELECT @setOfLetters Word) AS Word
		INNER JOIN
			master..spt_values vals ON
				vals.number < LEN(Word.Word)
WHERE
	vals.type = 'P'

DECLARE @CompTable TABLE(
	WordChar CHAR(1),
	LetterChar CHAR(1)
)

INSERT INTO
	@CompTable
SELECT
	wc.WordChar,
	lc.LetterChar
FROM
	@WordChars wc
		LEFT JOIN
			@LettersChars lc ON
				LOWER(lc.LetterChar) = LOWER(wc.WordChar)

RETURN (
	SELECT
		(
			CASE
				WHEN COUNT(*) > 0
				THEN '0'
				ELSE '1'
			END
		)
	FROM
		@CompTable ct
	WHERE
		ct.LetterChar IS NULL
)

END
GO
-----------
-----------
-- Execute function
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'Sofia')
SELECT dbo.ufn_IsWordComprised('oistmiahf', 'halves')
SELECT dbo.ufn_IsWordComprised('bobr', 'Rob')
SELECT dbo.ufn_IsWordComprised('pppp', 'Guy')