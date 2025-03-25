USE NORTHWND
GO

-- THÊM 1 KHÁCH HÀNG MỚI
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [Phone])
VALUES
('KH123', 'BRAZEER', 'JONNY SIN', '09783323234232');

-- THÊM NHIỀU KHÁCH HÀNG CÙNG LÚC
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [Phone])
VALUES
('KH234', 'BRAZEER', 'DANNY D', '09783323234232'),
('KH323', 'BRAZEER', 'JOAN', '09783323234232'), 
('KH987', 'BRAZEER', 'THUAN', '09783323234232'), 
('KH154', 'BRAZEER', 'MEIKU', '09783323234232');

INSERT INTO [dbo].[Products] ([ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock])
VALUES
('PIN', 1, 2, '20 PIN', 10.99, 100);