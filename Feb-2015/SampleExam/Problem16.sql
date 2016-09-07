USE Ads
GO

-- Drop constraint if exists
ALTER TABLE 
	Towns 
DROP CONSTRAINT IF EXISTS 
	FK_Towns_Countries

-- Drop column if exists
ALTER TABLE
	Towns
DROP COLUMN IF EXISTS
	CountryId

-- Drop table if exists
DROP TABLE IF EXISTS 
	Countries

-- Delete default values
DELETE FROM
	Towns
WHERE
	Name IN (
		'Munich',
		'Frankfurt',
		'Berlin',
		'Hamburg',
		'Paris',
		'Lyon',
		'Nantes'
	)
GO
-----------------------------------
-----------------------------------
-- 1.Create a table Countries(Id, Name). Use auto-increment for the primary key. Add a new column CountryId in the Towns table to link each town to some country (non-mandatory link). Create a foreign key between the Countries and Towns tables.
CREATE TABLE 
	Countries(
		Id INT IDENTITY PRIMARY KEY,
		Name NVARCHAR(250)
	)
GO

ALTER TABLE 
	Towns
ADD
	CountryId INT
GO

ALTER TABLE
	Towns
ADD CONSTRAINT
	FK_Towns_Countries
FOREIGN KEY
	(CountryId)
REFERENCES
	Countries(Id)
GO
--------------------------------
--------------------------------
-- 2.	Execute the following SQL script (it should pass without any errors):
INSERT INTO Countries(Name) VALUES ('Bulgaria'), ('Germany'), ('France')
UPDATE Towns SET CountryId = (SELECT Id FROM Countries WHERE Name='Bulgaria')
INSERT INTO Towns VALUES
('Munich', (SELECT Id FROM Countries WHERE Name='Germany')),
('Frankfurt', (SELECT Id FROM Countries WHERE Name='Germany')),
('Berlin', (SELECT Id FROM Countries WHERE Name='Germany')),
('Hamburg', (SELECT Id FROM Countries WHERE Name='Germany')),
('Paris', (SELECT Id FROM Countries WHERE Name='France')),
('Lyon', (SELECT Id FROM Countries WHERE Name='France')),
('Nantes', (SELECT Id FROM Countries WHERE Name='France'))
GO
--------------------------------
--------------------------------
-- 3.Write and execute a SQL command that changes the town to "Paris" for all ads created at Friday.
DECLARE @ParisTownId INT = (
	SELECT
		Id
	FROM
		Towns
	WHERE
		Name = 'Paris'	
)

UPDATE
	Ads
SET
	TownId = @ParisTownId
WHERE
	DATENAME(WEEKDAY, Date) = 'Friday'
---------------------------------
---------------------------------
-- 4.Write and execute a SQL command that changes the town to "Hamburg" for all ads created at Thursday.
DECLARE @HamburgTownId INT = (
	SELECT
		Id
	FROM
		Towns
	WHERE
		Name = 'Hamburg'	
)

UPDATE
	Ads
SET
	TownId = @HamburgTownId
WHERE
	DATENAME(WEEKDAY, Date) = 'Thursday'
GO
---------------------------------
---------------------------------
-- 5. Delete all ads created by user in role "Partner".
DECLARE @PartnerStatusUserIds TABLE (
	UserId NVARCHAR(250)
)

INSERT INTO
	@PartnerStatusUserIds
SELECT
	u.Id
FROM
	AspNetUsers u
		INNER JOIN
			AspNetUserRoles ur ON
				ur.UserId = u.Id
		INNER JOIN
			AspNetRoles r ON
				r.Id = ur.RoleId
			AND
				r.Name = 'Partner'

DELETE FROM
	Ads
WHERE
	OwnerId IN (
		SELECT
			UserId
		FROM
			@PartnerStatusUserIds
	)
GO
---------------------------------
---------------------------------
-- 6.	Add a new add holding the following information: Title="Free Book", Text="Free C# Book", Date={current date and time}, Owner="nakov", Status="Waiting Approval".
DECLARE @NakovUserId NVARCHAR(250) = (
	SELECT
		Id
	FROM
		AspNetUsers
	WHERE
		UserName = 'nakov'
)

DECLARE @WaitingApprovalStatusId INT = (
	SELECT
		Id
	FROM
		AdStatuses
	WHERE
		Status = 'Waiting Approval'
)

INSERT INTO
	Ads(Title, 
		Text, 
		Date, 
		OwnerId, 
		StatusId)
VALUES
	('Free Book',
	 'Free C# Book',
	 GETDATE(),
	 @NakovUserId,
	 @WaitingApprovalStatusId)
GO
---------------------------------
---------------------------------
-- 7.Find the count of ads for each town. Display the ads count, the town name and the country name. Include also the ads without a town and country. Sort the results by town, then by country. Name the columns exactly like in the table below. Submit for evaluation the result grid with headers.
SELECT
	t.Name AS Town,
	c.Name AS Country,
	COUNT(a.Id) AS AdsCount
FROM
	Towns t
		FULL OUTER JOIN
			Countries c ON
				c.Id = t.CountryId
		FULL OUTER JOIN
			Ads a ON
				a.TownId = t.Id
GROUP BY
	t.Name,
	c.Name
ORDER BY
	t.Name,
	c.Name
---------------------------------
---------------------------------