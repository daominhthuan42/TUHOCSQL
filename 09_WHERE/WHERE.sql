USE NORTHWND
GO

-- LIỆT KÊ NHÂN VIÊN ĐẾN TỪ LONDON (UK), SẮP XẾP KẾT QUẢ THEO LASTNAME A->Z
SELECT *
FROM dbo.Employees AS EM
WHERE EM.City = 'London'
ORDER BY EM.LastName ASC

-- LIỆT KÊ TẤT CẢ ĐƠN HÀNG GIAO MUỘN, BIẾT RẰNG NGÀY CẦN GIAO LÀ REQUIREDDATE VÀ NGÀY GIAO HÀNG THỰC TẾ SHIPPEDDATE
SELECT O.OrderID, O.RequiredDate, O.ShippedDate
FROM dbo.Orders AS O
WHERE O.ShippedDate > O.RequiredDate

-- LẤY RA TẤT CẢ ĐƠN HÀNG CHI TIẾT GIÀM GIÁ NHIỀU HƠN 10%
SELECT *
FROM dbo.[Order Details] AS OD
WHERE OD.Discount > 0.1

-- LIỆT KÊ TẤT CẢ ĐƠN HÀNG ĐƯỢC GỬI TỪ "FRANCE".
SELECT *
FROM dbo.Orders AS O
WHERE O.ShipCountry = 'France'

-- LIỆT KÊ TẤT CÁC SẢN PHẨM CÓ SỐ LƯỢNG HÀNG TRONG KHO > 20
SELECT *
FROM dbo.Products AS P
WHERE P.UnitsInStock > 20
