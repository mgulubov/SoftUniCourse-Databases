-- Create the database "Football" if it does not exist
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'Football')
  CREATE DATABASE Football
	COLLATE SQL_Latin1_General_CP1_CI_AS
GO

USE Football
GO


---- Drop all existing Football tables, so that we can create them from scratch
IF OBJECT_ID('Leagues_Teams') IS NOT NULL
  DROP TABLE Leagues_Teams
IF OBJECT_ID('TeamMatches') IS NOT NULL
  DROP TABLE TeamMatches
IF OBJECT_ID('InternationalMatches') IS NOT NULL
  DROP TABLE InternationalMatches
IF OBJECT_ID('Teams') IS NOT NULL
  DROP TABLE Teams
IF OBJECT_ID('Leagues') IS NOT NULL
  DROP TABLE Leagues
IF OBJECT_ID('Countries') IS NOT NULL
  DROP TABLE Countries


-- Create tables
CREATE TABLE Countries(
	CountryCode char(2) NOT NULL,
	CountryName nvarchar(50) NOT NULL,
	CurrencyCode varchar(50) NULL,
	Population int NULL,
	AreaSqKm int NULL,
	Capital nvarchar(50) NULL,
 CONSTRAINT PK_Countries PRIMARY KEY (CountryCode))
GO

CREATE TABLE Leagues(
	Id int IDENTITY NOT NULL,
	LeagueName nvarchar(50) NOT NULL,
	CountryCode char(2) NULL,
 CONSTRAINT PK_Leagues PRIMARY KEY (Id))
GO

CREATE TABLE Teams(
	Id int IDENTITY NOT NULL,
	TeamName nvarchar(50) NOT NULL,
	CountryCode char(2) NULL,
 CONSTRAINT PK_Teams PRIMARY KEY (Id))
GO

CREATE TABLE Leagues_Teams(
	LeagueId int NOT NULL,
	TeamId int NOT NULL,
 CONSTRAINT PK_Leagues_Teams PRIMARY KEY (LeagueId,	TeamId))
GO

CREATE TABLE InternationalMatches(
	Id int IDENTITY NOT NULL,
	HomeCountryCode char(2) NOT NULL,
	AwayCountryCode char(2) NOT NULL,
	HomeGoals int NULL,
	AwayGoals int NULL,
	MatchDate datetime NULL,
	LeagueId int NULL,
 CONSTRAINT PK_InternationalMatches PRIMARY KEY (Id))
GO

CREATE TABLE TeamMatches(
	Id int IDENTITY NOT NULL,
	HomeTeamId int NOT NULL,
	AwayTeamId int NOT NULL,
	HomeGoals int NULL,
	AwayGoals int NULL,
	MatchDate datetime NULL,
	LeagueId int NULL,
 CONSTRAINT PK_TeamMatches PRIMARY KEY (Id))
GO


-- Add integrity constraints
ALTER TABLE Leagues WITH CHECK ADD CONSTRAINT
FK_Leagues_Countries FOREIGN KEY(CountryCode)
REFERENCES Countries (CountryCode)
GO

ALTER TABLE Leagues_Teams WITH CHECK ADD CONSTRAINT 
FK_Leagues_Teams_Leagues FOREIGN KEY(LeagueId)
REFERENCES Leagues (Id)
GO

ALTER TABLE Leagues_Teams WITH CHECK ADD CONSTRAINT
FK_Leagues_Teams_Teams FOREIGN KEY(TeamId)
REFERENCES Teams (Id)
GO

ALTER TABLE Teams WITH CHECK ADD CONSTRAINT
FK_Teams_Countries FOREIGN KEY(CountryCode)
REFERENCES Countries (CountryCode)
GO

ALTER TABLE InternationalMatches WITH CHECK ADD CONSTRAINT
FK_InternationalMatches_Countries_HomeCountryCode FOREIGN KEY(HomeCountryCode)
REFERENCES Countries (CountryCode)
GO

ALTER TABLE InternationalMatches WITH CHECK ADD CONSTRAINT
FK_InternationalMatches_Countries_AwayCountryCode FOREIGN KEY(AwayCountryCode)
REFERENCES Countries (CountryCode)
GO

ALTER TABLE TeamMatches WITH CHECK ADD CONSTRAINT
FK_TeamMatches_Teams_HomeTeam FOREIGN KEY(HomeTeamId)
REFERENCES Teams (Id)
GO

ALTER TABLE TeamMatches WITH CHECK ADD CONSTRAINT
FK_TeamMatches_Teams_AwayTeam FOREIGN KEY(AwayTeamId)
REFERENCES Teams (Id)
GO

ALTER TABLE TeamMatches WITH CHECK ADD CONSTRAINT 
FK_TeamMatches_Leagues FOREIGN KEY(LeagueId)
REFERENCES Leagues (Id)
GO

ALTER TABLE InternationalMatches WITH CHECK ADD CONSTRAINT
FK_InternationalMatches_Leagues FOREIGN KEY(LeagueId)
REFERENCES Leagues (Id)
GO


