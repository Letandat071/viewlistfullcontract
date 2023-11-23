<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "quanlybds_01";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

$propertyCode = $_GET['property_code'];

$propertySql = "SELECT `Property_Status_ID` FROM `dbo.property` WHERE `Property_Code` = ?";
$stmt = $conn->prepare($propertySql);

if ($stmt === false) {
    die('Lỗi truy vấn SQL: ' . $conn->error);
}

$stmt->bind_param("s", $propertyCode);
$stmt->execute();

if ($stmt->error) {
    die('Lỗi thực thi truy vấn: ' . $stmt->error);
}

$stmt->bind_result($propertyStatusId);
$stmt->fetch();
$stmt->close();

$statusSql = "SELECT `Property_Status_Name` FROM `dbo.property_status` WHERE `ID` = ?";
$stmt = $conn->prepare($statusSql);

if ($stmt === false) {
    die('Lỗi truy vấn SQL: ' . $conn->error);
}

$stmt->bind_param("s", $propertyStatusId);
$stmt->execute();

if ($stmt->error) {
    die('Lỗi thực thi truy vấn: ' . $stmt->error);
}

$stmt->bind_result($propertyStatusName);
$stmt->fetch();
$stmt->close();

echo $propertyStatusName;
?>
