USE NVDB
GO

CREATE TABLE [NHANVIEN] (
	[MaNV] INT NOT NULL PRIMARY KEY,
	[HoTen] VARCHAR(50) NOT NULL,
	[PHAI] VARCHAR(10),
	[NGAYSINH] DATE,
	[DIACHI] VARCHAR(50),
	[SDT] VARCHAR(10)
);

CREATE TABLE KHACHHANG (
	MaKH INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	TenKH NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100),
    SDT VARCHAR(10) CHECK (LEN(SDT) = 10 AND PATINDEX('%[^0-9]%', SDT) = 0)	
);

CREATE TABLE KHACHHANG1 (
	MaKH INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	TenKH NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100),
    SDT VARCHAR(10) CHECK (SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')	
);

-- THÊM CỘT EMAIL VÀO BẢNG NHÂN BIÊN
ALTER TABLE [dbo].[NHANVIEN]
ADD EMAIL VARCHAR(100);

-- THAY ĐỔI DATA TYPE CỘT HỌ VÀ TÊN
ALTER TABLE [dbo].[NHANVIEN]
ALTER COLUMN [HoTen] VARCHAR(100);

-- THÊM CONSTRAINT ĐỂ CHECK NGÀY SINH NHÂN VIÊN
ALTER TABLE [dbo].[NHANVIEN]
ADD CONSTRAINT NGAYSINHCHECK CHECK ([NGAYSINH] <= GETDATE());

-- XÓA HẾT DATA TRONG BẢNG NHÂN VIÊN NHƯNG BẢNG NHÂN VIÊN VẪN CÒN.
TRUNCATE TABLE [dbo].[NHANVIEN]

-- XÓA BẢNG KHÁCH HÀNG 1.
DROP TABLE [dbo].[KHACHHANG1]

/*
-- BT1: Bài tập tổng hợp
-- Yêu cầu 1: Tạo bảng SinhVien với các cột sau:
-- MaSV: Kiểu dữ liệu INT, khóa chính, không thể chứa giá trị null.
-- HoTen: Kiểu dữ liệu VARCHAR(50), không thể chứa giá trị null.
-- Lop: Kiểu dữ liệu VARCHAR(20).
-- Nganh: Kiểu dữ liệu VARCHAR(20).
-- DiemTB: Kiểu dữ liệu FLOAT.
*/
CREATE TABLE [SINHVIEN] (
	MaSV INT NOT NULL PRIMARY KEY,
	HoTen VARCHAR(50) NOT NULL,
	Lop VARCHAR(20),
	Nganh VARCHAR(20),
	DiemTB FLOAT
);

/*
-- BT2: Các yêu cầu sau:
-- 2: Thêm cột Email vào bảng SinhVien với kiểu dữ liệu VARCHAR(100).
-- 3: Sửa đổi kiểu dữ liệu của cột DiemTB trong bảng SinhVien thành kiểu dữ liệu DECIMAL(2,1)
-- 4: Xóa cột Nganh khỏi bảng SinhVien.
-- 5: Thêm ràng buộc kiểm tra cho cột DiemTB trong bảng SinhVien để giá trị phải lớn 8 bé hơn 10
-- 6: Thêm ràng buộc duy nhất cho cột MaSV trong bảng SinhVien.
-- 7: Thêm dữ liệu vào bảng SinhVien với một số thông tin thủ công.
-- 8: Xóa dữ liệu trong bảng SinhVien.
-- 9: Xóa bảng SinhVien.
-- 10: Tạo lại bảng SinhVien với cấu trúc ban đầu.
*/
-- 2
ALTER TABLE [dbo].[SINHVIEN]
ADD EMAIL VARCHAR(100);

-- 3
ALTER TABLE [dbo].[SINHVIEN]
ALTER COLUMN DiemTB DECIMAL(2, 1);

-- 4
ALTER TABLE [dbo].[SINHVIEN]
DROP COLUMN Nganh

-- 5
ALTER TABLE [dbo].[SINHVIEN]
ADD CONSTRAINT DIEMTBCHECK CHECK (DiemTB > 8 AND DiemTB < 10);

-- 6
ALTER TABLE [dbo].[SINHVIEN]
ADD CONSTRAINT MaSVUniQue UNIQUE(MaSV);

-- 7
TRUNCATE TABLE [dbo].[SINHVIEN]

-- 8
DROP TABLE [dbo].[SINHVIEN]

-- 9
CREATE TABLE [SINHVIEN] (
	MaSV INT NOT NULL PRIMARY KEY,
	HoTen VARCHAR(50) NOT NULL,
	Lop VARCHAR(20),
	Nganh VARCHAR(20),
	DiemTB FLOAT
);
