USE NORTHWND
GO

-- TRIGGER KHI INSERT SẼ CHUYỂN PRODUCTNAME VỀ VIẾT HOA TOÀN BỘ
CREATE TRIGGER makeProductNameUpperCase
ON [dbo].[Products]
AFTER INSERT
AS
BEGIN
	UPDATE Products
	SET [ProductName] = UPPER(i.ProductName)
	FROM inserted i
	WHERE Products.ProductID = i.ProductID
END

INSERT INTO [dbo].[Products] ([ProductName], [SupplierID], [CategoryID])
VALUES (N'mỳ cung đình', 1, 1);

-- TẠO TRIGGER CHẶN KHÔNG CHO PHÉP CẬP NHẬT DISCONTINUED SẢN PHẨM KHÁC 0 VÀ 1.
--CREATE TRIGGER preventNegativeDiscountinued
--ON [dbo].[Products]
--FOR UPDATE
--AS
--BEGIN
--    SET NOCOUNT ON;
--	IF EXISTS (SELECT 1 FROM inserted WHERE [Discontinued] NOT IN (0, 1))
--	BEGIN
--		ROLLBACK;
--		RAISERROR ('[Discontinued] KHÔNG THỂ NHỎ HƠN 0', 16, 1);
--	END
--END

--UPDATE [dbo].[Products]
--SET [Discontinued] = -5
--WHERE [ProductID] = 79

-- VIẾT 1 TRIGGER TRONG CSDL ĐỂ ĐẢM BẢO RẰNG MỖI KHI CÓ MỘT CHI TIẾT ĐƠN HÀNG MỚI ĐƯỢC THÊM VÀO
-- SỐ LƯỢNG HÀNG TỒN KHO GIẢM ĐI.
CREATE TRIGGER updateProductInventory
ON [dbo].[Order Details]
AFTER INSERT
AS
BEGIN
	UPDATE [dbo].[Products]
	SET [UnitsInStock] -= (SELECT [Quantity] FROM inserted WHERE [dbo].[Products].ProductID = inserted.ProductID)
	WHERE [dbo].[Products].ProductID IN (SELECT [ProductID] FROM inserted)
END 

INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
VALUES
(10248, 78, 10, 50, 0);

-- BỔ SUNG THÊM CỘT LastModified VÀ TẠO 1 TRIGGER ĐỂ SAU KHI MỘT SẢN PHẨM THÊM VÀO HOẶC CẬP NHẬT VÀO BẢNG
-- PRODUCT TỰ ĐỘNG CẬP NHẬT TRƯỜNG LastModified VỚI NGÀY GIỜ HIỆN TẠI.
ALTER TABLE [dbo].[Products]
ADD LastModified  DATETIME NULL;

CREATE TRIGGER updateLastModified
ON [dbo].[Products]
AFTER INSERT, UPDATE
AS
BEGIN
	UPDATE Products
	SET [LastModified] = GETDATE()
	FROM inserted i
	WHERE i.ProductID =  [dbo].[Products].ProductID
END

INSERT INTO [dbo].[Products]
VALUES
(N'Chả Giò', 2, 4, '1430 boxes', 143.56, 876, 100, 20, 0, NULL);

UPDATE [dbo].[Products]
SET [UnitsInStock] = 100
WHERE [ProductID] = 80;

-- TẠO 1 TRIGGER "INSTEAD OF DELETE" ĐỂ KIỂM TRA XEM KHÁCH HÀNG CÓ ĐƠN KHÔNG.
-- NẾU CÓ, TRIGGER KHÔNG CHO PHÉP XÓA KHÁCH HÀNG.
-- NẾU KHÔNG CÓ ĐƠN HÀNG LIÊN QUAN TRIGGER XÓA KHÁCH HÀNG.
CREATE TRIGGER deleteCustomer
ON [dbo].[Customers]
INSTEAD OF DELETE
AS
BEGIN
    -- KIỂM TRA KHÁCH HÀNG CÓ ĐƠN HÀNG HAY KO?
	SET NOCOUNT ON;
	IF EXISTS (
				SELECT 1 FROM deleted AS DE
				JOIN [dbo].[Orders] AS O ON O.CustomerID = DE.CustomerID
			  )
	BEGIN
		RAISERROR ('KHÔNG CHO PHÉP XÓA KHÁCH HÀNG', 16, 1);
	END	
	ELSE
	BEGIN
		DELETE FROM Customers
		WHERE [CustomerID] IN (SELECT [CustomerID] FROM deleted)
	END
END;

DELETE FROM [dbo].[Customers]
WHERE [CustomerID] LIKE 'ALFKI';

-- TẠO 1 TRIGGER TRONG CƠ SỞ DỮ LIỆU NORTHWIND ĐỂ KIỂM TRA VÀ KHÔNG CHO PHÉP ĐẶT HÀNG
-- (ORDER) VỚI SỐ LƯỢNG SẢN PHẨM LỚN HƠN SỐ LƯỢNG TỒN KHO.
SELECT * FROM [dbo].[Order Details];
SELECT * FROM [dbo].[Products];

CREATE TRIGGER checkingOrderWithUnitslnStock
ON [dbo].[Order Details]
FOR INSERT
AS
BEGIN
	SET NOCOUNT ON;
	IF EXISTS (
				SELECT 1
				FROM inserted AS i
				JOIN dbo.[Order Details] od ON od.OrderID = i.OrderID 
				JOIN [dbo].[Products] AS PR ON PR.ProductID = od.ProductID
				WHERE od.Quantity > PR.UnitsInStock
		     )
	BEGIN
		ROLLBACK;
		RAISERROR ('KHÔNG CHO PHÉP ĐẶT HÀNG VÌ SỐ LƯỢNG SẢN PHẨM TRONG ĐƠN LỚN HƠN SỐ LƯỢNG SẢN PHẨM TRONG KHO', 16, 1);
	END
END;

-- THỰC THI
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount])
VALUES
(10248, 80, 12.00, 101, 0);