-- Add unique key constraints
CREATE UNIQUE NONCLUSTERED INDEX UK_Country_CountryName ON Countries (CountryName)
GO

CREATE UNIQUE NONCLUSTERED INDEX UK_Leagues_LeagueName ON Leagues (LeagueName)
GO

CREATE NONCLUSTERED INDEX UK_Teams_Name_Country ON Teams (TeamName, CountryCode)
GO


-- Insert the Countries
INSERT Countries (CountryCode, CountryName, CurrencyCode, Population, AreaSqKm, Capital) VALUES (N'AD', N'Andorra', N'EUR', 84000, 468, N'Andorra la Vella'),
 (N'SD', N'Sudan', N'SDG', 35000000, 1861484, N'Khartoum'),
 (N'MX', N'Mexico', N'MXN', 112468855, 1972550, N'Mexico City'),
 (N'PW', N'Palau', N'USD', 19907, 458, N'Melekeok - Palau State Capital'),
 (N'PT', N'Portugal', N'EUR', 10676000, 92391, N'Lisbon'),
 (N'JM', N'Jamaica', N'JMD', 2847232, 10991, N'Kingston'),
 (N'KI', N'Kiribati', N'AUD', 92533, 811, N'Tarawa'),
 (N'NR', N'Nauru', N'AUD', 10065, 21, N''),
 (N'RO', N'Romania', N'RON', 21959278, 237500, N'Bucharest'),
 (N'SM', N'San Marino', N'EUR', 31477, 61, N'San Marino'),
 (N'MT', N'Malta', N'EUR', 403000, 316, N'Valletta'),
 (N'KZ', N'Kazakhstan', N'KZT', 15340000, 2717300, N'Astana'),
 (N'BV', N'Bouvet Island', N'NOK', 0, 49, N''),
 (N'TL', N'East Timor', N'USD', 1154625, 15007, N'Dili'),
 (N'VG', N'British Virgin Islands', N'USD', 21730, 153, N'Road Town'),
 (N'TG', N'Togo', N'XOF', 6587239, 56785, N'Lomé'),
 (N'GM', N'Gambia', N'GMD', 1593256, 11300, N'Banjul'),
 (N'SI', N'Slovenia', N'EUR', 2007000, 20273, N'Ljubljana'),
 (N'LU', N'Luxembourg', N'EUR', 497538, 2586, N'Luxembourg'),
 (N'GH', N'Ghana', N'GHS', 24339838, 239460, N'Accra'),
 (N'IQ', N'Iraq', N'IQD', 29671605, 437072, N'Baghdad'),
 (N'PH', N'Philippines', N'PHP', 99900177, 300000, N'Manila'),
 (N'MU', N'Mauritius', N'MUR', 1294104, 2040, N'Port Louis'),
 (N'AE', N'United Arab Emirates', N'AED', 4975593, 82880, N'Abu Dhabi'),
 (N'CN', N'China', N'CNY', 1330044000, 9596960, N'Beijing'),
 (N'CI', N'Ivory Coast', N'XOF', 21058798, 322460, N'Yamoussoukro'),
 (N'TV', N'Tuvalu', N'AUD', 10472, 26, N'Funafuti'),
 (N'BW', N'Botswana', N'BWP', 2029307, 600370, N'Gaborone'),
 (N'DJ', N'Djibouti', N'DJF', 740528, 23000, N'Djibouti'),
 (N'MW', N'Malawi', N'MWK', 15447500, 118480, N'Lilongwe'),
 (N'CW', N'Curacao', N'ANG', 141766, 444, N'Willemstad'),
 (N'TR', N'Turkey', N'TRY', 77804122, 780580, N'Ankara'),
 (N'YE', N'Yemen', N'YER', 23495361, 527970, N'Sanaa'),
 (N'SS', N'South Sudan', N'SSP', 8260490, 644329, N'Juba'),
 (N'CF', N'Central African Republic', N'XAF', 4844927, 622984, N'Bangui'),
 (N'GW', N'Guinea-Bissau', N'XOF', 1565126, 36120, N'Bissau'),
 (N'IE', N'Ireland', N'EUR', 4622917, 70280, N'Dublin'),
 (N'HR', N'Croatia', N'HRK', 4491000, 56542, N'Zagreb'),
 (N'JO', N'Jordan', N'JOD', 6407085, 92300, N'Amman'),
 (N'TZ', N'Tanzania', N'TZS', 41892895, 945087, N'Dodoma'),
 (N'PK', N'Pakistan', N'PKR', 184404791, 803940, N'Islamabad'),
 (N'OM', N'Oman', N'OMR', 2967717, 212460, N'Muscat'),
 (N'DO', N'Dominican Republic', N'DOP', 9823821, 48730, N'Santo Domingo'),
 (N'HT', N'Haiti', N'HTG', 9648924, 27750, N'Port-au-Prince'),
 (N'MA', N'Morocco', N'MAD', 31627428, 446550, N'Rabat'),
 (N'KY', N'Cayman Islands', N'KYD', 44270, 262, N'George Town'),
 (N'TT', N'Trinidad and Tobago', N'TTD', 1228691, 5128, N'Port of Spain'),
 (N'TC', N'Turks and Caicos Islands', N'USD', 20556, 430, N'Cockburn Town'),
 (N'VI', N'U.S. Virgin Islands', N'USD', 108708, 352, N'Charlotte Amalie'),
 (N'PL', N'Poland', N'PLN', 38500000, 312685, N'Warsaw'),
 (N'VN', N'Vietnam', N'VND', 89571130, 329560, N'Hanoi'),
 (N'FM', N'Micronesia', N'USD', 107708, 702, N'Palikir'),
 (N'TK', N'Tokelau', N'NZD', 1466, 10, N''),
 (N'SB', N'Solomon Islands', N'SBD', 559198, 28450, N'Honiara'),
 (N'EC', N'Ecuador', N'USD', 14790608, 283560, N'Quito'),
 (N'SY', N'Syria', N'SYP', 22198110, 185180, N'Damascus'),
 (N'GT', N'Guatemala', N'GTQ', 13550440, 108890, N'Guatemala City'),
 (N'AG', N'Antigua and Barbuda', N'XCD', 86754, 443, N'St. John''s'),
 (N'GQ', N'Equatorial Guinea', N'XAF', 1014999, 28051, N'Malabo'),
 (N'MH', N'Marshall Islands', N'USD', 65859, 181, N'Majuro'),
 (N'KH', N'Cambodia', N'KHR', 14453680, 181040, N'Phnom Penh'),
 (N'MP', N'Northern Mariana Islands', N'USD', 53883, 477, N'Saipan'),
 (N'GR', N'Greece', N'EUR', 11000000, 131940, N'Athens'),
 (N'ZA', N'South Africa', N'ZAR', 49000000, 1219912, N'Pretoria'),
 (N'CM', N'Cameroon', N'XAF', 19294149, 475440, N'Yaoundé'),
 (N'IM', N'Isle of Man', N'GBP', 75049, 572, N'Douglas'),
 (N'SJ', N'Svalbard and Jan Mayen', N'NOK', 2550, 62049, N'Longyearbyen'),
 (N'KG', N'Kyrgyzstan', N'KGS', 5508626, 198500, N'Bishkek'),
 (N'MM', N'Myanmar', N'MMK', 53414374, 678500, N'Nay Pyi Taw'),
 (N'CH', N'Switzerland', N'CHF', 7581000, 41290, N'Berne'),
 (N'BG', N'Bulgaria', N'BGN', 7148785, 110910, N'Sofia'),
 (N'US', N'United States', N'USD', 310232863, 9629091, N'Washington'),
 (N'BF', N'Burkina Faso', N'XOF', 16241811, 274200, N'Ouagadougou'),
 (N'SN', N'Senegal', N'XOF', 12323252, 196190, N'Dakar'),
 (N'EE', N'Estonia', N'EUR', 1291170, 45226, N'Tallinn'),
 (N'LC', N'Saint Lucia', N'XCD', 160922, 616, N'Castries'),
 (N'SX', N'Sint Maarten', N'ANG', 37429, 21, N'Philipsburg'),
 (N'BL', N'Saint Barthélemy', N'EUR', 8450, 21, N'Gustavia'),
 (N'AL', N'Albania', N'ALL', 2986952, 28748, N'Tirana'),
 (N'AX', N'Åland', N'EUR', 26711, 1580, N'Mariehamn'),
 (N'UA', N'Ukraine', N'UAH', 45415596, 603700, N'Kyiv'),
 (N'KW', N'Kuwait', N'KWD', 2789132, 17820, N'Kuwait City'),
 (N'MG', N'Madagascar', N'MGA', 21281844, 587040, N'Antananarivo'),
 (N'SZ', N'Swaziland', N'SZL', 1354051, 17363, N'Mbabane'),
 (N'RS', N'Serbia', N'RSD', 7344847, 88361, N'Belgrade'),
 (N'BM', N'Bermuda', N'BMD', 65365, 53, N'Hamilton'),
 (N'RE', N'Réunion', N'EUR', 776948, 2517, N'Saint-Denis'),
 (N'TW', N'Taiwan', N'TWD', 22894384, 35980, N'Taipei'),
 (N'JE', N'Jersey', N'GBP', 90812, 116, N'Saint Helier'),
 (N'BB', N'Barbados', N'BBD', 285653, 431, N'Bridgetown'),
 (N'HM', N'Heard Island and McDonald Islands', N'AUD', 0, 412, N''),
 (N'UG', N'Uganda', N'UGX', 33398682, 236040, N'Kampala'),
 (N'PG', N'Papua New Guinea', N'PGK', 6064515, 462840, N'Port Moresby'),
 (N'DM', N'Dominica', N'XCD', 72813, 754, N'Roseau'),
 (N'CY', N'Cyprus', N'EUR', 1102677, 9250, N'Nicosia'),
 (N'JP', N'Japan', N'JPY', 127288000, 377835, N'Tokyo'),
 (N'AT', N'Austria', N'EUR', 8205000, 83858, N'Vienna'),
 (N'TF', N'French Southern Territories', N'EUR', 140, 7829, N'Port-aux-Français'),
 (N'TJ', N'Tajikistan', N'TJS', 7487489, 143100, N'Dushanbe'),
 (N'LB', N'Lebanon', N'LBP', 4125247, 10400, N'Beirut'),
 (N'IS', N'Iceland', N'ISK', 308910, 103000, N'Reykjavik'),
 (N'NC', N'New Caledonia', N'XPF', 216494, 19060, N'Noumea'),
 (N'IT', N'Italy', N'EUR', 60340328, 301230, N'Rome'),
 (N'BR', N'Brazil', N'BRL', 201103330, 8511965, N'Brasília'),
 (N'EG', N'Egypt', N'EGP', 80471869, 1001450, N'Cairo'),
 (N'AR', N'Argentina', N'ARS', 41343201, 2766890, N'Buenos Aires'),
 (N'CO', N'Colombia', N'COP', 47790000, 1138910, N'Bogotá'),
 (N'CG', N'Republic of the Congo', N'XAF', 3039126, 342000, N'Brazzaville'),
 (N'GG', N'Guernsey', N'GBP', 65228, 78, N'St Peter Port'),
 (N'TO', N'Tonga', N'TOP', 122580, 748, N'Nuku''alofa'),
 (N'ST', N'São Tomé and Príncipe', N'STD', 175808, 1001, N'São Tomé'),
 (N'KP', N'North Korea', N'KPW', 22912177, 120540, N'Pyongyang'),
 (N'VC', N'Saint Vincent and the Grenadines', N'XCD', 104217, 389, N'Kingstown'),
 (N'AZ', N'Azerbaijan', N'AZN', 8303512, 86600, N'Baku'),
 (N'CA', N'Canada', N'CAD', 33679000, 9984670, N'Ottawa'),
 (N'SE', N'Sweden', N'SEK', 9555893, 449964, N'Stockholm'),
 (N'TM', N'Turkmenistan', N'TMT', 4940916, 488100, N'Ashgabat'),
 (N'AU', N'Australia', N'AUD', 21515754, 7686850, N'Canberra'),
 (N'UY', N'Uruguay', N'UYU', 3477000, 176220, N'Montevideo'),
 (N'NP', N'Nepal', N'NPR', 28951852, 140800, N'Kathmandu'),
 (N'FI', N'Finland', N'EUR', 5244000, 337030, N'Helsinki'),
 (N'LY', N'Libya', N'LYD', 6461454, 1759540, N'Tripoli'),
 (N'MN', N'Mongolia', N'MNT', 3086918, 1565000, N'Ulan Bator'),
 (N'LK', N'Sri Lanka', N'LKR', 21513990, 65610, N'Colombo'),
 (N'PY', N'Paraguay', N'PYG', 6375830, 406750, N'Asunción'),
 (N'IL', N'Israel', N'ILS', 7353985, 20770, N''),
 (N'MR', N'Mauritania', N'MRO', 3205060, 1030700, N'Nouakchott'),
 (N'NO', N'Norway', N'NOK', 5009150, 324220, N'Oslo'),
 (N'RW', N'Rwanda', N'RWF', 11055976, 26338, N'Kigali'),
 (N'MD', N'Moldova', N'MDL', 4324000, 33843, N'Chisinau'),
 (N'AO', N'Angola', N'AOA', 13068161, 1246700, N'Luanda'),
 (N'KM', N'Comoros', N'KMF', 773407, 2170, N'Moroni'),
 (N'MC', N'Monaco', N'EUR', 32965, 1, N'Monaco'),
 (N'CC', N'Cocos Islands', N'AUD', 628, 14, N'West Island'),
 (N'AI', N'Anguilla', N'XCD', 13254, 102, N'The Valley'),
 (N'AF', N'Afghanistan', N'AFN', 29121286, 647500, N'Kabul'),
 (N'VA', N'Vatican City', N'EUR', 921, 1, N'Vatican'),
 (N'IO', N'British Indian Ocean Territory', N'USD', 4000, 60, N''),
 (N'DK', N'Denmark', N'DKK', 5484000, 43094, N'Copenhagen'),
 (N'NF', N'Norfolk Island', N'AUD', 1828, 34, N'Kingston'),
 (N'XK', N'Kosovo', N'EUR', 1800000, 10908, N'Pristina'),
 (N'BE', N'Belgium', N'EUR', 10403000, 30510, N'Brussels'),
 (N'NU', N'Niue', N'NZD', 2166, 260, N'Alofi'),
 (N'GN', N'Guinea', N'GNF', 10324025, 245857, N'Conakry'),
 (N'AS', N'American Samoa', N'USD', 57881, 199, N'Pago Pago'),
 (N'MO', N'Macao', N'MOP', 449198, 254, N'Macao'),
 (N'CX', N'Christmas Island', N'AUD', 1500, 135, N'The Settlement'),
 (N'AQ', N'Antarctica', NULL, 0, 14000000, N''),
 (N'GI', N'Gibraltar', N'GIP', 27884, 6, N'Gibraltar'),
 (N'CL', N'Chile', N'CLP', 16746491, 756950, N'Santiago'),
 (N'KN', N'Saint Kitts and Nevis', N'XCD', 51134, 261, N'Basseterre'),
 (N'MV', N'Maldives', N'MVR', 395650, 300, N'Malé'),
 (N'ER', N'Eritrea', N'ERN', 5792984, 121320, N'Asmara'),
 (N'SL', N'Sierra Leone', N'SLL', 5245695, 71740, N'Freetown'),
 (N'GP', N'Guadeloupe', N'EUR', 443000, 1780, N'Basse-Terre'),
 (N'MS', N'Montserrat', N'XCD', 9341, 102, N'Plymouth'),
 (N'EH', N'Western Sahara', N'MAD', 273008, 266000, N'El Aaiún'),
 (N'NL', N'Netherlands', N'EUR', 16645000, 41526, N'Amsterdam'),
 (N'BT', N'Bhutan', N'BTN', 699847, 47000, N'Thimphu'),
 (N'WF', N'Wallis and Futuna', N'XPF', 16025, 274, N'Mata-Utu'),
 (N'BD', N'Bangladesh', N'BDT', 156118464, 144000, N'Dhaka'),
 (N'LI', N'Liechtenstein', N'CHF', 35000, 160, N'Vaduz'),
 (N'SA', N'Saudi Arabia', N'SAR', 25731776, 1960582, N'Riyadh'),
 (N'CZ', N'Czech Republic', N'CZK', 10476000, 78866, N'Prague'),
 (N'LT', N'Lithuania', N'EUR', 2944459, 65200, N'Vilnius'),
 (N'GU', N'Guam', N'USD', 159358, 549, N'Hagåtña'),
 (N'DZ', N'Algeria', N'DZD', 34586184, 2381740, N'Algiers'),
 (N'MK', N'Macedonia', N'MKD', 2062294, 25333, N'Skopje'),
 (N'RU', N'Russia', N'RUB', 140702000, 17100000, N'Moscow'),
 (N'AW', N'Aruba', N'AWG', 71566, 193, N'Oranjestad'),
 (N'KE', N'Kenya', N'KES', 40046566, 582650, N'Nairobi'),
 (N'GA', N'Gabon', N'XAF', 1545255, 267667, N'Libreville'),
 (N'SC', N'Seychelles', N'SCR', 88340, 455, N'Victoria'),
 (N'BI', N'Burundi', N'BIF', 9863117, 27830, N'Bujumbura'),
 (N'PN', N'Pitcairn Islands', N'NZD', 46, 47, N'Adamstown'),
 (N'QA', N'Qatar', N'QAR', 840926, 11437, N'Doha'),
 (N'GY', N'Guyana', N'GYD', 748486, 214970, N'Georgetown'),
 (N'NZ', N'New Zealand', N'NZD', 4252277, 268680, N'Wellington'),
 (N'CD', N'Democratic Republic of the Congo', N'CDF', 70916439, 2345410, N'Kinshasa'),
 (N'CU', N'Cuba', N'CUP', 11423000, 110860, N'Havana'),
 (N'AM', N'Armenia', N'AMD', 2968000, 29800, N'Yerevan'),
 (N'VE', N'Venezuela', N'VEF', 27223228, 912050, N'Caracas'),
 (N'BY', N'Belarus', N'BYR', 9685000, 207600, N'Minsk'),
 (N'NG', N'Nigeria', N'NGN', 154000000, 923768, N'Abuja'),
 (N'BA', N'Bosnia and Herzegovina', N'BAM', 4590000, 51129, N'Sarajevo'),
 (N'UZ', N'Uzbekistan', N'UZS', 27865738, 447400, N'Tashkent'),
 (N'ZM', N'Zambia', N'ZMW', 13460305, 752614, N'Lusaka'),
 (N'YT', N'Mayotte', N'EUR', 159042, 374, N'Mamoutzou'),
 (N'SG', N'Singapore', N'SGD', 4701069, 692, N'Singapore'),
 (N'FO', N'Faroe Islands', N'DKK', 48228, 1399, N'Tórshavn'),
 (N'HN', N'Honduras', N'HNL', 7989415, 112090, N'Tegucigalpa'),
 (N'BQ', N'Bonaire', N'USD', 18012, 328, N''),
 (N'PF', N'French Polynesia', N'XPF', 270485, 4167, N'Papeete'),
 (N'GD', N'Grenada', N'XCD', 107818, 344, N'St. George''s'),
 (N'GE', N'Georgia', N'GEL', 4630000, 69700, N'Tbilisi'),
 (N'ET', N'Ethiopia', N'ETB', 88013491, 1127127, N'Addis Ababa'),
 (N'BS', N'Bahamas', N'BSD', 301790, 13940, N'Nassau'),
 (N'ML', N'Mali', N'XOF', 13796354, 1240000, N'Bamako'),
 (N'ZW', N'Zimbabwe', N'ZWD', 11651858, 390580, N'Harare'),
 (N'SV', N'El Salvador', N'USD', 6052064, 21040, N'San Salvador'),
 (N'TH', N'Thailand', N'THB', 67089500, 514000, N'Bangkok'),
 (N'BN', N'Brunei', N'BND', 395027, 5770, N'Bandar Seri Begawan'),
 (N'MZ', N'Mozambique', N'MZN', 22061451, 801590, N'Maputo'),
 (N'PR', N'Puerto Rico', N'USD', 3916632, 9104, N'San Juan'),
 (N'CR', N'Costa Rica', N'CRC', 4516220, 51100, N'San José'),
 (N'NA', N'Namibia', N'NAD', 2128471, 825418, N'Windhoek'),
 (N'HK', N'Hong Kong', N'HKD', 6898686, 1092, N'Hong Kong'),
 (N'PS', N'Palestine', N'ILS', 3800000, 5970, N''),
 (N'PA', N'Panama', N'PAB', 3410676, 78200, N'Panama City'),
 (N'VU', N'Vanuatu', N'VUV', 221552, 12200, N'Port Vila'),
 (N'ME', N'Montenegro', N'EUR', 666730, 14026, N'Podgorica'),
 (N'GL', N'Greenland', N'DKK', 56375, 2166086, N'Nuuk'),
 (N'SH', N'Saint Helena', N'SHP', 7460, 410, N'Jamestown'),
 (N'ES', N'Spain', N'EUR', 46505963, 504782, N'Madrid'),
 (N'IN', N'India', N'INR', 1173108018, 3287590, N'New Delhi'),
 (N'GF', N'French Guiana', N'EUR', 195506, 91000, N'Cayenne'),
 (N'MY', N'Malaysia', N'MYR', 28274729, 329750, N'Kuala Lumpur'),
 (N'LA', N'Laos', N'LAK', 6368162, 236800, N'Vientiane'),
 (N'SR', N'Suriname', N'SRD', 492829, 163270, N'Paramaribo'),
 (N'GS', N'South Georgia and the South Sandwich Islands', N'GBP', 30, 3903, N'Grytviken'),
 (N'UM', N'U.S. Minor Outlying Islands', N'USD', 0, 1, N''),
 (N'LS', N'Lesotho', N'LSL', 1919552, 30355, N'Maseru'),
 (N'TN', N'Tunisia', N'TND', 10589025, 163610, N'Tunis'),
 (N'PE', N'Peru', N'PEN', 29907003, 1285220, N'Lima'),
 (N'BO', N'Bolivia', N'BOB', 9947418, 1098580, N'Sucre'),
 (N'DE', N'Germany', N'EUR', 81802257, 357021, N'Berlin'),
 (N'HU', N'Hungary', N'HUF', 9982000, 93030, N'Budapest'),
 (N'BH', N'Bahrain', N'BHD', 738004, 665, N'Manama'),
 (N'GB', N'United Kingdom', N'GBP', 62348447, 244820, N'London'),
 (N'FR', N'France', N'EUR', 64768389, 547030, N'Paris'),
 (N'WS', N'Samoa', N'WST', 192001, 2944, N'Apia'),
 (N'LR', N'Liberia', N'LRD', 3685076, 111370, N'Monrovia'),
 (N'PM', N'Saint Pierre and Miquelon', N'EUR', 7012, 242, N'Saint-Pierre'),
 (N'SK', N'Slovakia', N'EUR', 5455000, 48845, N'Bratislava'),
 (N'CV', N'Cape Verde', N'CVE', 508659, 4033, N'Praia'),
 (N'BZ', N'Belize', N'BZD', 314522, 22966, N'Belmopan'),
 (N'BJ', N'Benin', N'XOF', 9056010, 112620, N'Porto-Novo'),
 (N'FJ', N'Fiji', N'FJD', 875983, 18270, N'Suva'),
 (N'LV', N'Latvia', N'EUR', 2217969, 64589, N'Riga'),
 (N'SO', N'Somalia', N'SOS', 10112453, 637657, N'Mogadishu'),
 (N'TD', N'Chad', N'XAF', 10543464, 1284000, N'N''Djamena'),
 (N'NI', N'Nicaragua', N'NIO', 5995928, 129494, N'Managua'),
 (N'FK', N'Falkland Islands', N'FKP', 2638, 12173, N'Stanley'),
 (N'NE', N'Niger', N'XOF', 15878271, 1267000, N'Niamey'),
 (N'IR', N'Iran', N'IRR', 76923300, 1648000, N'Tehran'),
 (N'ID', N'Indonesia', N'IDR', 242968342, 1919440, N'Jakarta'),
 (N'KR', N'South Korea', N'KRW', 48422644, 98480, N'Seoul'),
 (N'MF', N'Saint Martin', N'EUR', 35925, 53, N'Marigot'),
 (N'MQ', N'Martinique', N'EUR', 432900, 1100, N'Fort-de-France'),
 (N'CK', N'Cook Islands', N'NZD', 21388, 240, N'Avarua')
