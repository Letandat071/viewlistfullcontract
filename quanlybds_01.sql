-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th10 23, 2023 lúc 12:58 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `quanlybds_01`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.account`
--

CREATE TABLE `dbo.account` (
  `ID` tinyint(4) DEFAULT NULL,
  `Username` varchar(14) DEFAULT NULL,
  `Password` mediumint(9) DEFAULT NULL,
  `Full_Name` varchar(23) DEFAULT NULL,
  `Role` varchar(5) DEFAULT NULL,
  `IsActive` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.account`
--

INSERT INTO `dbo.account` (`ID`, `Username`, `Password`, `Full_Name`, `Role`, `IsActive`) VALUES
(1, 'lythihuyenchau', 123456, 'Lý Thị Huyền Châu', 'ADMIN', 1),
(2, 'nguyenvantuan', 123456, 'Nguyễn Văn Tuấn', 'SALE', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.city`
--

CREATE TABLE `dbo.city` (
  `ID` tinyint(4) DEFAULT NULL,
  `City_Name` varchar(14) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.city`
--

INSERT INTO `dbo.city` (`ID`, `City_Name`) VALUES
(1, 'Hồ chính minh'),
(2, 'Hà nội'),
(3, 'Đà Nẵng'),
(4, 'Bình Dương'),
(5, 'Vũng Tàu'),
(6, 'Bắc Giang'),
(7, 'Đồng Nai'),
(8, 'Cà Mau'),
(9, 'Long An'),
(10, 'Cần Thơ');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.district`
--

CREATE TABLE `dbo.district` (
  `ID` tinyint(4) DEFAULT NULL,
  `City_ID` tinyint(4) DEFAULT NULL,
  `District_Name` varchar(21) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.district`
--

INSERT INTO `dbo.district` (`ID`, `City_ID`, `District_Name`) VALUES
(1, 1, 'Quận Bình Tân'),
(2, 1, 'Quận Bình Thạnh'),
(3, 1, 'Quận 1'),
(4, 1, 'Quận 2'),
(5, 1, 'Quận 3'),
(6, 1, 'Quận 4'),
(7, 1, 'Quận 5'),
(8, 1, 'Quận 6'),
(9, 1, 'Quận 7'),
(10, 1, 'Quận 8'),
(11, 9, 'Huyện Bến Lức'),
(12, 9, 'Huyện Đức Hòa'),
(14, 9, 'Huyện Đức Huệ'),
(15, 4, 'Huyện Bến Cát'),
(16, 4, 'Huyện Dầu Tiếng'),
(17, 4, 'Huyện Thuận An'),
(18, 4, '');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.full_contract`
--

CREATE TABLE `dbo.full_contract` (
  `ID` tinyint(4) NOT NULL,
  `Full_Contract_Code` varchar(11) DEFAULT NULL,
  `Customer_Name` varchar(23) DEFAULT NULL,
  `Year_Of_Birth` smallint(6) DEFAULT NULL,
  `SSN` int(11) DEFAULT NULL,
  `Customer_Address` varchar(61) DEFAULT NULL,
  `Mobile` bigint(20) DEFAULT NULL,
  `Property_ID` tinyint(4) DEFAULT NULL,
  `Date_Of_Contract` varchar(10) DEFAULT NULL,
  `Price` bigint(20) DEFAULT NULL,
  `Deposit` int(11) DEFAULT NULL,
  `Remain` bigint(20) DEFAULT NULL,
  `Status` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.full_contract`
--

INSERT INTO `dbo.full_contract` (`ID`, `Full_Contract_Code`, `Customer_Name`, `Year_Of_Birth`, `SSN`, `Customer_Address`, `Mobile`, `Property_ID`, `Date_Of_Contract`, `Price`, `Deposit`, `Remain`, `Status`) VALUES
(41, 'FC231100001', 'Lê  Tấn Đạt', 2003, 23, 'Quận bình thạnh, thành phố hồ chí minh', 123456, 1, '2023-11-16', 1000000000, 670000000, 330000000, 'Đang cọc đầy đủ'),
(42, 'FC231100002', 'Phan hoàng khang', 1800, 321, 'Gò Vấp, Hồ chính minh', 12345678, 3, '2023-11-16', 5000000000, 80000000, 4920000000, 'Đã bán trả góp'),
(61, 'FC231100003', 'Hồ Hoàng Khang', 2001, 12312313, '12312312313', 12312312312321, 18, '2023-11-23', 2800000000, 12312313, 2787687687, 'Không hiển thị'),
(62, 'FC231100004', 'Phạm Nhật Hoàng', 32767, 12312313, '123123213213', 12312321313, 1, '2023-11-23', 2500000000, 190238120, 2309761880, 'Đang bán'),
(73, 'FC231100005', 'Triệu Thành Công', 2003, 2147483647, '403/11 Country Road 3, Blk 8, Binh Hung Hoa Ward', 1231232131, 10, '2023-11-23', 1900000000, 2147483647, -10412312313, 'Không hiển thị'),
(74, 'FC231100006', 'Phạm Công Thành', 2003, 45645645, 'Xuan O A, Vo Cuong', 1231231312313, 1, '2023-11-23', 2500000000, 87878787, 2412121213, 'Đang bán'),
(75, 'FC231100007', 'Huỳnh Hữu Thiện', 2001, 2147483647, 'No. 26 Chi Lang, Ward 9, Da Lat', 164444222, 15, '2023-11-23', 1200000000, 2147483647, -11631281283, 'Đã bán thanh toán một lần'),
(80, 'FC231100008', '12312', 3123, 123123, '12312312', 312312, 1, '2023-11-23', 2500000000, 123123, 2499876877, 'Đang bán'),
(81, 'FC231100009', '123123213', 32767, 123123, '123123', 123123, 10, '2023-11-23', 1900000000, 121233, 1899878767, 'Không hiển thị');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.installment_contract`
--

CREATE TABLE `dbo.installment_contract` (
  `ID` tinyint(4) DEFAULT NULL,
  `Installment_Contract_Code` varchar(10) DEFAULT NULL,
  `Customer_Name` varchar(16) DEFAULT NULL,
  `Year_Of_Birth` smallint(6) DEFAULT NULL,
  `SSN` int(11) DEFAULT NULL,
  `Customer_Address` varchar(29) DEFAULT NULL,
  `Mobile` bigint(20) DEFAULT NULL,
  `Property_ID` tinyint(4) DEFAULT NULL,
  `Date_Of_Contract` varchar(10) DEFAULT NULL,
  `Installment_Payment_Method` varchar(6) DEFAULT NULL,
  `Payment_Period` tinyint(4) DEFAULT NULL,
  `Price` bigint(20) DEFAULT NULL,
  `Deposit` int(11) DEFAULT NULL,
  `Loan_Amount` bigint(20) DEFAULT NULL,
  `Taken` tinyint(4) DEFAULT NULL,
  `Remain` bigint(20) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.installment_contract`
--

INSERT INTO `dbo.installment_contract` (`ID`, `Installment_Contract_Code`, `Customer_Name`, `Year_Of_Birth`, `SSN`, `Customer_Address`, `Mobile`, `Property_ID`, `Date_Of_Contract`, `Installment_Payment_Method`, `Payment_Period`, `Price`, `Deposit`, `Loan_Amount`, `Taken`, `Remain`, `Status`) VALUES
(1, 'IC22110001', 'Lâm Bá Thắng', 1980, 123467647, '1 Lê Lợi, Quận 1, TP.HCM', 918273378, 3, '2019-10-23', 'Tháng', 12, 5000000000, 500000000, 4500000000, 0, 4500000000, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.property`
--

CREATE TABLE `dbo.property` (
  `ID` tinyint(4) DEFAULT NULL,
  `Property_Code` varchar(14) DEFAULT NULL,
  `Property_Name` varchar(31) DEFAULT NULL,
  `Property_Type_ID` tinyint(4) DEFAULT NULL,
  `Description` text DEFAULT NULL,
  `District_ID` tinyint(4) DEFAULT NULL,
  `Address` varchar(91) DEFAULT NULL,
  `Area` varchar(3) DEFAULT NULL,
  `Bed_Room` varchar(1) DEFAULT NULL,
  `Bath_Room` varchar(1) DEFAULT NULL,
  `Price` varchar(10) DEFAULT NULL,
  `Installment_Rate` varchar(4) DEFAULT NULL,
  `Avatar` varchar(16) DEFAULT NULL,
  `Album` varchar(24) DEFAULT NULL,
  `Property_Status_ID` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.property`
--

INSERT INTO `dbo.property` (`ID`, `Property_Code`, `Property_Name`, `Property_Type_ID`, `Description`, `District_ID`, `Address`, `Area`, `Bed_Room`, `Bath_Room`, `Price`, `Installment_Rate`, `Avatar`, `Album`, `Property_Status_ID`) VALUES
(1, 'PT2311QBT00001', 'NGÔI NHÀ THANH LỊCH', 3, 'Ngôi nhà hiện đại và sang trọng với các phòng rộng rãi và khu vườn đẹp.', 1, '123 Đường Trần Hưng Đạo, Quận Bình Thạnh, Thành phố Hồ Chí Minh', '200', '4', '5', '2500000000', '10.9', 'elegant001.jpg', 'elegant002.jpg;elegant00', 6),
(2, 'PT2311QBT00002', 'NGÔI NHÀ THANH LỊCH', 3, 'Ngôi nhà hiện đại và sang trọng với các phòng rộng rãi và khu vườn đẹp.', 1, '123 Đường Trần Hưng Đạo, Quận Bình Thạnh, Thành phố Hồ Chí Minh', '200', '4', '5', '2500000000', '10.9', 'elegant001.jpg', 'elegant002.jpg;elegant00', 6),
(3, 'PT2311QBT00003', 'BIỆT THỰ NĂNG ĐỘNG', 3, 'Một biệt thự nắng và sáng với tầm nhìn tuyệt vời của đường phố thành phố.', 2, '456 Đường Nguyễn Văn Linh, Quận Bình Thạnh, Thành phố Hồ Chí Minh', '180', '3', '4', '1800000000', '9.99', 'sunny001.jpg', 'sunny002.jpg;sunny003.jp', 6),
(4, 'PT2311QBT00004', 'NGÔI NHÀ TRÊN ĐỒNG CỎ XANH', 3, 'Bao quanh bởi những cánh đồng cỏ xanh, ngôi nhà này mang lại môi trường sống yên bình và thanh lịch.', 3, '789 Đường Lê Văn Sỹ, Quận Bình Thạnh, Thành phố Hồ Chí Minh', '150', '2', '3', '1200000000', '8.50', 'meadow001.jpg', 'meadow002.jpg;meadow003.', 2),
(5, 'PT2311QTD00005', 'NHÀ NGHỈ BÊN SÔNG', 3, 'Một ngôi nhà quyến rũ nằm bên bờ sông, mang đến một bối cảnh thư giãn và đẹp như tranh.', 4, '1010 Đường Võ Văn Kiệt, Quận Thủ Đức, Thành phố Hồ Chí Minh', '120', '3', '2', '1400000000', '8.75', 'riverside001.jpg', 'riverside002.jpg;riversi', 3),
(6, 'PT2311Q0100006', 'NGÔI NHÀ HIỆN ĐẠI TẠI QUẬN 1', 3, 'Mô tả cho ngôi nhà 6', 1, 'Dự án ABC Garden, Quận 1, Thành phố Hồ Chí Minh', '110', '4', '2', '1600000000', '9.25', 'modern001.jpg', 'modern002.jpg;modern003.', 4),
(7, 'PT2311QBT00007', 'NGÔI NHÀ THANH MẢNH Ở QUẬN BÌNH', 3, 'Mô tả cho ngôi nhà 7', 2, 'Dự án XYZ Garden, Quận Bình Thạnh, Thành phố Hồ Chí Minh', '120', '2', '4', '1400000000', '8.00', 'slim001.jpg', 'slim002.jpg;slim003.jpg;', 6),
(8, 'PT2311Q0300008', 'BIỆT THỰ CÓ VUÔNG TRÒN TẠI QUẬN', 3, 'Mô tả cho ngôi nhà 8', 3, 'Dự án UVW Garden, Quận 3, Thành phố Hồ Chí Minh', '130', '3', '3', '1700000000', '9.50', 'unique001.jpg', 'unique002.jpg;unique003.', 5),
(9, 'PT2311Q0400009', 'NGÔI NHÀ THIÊN NHIÊN TẠI QUẬN 4', 3, 'Mô tả cho ngôi nhà 9', 4, 'Dự án XYZ Garden, Quận 4, Thành phố Hồ Chí Minh', '140', '4', '2', '1800000000', '10.0', 'nature001.jpg', 'nature002.jpg;nature003.', 4),
(10, 'PT2311Q0500010', 'NHÀ PHỐ GARDEN KHANG ĐIỀN 10', 3, 'Mô tả cho ngôi nhà 10', 5, 'Dự án XYZ Garden, Quận 5, Thành phố Hồ Chí Minh', '150', '2', '4', '1900000000', '10.5', 'garden001.jpg', 'garden002.jpg;garden003.', 4),
(11, 'PT2311Q0600011', 'NHÀ PHỐ XANH Ở QUẬN 6', 3, 'Mô tả cho ngôi nhà 11', 6, 'Dự án XYZ Garden, Quận 6, Thành phố Hồ Chí Minh', '160', '3', '3', '2000000000', '11.0', 'green001.jpg', 'green002.jpg;green003.jp', 3),
(12, 'PT2311Q0700012', 'CĂN HỘ VIEW BIỂN TẠI QUẬN 7', 2, 'Mô tả cho căn hộ 12', 7, 'Dự án XYZ Apartment, Quận 7, Thành phố Hồ Chí Minh', '70', '1', '1', '900000000', '7.50', 'seaview001.jpg', 'seaview002.jpg;seaview00', 2),
(13, 'PT2311Q0800013', 'BIỆT THỰ PHONG CÁCH Ở QUẬN 8', 3, 'Mô tả cho biệt thự 13', 8, 'Dự án XYZ Villa, Quận 8, Thành phố Hồ Chí Minh', '180', '4', '5', '3000000000', '12.5', 'stylish001.jpg', 'stylish002.jpg;stylish00', 1),
(14, 'PT2311Q0900014', 'NGÔI NHÀ HIỆN ĐẠI Ở QUẬN 9', 3, 'Mô tả cho ngôi nhà 14', 9, 'Dự án XYZ Garden, Quận 9, Thành phố Hồ Chí Minh', '200', '5', '4', '3500000000', '13.5', 'modern001.jpg', 'modern002.jpg;modern003.', 1),
(15, 'PT2311BT100000', 'CĂN HỘ BÌNH TÂN 15', 2, 'Mô tả cho căn hộ 15', 10, 'Dự án XYZ Apartment, Quận Bình Tân, Thành phố Hồ Chí Minh', '90', '2', '2', '1200000000', '8.75', 'bt_apartment001.', 'bt_apartment002.jpg;bt_a', 2),
(16, 'PT2311QTD00016', 'NHÀ PHỐ THÔNG MINH Ở THỦ ĐỨC', 3, 'Mô tả cho ngôi nhà 16', 11, 'Dự án XYZ Smart Home, Quận Thủ Đức, Thành phố Hồ Chí Minh', '120', '3', '3', '1800000000', '9.99', 'smart_home001.jp', 'smart_home002.jpg;smart_', 3),
(17, 'PT2311Q0100017', 'CĂN HỘ LUXURY Ở QUẬN 1', 2, 'Mô tả cho căn hộ 17', 1, 'Dự án XYZ Luxury Residence, Quận 1, Thành phố Hồ Chí Minh', '150', '3', '3', '2500000000', '11.9', 'luxury001.jpg', 'luxury002.jpg;luxury003.', 6),
(18, 'PT2311Q0200018', 'NGÔI NHÀ VIEW SÔNG Ở QUẬN 2', 3, 'Mô tả cho ngôi nhà 18', 2, 'Dự án XYZ River View, Quận 2, Thành phố Hồ Chí Minh', '180', '4', '4', '2800000000', '12.9', 'riverview001.jpg', 'riverview002.jpg;rivervi', 4),
(19, 'PT2311Q0300019', 'NHÀ PHỐ CAO CẤP Ở QUẬN 3', 3, 'Mô tả cho ngôi nhà 19', 3, 'Dự án XYZ Premium Home, Quận 3, Thành phố Hồ Chí Minh', '200', '5', '5', '3500000000', '14.9', 'premium_home001.', 'premium_home002.jpg;prem', 5),
(20, 'PT2311Q0400020', 'BIỆT THỰ VƯỜN Ở QUẬN 4', 3, 'Mô tả cho biệt thự 20', 4, 'Dự án XYZ Garden Villa, Quận 4, Thành phố Hồ Chí Minh', '250', '6', '6', '4500000000', '16.9', 'garden_villa001.', 'garden_villa002.jpg;gard', 6);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.property_service`
--

CREATE TABLE `dbo.property_service` (
  `ID` tinyint(4) DEFAULT NULL,
  `Service_ID` tinyint(4) DEFAULT NULL,
  `Property_ID` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.property_service`
--

INSERT INTO `dbo.property_service` (`ID`, `Service_ID`, `Property_ID`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 1, 2),
(6, 2, 2),
(7, 1, 3),
(8, 3, 3),
(9, 4, 3),
(15, 1, 11),
(16, 2, 11);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.property_status`
--

CREATE TABLE `dbo.property_status` (
  `ID` tinyint(4) DEFAULT NULL,
  `Property_Status_Name` varchar(33) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.property_status`
--

INSERT INTO `dbo.property_status` (`ID`, `Property_Status_Name`) VALUES
(1, 'Đang bán'),
(2, 'Đã bán thanh toán một lần'),
(3, 'Đã bán trả góp'),
(4, 'Không hiển thị'),
(5, 'Hết hạn để bán'),
(6, 'Đang cọc đầy đủ'),
(7, 'Đang cọc trả góp');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.property_type`
--

CREATE TABLE `dbo.property_type` (
  `ID` tinyint(4) DEFAULT NULL,
  `Property_Type_Name` varchar(21) DEFAULT NULL,
  `Property_Amount` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.property_type`
--

INSERT INTO `dbo.property_type` (`ID`, `Property_Type_Name`, `Property_Amount`) VALUES
(1, 'Chung cư', 1),
(2, 'Căn hộ dịch vụ', 1),
(3, 'Nhà riêng', 1),
(4, 'Villa', 0),
(5, 'Studio', 0),
(6, 'Office', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `dbo.service`
--

CREATE TABLE `dbo.service` (
  `ID` tinyint(4) DEFAULT NULL,
  `Service_Name` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `dbo.service`
--

INSERT INTO `dbo.service` (`ID`, `Service_Name`) VALUES
(1, 'Ban công'),
(2, 'Thang máy'),
(3, 'Nhà bếp'),
(4, 'Hồ bơi'),
(5, 'Wifi'),
(6, 'Chỗ đậu xe');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `dbo.full_contract`
--
ALTER TABLE `dbo.full_contract`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `dbo.full_contract`
--
ALTER TABLE `dbo.full_contract`
  MODIFY `ID` tinyint(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
