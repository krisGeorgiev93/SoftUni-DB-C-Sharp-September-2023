--11
CREATE FUNCTION udf_HoursToComplete(@StartDate DATETIME, @EndDate DATETIME)
RETURNS INT 
AS 
BEGIN
 	DECLARE @totalHours INT = DATEDIFF(HOUR, @StartDate, @EndDate)
	IF(@StartDate IS NULL)
		RETURN 0
	ELSE IF(@EndDate IS NULL)
		RETURN 0

	RETURN @totalHours
END 


SELECT dbo.udf_HoursToComplete(OpenDate, CloseDate) AS TotalHours
  FROM Reports


  --12
CREATE PROCEDURE usp_AssignEmployeeToReport(@EmployeeId INT, @ReportId INT)
    AS
		DECLARE @emplyeeDepartment INT = (SELECT DepartmentId 
										    FROM Employees
										   WHERE Id = @EmployeeId)
		DECLARE @reportCategoryId INT = (SELECT CategoryId
											 FROM Reports
										    WHERE Id = @ReportId)
		DECLARE @categoryDepartmentId INT = (SELECT DepartmentId 
											   FROM Categories
											  WHERE Id = @reportCategoryId)

		IF(@emplyeeDepartment = @categoryDepartmentId)
			UPDATE Reports SET EmployeeId = @EmployeeId WHERE Id = @ReportId
		ELSE
		THROW 50001, 'Employee doesn''t belong to the appropriate department!', 1
					 