GO

-- Insert a few leagues
INSERT INTO Leagues(LeagueName, CountryCode) VALUES
 ('UK Premier League', 'GB'),
 ('Italian Serie A', 'IT'),
 ('UEFA Champions League', NULL),
 ('German Bundesliga', 'DE'),
 ('Bulgarian A Football Group', 'BG'),
 ('FIFA 2018 World Cup', NULL)
GO

-- Insert teams from Great Britain (GB)
INSERT INTO Teams(TeamName, CountryCode) VALUES
 ('Queens Park Rangers', 'GB'),
 ('Leicester City', 'GB'),
 ('Aston Villa', 'GB'),
 ('Swansea City', 'GB'),
 ('Stoke City', 'GB'),
 ('Southampton', 'GB'),
 ('West Bromwich Albion', 'GB'),
 ('Crystal Palace', 'GB'),
 ('Tottenham Hotspur', 'GB'),
 ('Manchester United', 'GB'),
 ('Manchester City', 'GB'),
 ('Newcastle United', 'GB'),
 ('Chelsea', 'GB'),
 ('Burnley', 'GB'),
 ('West Ham United', 'GB'),
 ('Arsenal', 'GB'),
 ('Hull City', 'GB'),
 ('Everton', 'GB'),
 ('Liverpool', 'GB'),
 ('Sunderland', 'GB')
