USE NORTHWND
GO

-- SỬ DỤNG TRUY VẤN ĐỆ QUY ĐỂ TẠO MỘT CÂY CẤU TRÚC QUẢN LÝ NHÂN VIÊN TRONG BẢNG "EMPLOYEES"
-- TRONG ĐÓ 'REPORT TO' LÀ MÃ QUẢN LÝ NHÂN VIÊN
DECLARE @EMPLOYEEID  INT
SET @EMPLOYEEID = 2;

WITH E_CTE AS (
	SELECT E.EmployeeID,
		   E.FirstName + ' ' + E.LastName AS NAME,
		   E.ReportsTo AS MANAGERID,
		   0 AS LEVEL
	FROM [dbo].[Employees] AS E
	WHERE E.EmployeeID = @EMPLOYEEID

	UNION ALL

	SELECT E1.EmployeeID,
		   E1.FirstName + ' ' + E1.LastName AS NAME,
		   E1.ReportsTo AS MANAGERID,
		   LEVEL + 1 AS LEVEL
	FROM [dbo].[Employees] AS E1
	JOIN E_CTE ON E_CTE.EmployeeID = E1.ReportsTo
)
SELECT * 
FROM E_CTE
OPTION (MAXRECURSION 100);
