CREATE DATABASE SQLPrimaryForeign
GO

USE SQLPrimaryForeign
GO

CREATE TABLE BoMon
(
	MaBoMon CHAR(10) PRIMARY KEY,
	TenBoMon NVARCHAR(100) DEFAULT N'Tên bộ môn'
)
GO

CREATE TABLE Lop
(
	MaLop CHAR(10) NOT NULL,
	Name NVARCHAR(100) DEFAULT N'Tên bộ môn'

	PRIMARY KEY(MaLop)
)
GO

-- Điều kiện để tạo khóa ngoại.
-- Tham chiếu đến khóa chính.
-- Unique, Not null,
-- Cùng kiểu dữ liệu.
-- Cùng số lượng trường có sắp xếp.

-- Lợi ích:
-- Đảm bảo toàn vẹn dữ liệu. Không có trường hợp tham chiếu đến dữ liệu không tồn tại.

CREATE TABLE GiaoVien
(
	MaGV CHAR(10) NOT NULL,
	NameGV NVARCHAR(100) DEFAULT N'Tên giáo viên',
	DiaChi NVARCHAR(100) DEFAULT N'Địa chỉ giáo viên',
	NgaySinh DATE,
	Sex BIT,
	MaBoMon CHAR(10),
	FOREIGN KEY(MaBoMon) REFERENCES dbo.BoMon(MaBoMon)
)
GO

ALTER TABLE dbo.GIAOVIEN ADD PRIMARY KEY(MaGV)

CREATE TABLE HocSinh
(
	MaHS CHAR(10) NOT NULL,
	NameHS NVARCHAR(100) DEFAULT N'Tên học sinh',
	MaLop CHAR(10)
)
GO
-- ALTER TABLE dbo.HocSinh ADD FOREIGN KEY(MaLop) REFERENCES dbo.Lop(MaLop)

INSERT INTO dbo.BoMon
VALUES
(   'BM01',     -- MaBoMon - char(10)
    N'Bộ Môn Thê Dục' -- TenBoMon - nvarchar(100)
)

INSERT INTO dbo.BoMon
VALUES
(   'BM02',     -- MaBoMon - char(10)
    N'Bộ Môn Hội Họa' -- TenBoMon - nvarchar(100)
)

INSERT INTO dbo.BoMon
VALUES
(   'BM03',     -- MaBoMon - char(10)
    N'Bộ Môn Âm Nhạc' -- TenBoMon - nvarchar(100)
)

INSERT INTO dbo.GiaoVien
VALUES
(   'GV01',      -- MaGV - char(10)
    N'Đào Minh Thuấn', -- NameGV - nvarchar(100)
    N'Phú Yên', -- DiaChi - nvarchar(100)
    GETDATE(),    -- NgaySinh - date
    1,    -- Sex - bit
    'BM03'     -- MaBoMon - char(10)
    )

INSERT INTO dbo.GiaoVien
VALUES
(   'GV02',      -- MaGV - char(10)
    N'Đào Minh Thuận', -- NameGV - nvarchar(100)
    N'Phú Yên', -- DiaChi - nvarchar(100)
    GETDATE(),    -- NgaySinh - date
    1,    -- Sex - bit
    'BM01'     -- MaBoMon - char(10)
    )

INSERT INTO dbo.GiaoVien
VALUES
(   'GV03',      -- MaGV - char(10)
    N'Phạm Thị Hoa', -- NameGV - nvarchar(100)
    N'Phú Yên', -- DiaChi - nvarchar(100)
    GETDATE(),    -- NgaySinh - date
    1,    -- Sex - bit
    'BM01'     -- MaBoMon - char(10)
    )


-- Tạo khóa ngoại sau khi tạo bảng
ALTER TABLE dbo.HocSinh ADD CONSTRAINT FK_HS FOREIGN KEY(MaLop) REFERENCES dbo.Lop( MaLop)

-- Hủy khóa
ALTER TABLE dbo.HocSinh DROP CONSTRAINT FK_HS