GO

-- Assign the GB teams to "UK Premier League"
INSERT INTO Leagues_Teams(LeagueId, TeamId)
SELECT (SELECT MIN(Id) FROM Leagues WHERE LeagueName='UK Premier League'), Id 
FROM Teams WHERE CountryCode='GB'
GO

-- Insert teams from Germany (DE)
INSERT INTO Teams(TeamName, CountryCode) VALUES
 ('Mainz', 'DE'),
 ('Borussia Monchengladbach', 'DE'),
 ('Hannover 96', 'DE'),
 ('Bayern Munich', 'DE'),
 ('VfB Stuttgart', 'DE'),
 ('Werder Bremen', 'DE'),
 ('Bayer Leverkusen', 'DE'),
 ('Schalke 04', 'DE'),
 ('Hertha Berlin', 'DE'),
 ('VfL Wolfsburg', 'DE'),
 ('SC Freiburg', 'DE'),
 ('Borussia Dortmund', 'DE'),
 ('FC Augsburg', 'DE'),
 ('Hamburg SV', 'DE'),
 ('FC Cologne', 'DE'),
 ('Eintracht Frankfurt', 'DE'),
 ('TSG Hoffenheim', 'DE'),
 ('SC Paderborn 07', 'DE')
GO

-- Assign the DE teams to "German Bundesliga"
INSERT INTO Leagues_Teams(LeagueId, TeamId)
SELECT (SELECT MIN(Id) FROM Leagues WHERE LeagueName='German Bundesliga'), Id 
FROM Teams WHERE CountryCode='DE'
GO

