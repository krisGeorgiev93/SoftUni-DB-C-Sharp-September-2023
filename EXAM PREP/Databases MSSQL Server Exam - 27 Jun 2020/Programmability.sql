--    11. Place Order
CREATE OR ALTER PROC usp_PlaceOrder(@jobId INT, @partSerialNumber VARCHAR(50), @quantity INT)
AS
BEGIN
	IF ((SELECT Status
         FROM Jobs
         WHERE JobId = @jobId) = 'Finished')
        THROW 50011, 'This job is not active!', 1;
    IF @quantity <= 0
        THROW 50012, 'Part quantity must be more than zero!', 1;
	DECLARE
		@job INT = (SELECT JobId
	                FROM Jobs
	                WHERE JobId = @jobId)
	    IF @job IS NULL
	        THROW 50013, 'Job not found!', 1;
	DECLARE
    	@partId INT = (SELECT PartId
                   FROM Parts
                   WHERE SerialNumber = @partSerialNumber)
	    IF @partId IS NULL
	        THROW 50014, 'Part not found!', 1;
	    IF (SELECT OrderId
	         FROM Orders
	         WHERE JobId = @jobId
	           AND IssueDate IS NULL) IS NULL
	        BEGIN
	            INSERT INTO Orders (JobId, IssueDate, Delivered)
	            VALUES (@jobId, NULL, 0)
	        END
	DECLARE
	    @orderId int = (
	        SELECT OrderId
	        FROM Orders
	        WHERE JobId = @jobId
	          AND IssueDate IS NULL)
	DECLARE
	    @orderPartsQuantity INT = (SELECT Quantity
	                               FROM OrderParts
	                               WHERE OrderId = @orderId
	                                 AND PartId = @partId)
	    IF @orderPartsQuantity IS NULL
            INSERT INTO OrderParts (OrderId, PartId, Quantity)
            VALUES (@orderId, @partId, @quantity)
	    ELSE
            UPDATE OrderParts
            SET Quantity += @quantity
            WHERE OrderId = @orderId
              AND PartId = @partId
END



--12. Cost of Order
CREATE FUNCTION udf_GetCost(@jobId int)
RETURNS DECIMAL(10,2)
AS
BEGIN
	DECLARE 
		@totalCost DECIMAL(10,2) = (
			SELECT
				SUM(p.Price)
			FROM
				Parts AS p
			JOIN OrderParts AS op ON
				p.PartId = op.PartId
			JOIN Orders AS o ON
				o.OrderId = op.OrderId
			JOIN Jobs AS j ON
				j.JobId = o.JobId
			WHERE
				j.JobId = @jobId)
		IF @totalCost IS NULL
			RETURN 0
	    RETURN @totalCost
END

SELECT dbo.udf_GetCost(1)