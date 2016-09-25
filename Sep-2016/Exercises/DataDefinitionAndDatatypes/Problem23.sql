USE Hotel
GO

DECLARE 
	Payment_Ids_Cursor CURSOR
FOR
	SELECT
		Id
	FROM
		Payments

DECLARE @PaymentId INT

OPEN Payment_Ids_Cursor

FETCH NEXT FROM
	Payment_Ids_Cursor
INTO
	@PaymentId

WHILE @@FETCH_STATUS = 0
BEGIN

DECLARE @CurrentTaxRate SMALLMONEY = (
	SELECT
		(
			CASE
				WHEN p.TaxRate IS NULL
				THEN 0
				ELSE p.TaxRate
			END
		)
	FROM
		Payments p
	WHERE
		p.Id = @PaymentId
) 

DECLARE @NewTaxRate SMALLMONEY = @CurrentTaxRate + (@CurrentTaxRate * 0.03)

UPDATE
	Payments
SET
	TaxRate = @NewTaxRate
WHERE
	Id = @PaymentId

FETCH NEXT FROM
	Payment_Ids_Cursor
INTO
	@PaymentId

END

CLOSE Payment_Ids_Cursor
DEALLOCATE Payment_Ids_Cursor

SELECT 
	* 
FROM 
	Payments