-- Insert teams from Bulgaria (BG)
INSERT INTO Teams(TeamName, CountryCode) VALUES
  ('Ludogorets', 'BG'),
  ('CSKA', 'BG'),
  ('Lokomotiv (Sofia)', 'BG'),
  ('Litex', 'BG'),
  ('Beroe', 'BG'),
  ('Botev (Plovdiv)', 'BG'),
  ('Levski', 'BG'),
  ('Cherno More', 'BG'),
  ('Slavia', 'BG'),
  ('Lokomotiv (Plovdiv)', 'BG'),
  ('Marek', 'BG'),
  ('Haskovo', 'BG')
GO

-- Assign the BG teams to "Bulgarian A Football Group"
INSERT INTO Leagues_Teams(LeagueId, TeamId)
SELECT (SELECT MIN(Id) FROM Leagues WHERE LeagueName='Bulgarian A Football Group'), Id 
FROM Teams WHERE CountryCode='BG'
GO

-- Insert teams from Italy (IT)
INSERT INTO Teams(TeamName, CountryCode) VALUES
 ('Udinese', 'IT'),
 ('Lazio', 'IT'),
 ('Sampdoria', 'IT'),
 ('Napoli', 'IT'),
 ('Atalanta', 'IT'),
 ('Cagliari', 'IT'),
 ('Juventus', 'IT'),
 ('AS Roma', 'IT'),
 ('Torino', 'IT'),
 ('Empoli', 'IT'),
 ('Sassuolo', 'IT'),
 ('Chievo Verona', 'IT'),
 ('Hellas Verona', 'IT'),
 ('AC Milan', 'IT'),
 ('Genoa', 'IT'),
 ('Internazionale', 'IT'),
 ('Palermo', 'IT'),
 ('Fiorentina', 'IT'),
 ('Cesena', 'IT'),
 ('Parma', 'IT')
