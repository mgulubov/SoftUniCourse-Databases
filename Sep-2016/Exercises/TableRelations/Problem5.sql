USE TableRelationsTestDatabase
GO
--------------------
--------------------
-- Drop tables if exist
DROP TABLE IF EXISTS
	OrderItems
--------------------
DROP TABLE IF EXISTS
	Items
--------------------
DROP TABLE IF EXISTS
	ItemTypes
--------------------
DROP TABLE IF EXISTS
	Orders
--------------------
DROP TABLE IF EXISTS
	Customers
--------------------
DROP TABLE IF EXISTS
	Cities
--------------------
--------------------
-- Create tables
CREATE TABLE
	Cities(
		CityID INT NOT NULL IDENTITY
			CONSTRAINT PK_Cities_CityID PRIMARY KEY,
		Name VARCHAR(50) NOT NULL
	)
--------------------
CREATE TABLE
	Customers(
		CustomerID INT NOT NULL IDENTITY
			CONSTRAINT PK_Customers_CustomerID PRIMARY KEY,
		Name VARCHAR(50) NOT NULL,
		Birthday DATE,
		CityID INT
			CONSTRAINT FK_Customers_CityID_Cities_CityID REFERENCES Cities(CityID)
	)
--------------------
CREATE TABLE
	Orders(
		OrderID INT NOT NULL IDENTITY
			CONSTRAINT PK_Orders_OrderID PRIMARY KEY,
		CustomerID INT NOT NULL
			CONSTRAINT FK_Orders_CustomerID_Customers_CustomerID REFERENCES Customers(CustomerID)
	)
--------------------
CREATE TABLE
	ItemTypes(
		ItemTypeID INT NOT NULL IDENTITY
			CONSTRAINT PK_ItemTypes_ItemTypeID PRIMARY KEY,
		Name VARCHAR(50) NOT NULL
	)
--------------------
CREATE TABLE
	Items(
		ItemID INT NOT NULL IDENTITY
			CONSTRAINT PK_Items_ItemID PRIMARY KEY,
		Name VARCHAR(50) NOT NULL,
		ItemTypeID INT
			CONSTRAINT FK_Items_ItemTypeID_ItemTypes_ItemTypeID REFERENCES ItemTypes(ItemTypeID)
	)
--------------------
CREATE TABLE
	OrderItems(
		OrderID INT NOT NULL
			CONSTRAINT FK_OrderItems_OrderID_Orders_OrderID REFERENCES Orders(OrderID),
		ItemID INT NOT NULL
			CONSTRAINT FK_OrderItems_ItemID_Items_ItemID REFERENCES Items(ItemID),

		CONSTRAINT PK_OrderItems_OrderID_ItemID PRIMARY KEY (OrderID, ItemID)
	)
--------------------
--------------------