USE NORTHWND
GO

SELECT PR.ProductID, PR.ProductName --3
FROM [dbo].[Products] AS PR -- 1
WHERE PR.CategoryID IN (1, 2, 3) -- 2

SELECT PR.CategoryID, COUNT(PR.ProductID) AS [TOTAL PRODUCT] -- 5
FROM [dbo].[Products] AS PR -- 1
WHERE PR.CategoryID IN (1, 2, 3) -- 2
GROUP BY PR.CategoryID -- 3
HAVING COUNT(PR.ProductID) >= 10 -- 4 [TOTAL PRODUCT] CHƯA TỒN TẠI
ORDER BY [TOTAL PRODUCT] ASC -- 6 [TOTAL PRODUCT] ĐÃ TỒN TẠI

select top 3 p.ProductID, o.Discount, o2.ShipCountry --> B7 và B8: chọn cột và dòng cần lấy
from [dbo].[Products] p --> B1: kiểm tra bảng Products
inner join [dbo].[Order Details] o --> B2: kiểm tra bảng Order Details
on p.ProductID = o.ProductID --> B3: kiểm tra điều kiện từ 2 bảng Products và Order Details
inner join [dbo].[Orders] o2 --> B4: kiểm tra bảng Orders
on o.OrderID = o2.OrderID --> B5: kiểm tra điều kiện từ 2 bảng Orders và Order Details
where o.Discount = 0.25 and o2.ShipCountry = 'Germany' --> B6: kiểm tra các điều kiện WHERE
order by p.ProductID desc --> B9: sắp xếp dữ liệu theo p.ProductID
;