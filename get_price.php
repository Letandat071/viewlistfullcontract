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

$propertySql = "SELECT `Price` FROM `dbo.property` WHERE `Property_Code` = ?";
$stmt = $conn->prepare($propertySql);

if ($stmt === false) {
    die('Lỗi truy vấn SQL: ' . $conn->error);
}

$stmt->bind_param("s", $propertyCode);
$stmt->execute();

if ($stmt->error) {
    die('Lỗi thực thi truy vấn: ' . $stmt->error);
}

$stmt->bind_result($price);
$stmt->fetch();
$stmt->close();

echo $price;
?>