GO

-- Assign the IT teams to "Italian Serie A"
INSERT INTO Leagues_Teams(LeagueId, TeamId)
SELECT (SELECT MIN(Id) FROM Leagues WHERE LeagueName='Italian Serie A'), Id 
FROM Teams WHERE CountryCode='IT'
GO

-- Insert teams from "UEFA Champions League" (without the already inserted teams)
INSERT INTO Teams(TeamName, CountryCode) VALUES
 ('Real Madrid', 'ES'),
 ('Atletico Madrid', 'ES'),
 ('Barcelona', 'ES'),
 ('Paris Saint-Germain', 'FR'),
 ('AS Monaco FC', 'FR'),
 ('Basel 1893', 'CH'),
 ('Shakhtar Donetsk', 'UA'),
 ('Porto', 'PT')
GO

-- Assign the UEFA Teams to "UEFA Champions League"
INSERT INTO Leagues_Teams(LeagueId, TeamId)
SELECT (SELECT MIN(Id) FROM Leagues WHERE LeagueName='UEFA Champions League'), 
Id FROM Teams WHERE TeamName IN (
  'Manchester City',
  'Real Madrid',
  'Bayern Munich',
  'Juventus',
  'Barcelona',
  'AS Monaco FC',
  'Paris Saint-Germain',
  'Bayer Leverkusen',
  'Chelsea',
  'Atletico Madrid',
  'Basel 1893',
  'Porto',
  'Borussia Dortmund',
  'Schalke 04',
  'Arsenal',
  'Shakhtar Donetsk'
)
GO

