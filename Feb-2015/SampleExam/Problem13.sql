USE Ads
GO

SELECT
	u.UserName,
	COUNT(a.Id) AS AdsCount,
	(
		CASE
			WHEN Admins.UserName IS NULL
			THEN 'no'
			ELSE 'yes'
		END
	) AS IsAdministrator
FROM
	AspNetUsers u
		LEFT JOIN
			Ads a ON
				a.OwnerId = u.Id
		LEFT JOIN
		(
			SELECT
				DISTINCT(u.UserName)
			FROM
				AspNetUsers u
					LEFT JOIN
						AspNetUserRoles ur ON
							ur.UserId = u.Id
					LEFT JOIN
						AspNetRoles r ON
							r.Id = ur.RoleId
			WHERE
				r.Name = 'Administrator'
		) AS Admins ON
			Admins.UserName = u.UserName
GROUP BY
	u.UserName, 
	Admins.UserName
ORDER BY
	u.UserName ASC
		