USE HowKteam
GO

-- TÌM RA MÃ GIÁO VIÊN CÓ LƯƠNG THẤP NHẤT.
SELECT TOP 1 MAGV
FROM [dbo].[GIAOVIEN]
WHERE [LUONG] = (SELECT MIN(LUONG) FROM [dbo].[GIAOVIEN])

-- LẤY RA TUỔI CỦA GIÁO VIÊN VỚI MÃ GIÁO VIÊN CÓ LƯƠNG THẤP NHẤT.
SELECT YEAR(GETDATE()) - YEAR([NGSINH])
FROM [dbo].[GIAOVIEN] 
WHERE MAGV = 
			(
				SELECT TOP 1 MAGV
				FROM [dbo].[GIAOVIEN]
				WHERE [LUONG] = (SELECT MIN(LUONG) FROM [dbo].[GIAOVIEN])
			);

--------------------------------------------------------------------------
-- TẠO RA 1 BIẾN KIỂU NCHAR LƯU MÃ GIÁO VIÊN LƯƠNG THẤP NHẤT
DECLARE @minSalaryMAGV NCHAR(3)

SELECT @minSalaryMAGV = MAGV FROM [dbo].[GIAOVIEN] WHERE [LUONG] = (SELECT MIN(LUONG) FROM [dbo].[GIAOVIEN])

SELECT YEAR(GETDATE()) - YEAR([NGSINH])
FROM [dbo].[GIAOVIEN] 
WHERE MAGV = @minSalaryMAGV

--------------------------------------------------------------------------
-- KHỚI TẠO VỚI KIỂU DỮ LIỆU
DECLARE @i INT

-- KHỚI TẠO VỚI GIÁ TRỊ MẶC ĐỊNH
DECLARE @j INT = 0

-- SET DỮ LIỆU CHO BIẾN
SET @i += 1
SET @j += @i

-- SET THÔNG QUA CÂU SELECT
DECLARE @minLuong INT = 0
SELECT @minLuong =  MIN(LUONG) FROM [dbo].[GIAOVIEN];

----------------------------------------------------------------------------
-- XUẤT RA SỐ LƯỢNG NGƯỜI THÂN CỦA GIÁO VIÊN 001
-- LƯU MÃ GIÁO VIÊN 003 LẠI
-- TÌM RA SỐ LƯỢNG NGƯỜI THÂN TƯƠNG ỨNG
DECLARE @maGV NCHAR(3) = '003'
SELECT COUNT(*) FROM [dbo].[NGUOITHAN]
WHERE [MAGV] = @maGV;

-- XUẤT RA TÊN GIÁO VIÊN CÓ LƯƠNG THẤP NHẤT
DECLARE @minSlary INT

SELECT @minSlary = MIN(LUONG) FROM [dbo].[GIAOVIEN]
SELECT [HOTEN] FROM [dbo].[GIAOVIEN]
WHERE [LUONG] = @minSlary;
