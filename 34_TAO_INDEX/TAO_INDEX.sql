USE AdventureWorks2022
GO

SELECT COUNT(*)
FROM [Sales].[SalesOrderDetail]

-- BẬT HIỂN THỊ THỐNG KÊ VỀ TÀI NGUYÊN
SET STATISTICS IO ON

SELECT *
FROM [Sales].[SalesOrderDetail]
WHERE [CarrierTrackingNumber] = '1B2B-492F-A9'

SET STATISTICS IO OFF

-- TẠO INDEX CHO [CarrierTrackingNumber]
CREATE INDEX idx_CarrierTrackingNumber
ON [Sales].[SalesOrderDetail] ([CarrierTrackingNumber]);