-- Insert some international matches
INSERT INTO InternationalMatches(
  HomeCountryCode, AwayCountryCode, HomeGoals, AwayGoals, MatchDate, LeagueId) VALUES
('GE', 'MT', 2, 0, '25-Mar-2015 19:00', NULL),
('DK', 'US', 3, 2, '25-Mar-2015', NULL),
('AL', 'FR', NULL, NULL, '13-Jun-2015 21:45', (SELECT Id FROM Leagues WHERE LeagueName='FIFA 2018 World Cup')),
('ES', 'DE', NULL, NULL, NULL, NULL),
('BG', 'GR', 4, 0, '26-Jun-1994 11:35', NULL),
('BG', 'AR', 2, 0, '30-Jun-1994 18:35', NULL),
('DE', 'BG', 1, 2, '10-Jul-1994', NULL),
('ES', 'BG', NULL, NULL, NULL, (SELECT Id FROM Leagues WHERE LeagueName='FIFA 2018 World Cup'))
GO

-- Insert some team matches
INSERT INTO TeamMatches(
  HomeTeamId, AwayTeamId, HomeGoals, AwayGoals, MatchDate, LeagueId) VALUES

((SELECT Id FROM Teams WHERE TeamName='Liverpool'), 
 (SELECT Id FROM Teams WHERE TeamName='Manchester United'), 
 1, 2, '22-Mar-2015 16:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='UK Premier League')),

((SELECT Id FROM Teams WHERE TeamName='Hull City'), 
 (SELECT Id FROM Teams WHERE TeamName='Chelsea'), 
 2, 3, '22-Mar-2015 21:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='UK Premier League')),
 
((SELECT Id FROM Teams WHERE TeamName='Mainz'), 
 (SELECT Id FROM Teams WHERE TeamName='VfL Wolfsburg'), 
 1, 1, '22-Mar-2015',
 (SELECT Id FROM Leagues WHERE LeagueName='German Bundesliga')),

((SELECT Id FROM Teams WHERE TeamName='Manchester United'), 
 (SELECT Id FROM Teams WHERE TeamName='Schalke 04'), 
 NULL, NULL, '18-Sep-2015', NULL),

((SELECT Id FROM Teams WHERE TeamName='Bayern Munich'), 
 (SELECT Id FROM Teams WHERE TeamName='Juventus'), 
 NULL, NULL, NULL,
 (SELECT Id FROM Leagues WHERE LeagueName='UEFA Champions League')),

((SELECT Id FROM Teams WHERE TeamName='CSKA'), 
 (SELECT Id FROM Teams WHERE TeamName='Beroe'), 
 0, 0, '21-Mar-2015 17:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Ludogorets'), 
 (SELECT Id FROM Teams WHERE TeamName='Botev (Plovdiv)'), 
 0, 0, '22-Mar-2015 13:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Lokomotiv (Sofia)'), 
 (SELECT Id FROM Teams WHERE TeamName='Litex'), 
 0, 0, '22-Mar-2015 15:15', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Ludogorets'), 
 (SELECT Id FROM Teams WHERE TeamName='CSKA'), 
 4, 0, '04-Apr-2015 20:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Botev (Plovdiv)'), 
 (SELECT Id FROM Teams WHERE TeamName='Litex'), 
 0, 1, '05-Apr-2015 17:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Beroe'), 
 (SELECT Id FROM Teams WHERE TeamName='Lokomotiv (Sofia)'), 
 1, 4, '05-Apr-2015 20:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='CSKA'), 
 (SELECT Id FROM Teams WHERE TeamName='Botev (Plovdiv)'), 
 0, 0, '10-Apr-2015 20:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Litex'), 
 (SELECT Id FROM Teams WHERE TeamName='Beroe'), 
 1, 1, '11-Apr-2015 20:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group')),

((SELECT Id FROM Teams WHERE TeamName='Ludogorets'), 
 (SELECT Id FROM Teams WHERE TeamName='Lokomotiv (Sofia)'), 
 0, 0, '11-Apr-2015 17:00', 
 (SELECT Id FROM Leagues WHERE LeagueName='Bulgarian A Football Group'))

GO
