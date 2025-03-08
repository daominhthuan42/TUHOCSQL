CREATE DATABASE SQLDBQUERY
GO

USE SQLDBQUERY
GO

CREATE TABLE GIAOVIEN
(
	IDGV INT,
	NameGV NVARCHAR(100),
	Birthday DATE,
	Sex BIT,
	DiaChi CHAR(20),
	TienLuong FLOAT
)
GO

INSERT INTO dbo.GIAOVIEN
VALUES
(   0,
    N'Đào Minh Thuấn',
	'19961209',
	1,
	'Phú Yên',
	3000000
    )
INSERT INTO dbo.GIAOVIEN
VALUES
(   1,
    N'Đào Minh Thuận',
	'19981123',
	1,
	'Phú Yên',
	4000000
    )
INSERT INTO dbo.GIAOVIEN
VALUES
(   2,
    N'Phạm Thị Hoa',
	'19690101',
	0,
	'Phú Yên',
	9000000
    )

GO

-- Xóa dữ liệu
-- Nếu dùng mỗi Delete <Tên bảng> => Xóa toàn bộ dữ liệu.
DELETE dbo.GIAOVIEN

-- Xóa các trường mong muốn thêm where.
-- Các toán tử.
-- >, <, >= , AND, OR, <>, =
DELETE dbo.GIAOVIEN WHERE TienLuong > 3000000 AND IDGV < 1

-- Update dữ liệu toàn bộ bảng với nhiều trường update
UPDATE dbo.GIAOVIEN SET TienLuong = 10000000, DiaChi = 'Phu Yen'

-- Update dữ liệu chỉ trường mong muốn.
UPDATE dbo.GIAOVIEN SET TienLuong = 50000000, DiaChi = 'Phú Yên' WHERE Sex = 1 AND IDGV < 2

