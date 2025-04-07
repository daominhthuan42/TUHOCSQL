USE NORTHWND
GO

-- TẠO 1 STORED PROCEDURE ĐỂ LẤY THÔNG TIN
-- VỀ SẢN PHẨM DỰA TRÊN SẢN PHẨM ĐƯỢC CUNG CẤP.
CREATE PROCEDURE GetProductName
	@ProductName NVARCHAR(100)

AS
BEGIN
	SELECT * FROM [dbo].[Products] AS P
	WHERE P.ProductName = @ProductName
END

-- SỬ DỤNG
EXEC GetProductName @ProductName = 'Chai';
EXEC GetProductName @ProductName = 'Chang';
EXEC GetProductName @ProductName = 'Ikura';

-- TẠO MỘT STORED PROCEDURE ĐỂ TÍNH TỔNG DOANH SỐ BÁN HÀNG
-- CỦA MỘT NHÂN VIÊN DỰA TRÊN EMPLOYEEID.
CREATE PROCEDURE GetEmployeeSaleToTal
	@EmployeeID INT
AS
BEGIN
	SELECT SUM(OD.Quantity * OD.UnitPrice) AS TotalSales
	FROM [dbo].[Orders] AS O
	JOIN [dbo].[Order Details] AS OD ON OD.OrderID = O.OrderID
	WHERE O.EmployeeID = @EmployeeID
END

-- SỬ DỤNG
EXEC GetEmployeeSaleToTal @EmployeeID = 1;
EXEC GetEmployeeSaleToTal @EmployeeID = 2;
EXEC GetEmployeeSaleToTal @EmployeeID = 3;

-- TẠO MÔT STORED PROCEDURE ĐỂ THÊM 1 KHÁCH HÀNG MỚI VÀO BẢNG CUSTOMER
CREATE PROCEDURE AddCustomer
	@CustomerID NCHAR(5),
	@CompanyName NVARCHAR(40),
	@ContactName NVARCHAR(30),
	@ContactTitle NVARCHAR(30)
AS
BEGIN
	INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle])
	VALUES
	(@CustomerID, UPPER(@CompanyName), @ContactName, @ContactTitle)
END

-- SỬ DỤNG
EXEC AddCustomer @CustomerID = 'NEWN', @CompanyName = 'Renesas', @ContactName = 'Thuan Dao', @ContactTitle = 'Mr.';

-- TẠO MỘT STORE PROCEDURE ĐỂ CẬP NHẬT GIÁ CỦA TẤT CẢ SẢN PHẨM THUỘC DANH MỤC CỤ THỂ.
CREATE PROCEDURE UpdatePriceProduct
	@ProductID INT,
	@PriceIncreaseDecrease money
AS
BEGIN
	UPDATE [dbo].[Products]
	SET [UnitPrice] += @PriceIncreaseDecrease
	WHERE [ProductID] = @ProductID;
END

-- SỬ DỤNG
EXEC UpdatePriceProduct @ProductID = 1, @PriceIncreaseDecrease = 10;

-- VIẾT MỘT STORE PROCEDURE ĐỂ TRUY XUẤT DANH SÁCH CÁC ĐƠN HÀNG CHO MỘT KHÁCH HÀNG DỰA TRÊN TÊN KHÁCH HÀNG.
-- THAM SỐ ĐẦU VÀO LÀ TÊN KHÁCH HÀNG VÀ STORE PROCEDURE SẼ TRẢ VỀ DANH SÁCH CÁC ĐƠN ĐẶT HÀNG LIÊN QUAN
CREATE PROCEDURE listOrder
	@customerName NVARCHAR(30) 
AS
BEGIN
	SELECT O.[OrderID]
	FROM [dbo].[Orders] AS O
	JOIN [dbo].[Customers] AS CU ON CU.[CustomerID] = O.[CustomerID]
	WHERE CU.[ContactName] = @customerName;
END

EXEC listOrder @customerName = 'Maria Anders';

-- VIẾT MỘT STORE PROCEDURE ĐỂ CẬP NHẬT SỐ LƯỢNG HÀNG TỒN KHO CHO 1 SẢN PHẨM CỤ THỂ DỰA
-- TRÊN ID SẢN PHẨM VÀ SỐ LƯỢNG MỚI. STORE PROCEDURE NÀY SẼ NHẬN ID SẢN PHẨM VÀ SỐ LƯỢNG MỚI
-- SAU ĐÓ CẬP NHẬT SỐ LƯỢNG TỒN KHO TRONG BẢNG PRODUCTS.
CREATE PROCEDURE updateUnitslnStock
	@productID INT,
	@unitslnStock smallint
AS
BEGIN
	UPDATE [dbo].[Products]
	SET [UnitsInStock] = @unitslnStock
	WHERE [ProductID] = @productID;
END

EXEC updateUnitslnStock @productID = 1, @unitslnStock = 50;

-- VIẾT MỘT STORE PROCEDURE ĐỂ TRUY XUẤT DANH SÁCH CÁC SẢN PHẨM THUỘC MỘT DANH MỤC CỤ THỂ.
-- VÀ GIỚI HẠN SỘ LƯỢNG SẢN PHẨM TRẢ VỀ. THAM SỐ ĐẦU VÀO BAO GỒM ID DANH MỤC VÀ SỐ LƯỢNG
-- SẢN PHẨM CẦN TRẢ VỀ.
ALTER PROCEDURE totalProduct
	@categoryID INT,
	@totalReturnProduct INT
AS
BEGIN
	SELECT TOP (@totalReturnProduct) *
	FROM [dbo].[Products] AS PR
	WHERE PR.[CategoryID] = @categoryID
END

EXEC totalProduct @categoryID = 1, @totalReturnProduct = 15;

-- VIẾT MỘT STORE PROCEDURE ĐỂ TRUY XUẤT DANH SÁCH KHÁCH HÀNG DỰA TRÊN KHU VỰC ĐỊA LÝ (REGION) HOẶC QUỐC GIA (COUNTRY) CỦA HỌ.
-- THAM SỐ ĐẦU VÀO SẼ LÀ KHU VUẸC ĐIA LÝ HOẶC QUỐC GIA CỦA HỌ VÀ STORE PROCEDURE SẼ TRẢ VỀ DANH SÁCH KHÁCH HÀNG TRONG KHU VỰC ĐÓ.
ALTER PROCEDURE listCutomerFollowRegionOrCountry
	@regionorcountry NVARCHAR(15)
AS
BEGIN
	SELECT *
	FROM [dbo].[Customers] AS CU
	WHERE CU.Country LIKE @regionorcountry OR
		  CU.Region LIKE @regionorcountry
END

EXEC listCutomerFollowRegionOrCountry @regionorcountry = 'SP';
