<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "quanlybds_01";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

// Hàm để lấy ID của property từ property code
function getPropertyId($conn, $propertyCode) {
    $propertyIdSql = "SELECT `ID` FROM `dbo.property` WHERE `Property_Code` = ?";
    $stmt = $conn->prepare($propertyIdSql);

    if ($stmt === false) {
        die('Lỗi truy vấn SQL: ' . $conn->error);
    }

    $stmt->bind_param("s", $propertyCode);
    $stmt->execute();

    if ($stmt->error) {
        die('Lỗi thực thi truy vấn: ' . $stmt->error);
    }

    $stmt->bind_result($propertyId);
    $stmt->fetch();
    $stmt->close();

    return $propertyId;
}

// Lấy danh sách Property_Status_Name từ bảng dbo.property_status
$propertyStatusListSql = "SELECT `Property_Status_Name` FROM `dbo.property_status`";
$propertyStatusListResult = $conn->query($propertyStatusListSql);

if ($propertyStatusListResult === false) {
    die('Lỗi truy vấn SQL: ' . $conn->error);
}

$propertyStatusOptions = [];

while ($row = $propertyStatusListResult->fetch_assoc()) {
    $propertyStatusOptions[] = $row['Property_Status_Name'];
}

// Xử lý sự kiện thêm
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['add'])) {
    // Lấy dữ liệu từ form
    $customerName = $_POST['customer_name'];
    $yearOfBirth = $_POST['year_of_birth'];
    $ssn = $_POST['ssn'];
    $customerAddress = $_POST['customer_address'];
    $mobile = $_POST['mobile'];
    $propertyCode = $_POST['property_id'];
    $dateOfContract = $_POST['date_of_contract'];
    $deposit = $_POST['deposit'];
    $status = $_POST['status'];

    // Lấy giá từ bảng dbo.property
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

    // Lấy ID của property
    $propertyId = getPropertyId($conn, $propertyCode);

    // Tính giá trị còn lại
    $remain = $price - $deposit;

    // Tạo câu truy vấn INSERT
    $insertSql = "INSERT INTO `dbo.Full_Contract` (`Full_Contract_Code`, `Customer_Name`, `Year_Of_Birth`, `SSN`, `Customer_Address`, `Mobile`, `Property_ID`, `Date_Of_Contract`, `Price`, `Deposit`, `Remain`, `Status`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    
    $stmt = $conn->prepare($insertSql);
    $fullContractCode = generateFullContractCode($conn);
    
    $stmt->bind_param("ssssssssssss", $fullContractCode, $customerName, $yearOfBirth, $ssn, $customerAddress, $mobile, $propertyId, $dateOfContract, $price, $deposit, $remain, $status);

    if ($stmt->execute()) {
        echo "Thêm thành công";
    } else {
        echo "Lỗi thêm: " . $stmt->error;
    }
    
    $stmt->close();
}

// Hàm để tạo mã hợp đồng mới
function generateFullContractCode($conn) {
    $maxCodeSql = "SELECT MAX(SUBSTRING(Full_Contract_Code, 9, 6)) AS maxCode FROM `dbo.Full_Contract`";
    $result = $conn->query($maxCodeSql);

    if ($result !== false && $result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $maxCode = intval($row['maxCode']);

        $newCode = $maxCode + 1;
        $newCodeFormatted = str_pad($newCode, 5, '0', STR_PAD_LEFT);

        return "FC" . date('ym') . $newCodeFormatted;
    } else {
        return "FC" . date('ym') . "00001";
    }
}
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: white;
            padding: 1em;
            text-align: center;
        }

        footer {
            background-color: #333;
            color: white;
            padding: 1em;
            text-align: center;
            /* position: fixed; */
            bottom: 0;
            width: 100%;
            margin-top: 20px;
        }

        main {
            padding: 2em;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
         
        }
        .my-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            background-color: #3498db;
            color: #ffffff;
            border: 2px solid #3498db;
            transition: background-color 0.3s, color 0.3s;
            margin:35px;
        }
        .back-button {

            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
            text-align: center;
            text-decoration: none;
            border-radius: 5px;
            background-color: #3498db;
            color: #ffffff;
            border: 2px solid #3498db;
            transition: background-color 0.3s, color 0.3s;
            position: relative;
            left: 2%;
            
        }

        .my-button:hover {
            background-color: #ffffff;
            color: #3498db;
        }
        img{
            width: 100px;
            height: 100px;
        }
        footer{
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .ppc{
            position: relative;
            right: 40%;
            width: 200px;
            height: 100px;
            /* border-radius: 25px; */
        }
        .search-container {
            display: flex;
            max-width: 400px;
            margin: 20px;
            position: relative;
            left: 40%;
        }

        .search-input {
            flex: 1;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 5px 0 0 5px;
            outline: none;
            transition: border-color 0.3s;
        }

        .search-button {
            padding: 10px;
            font-size: 16px;
            background-color: #3498db;
            color: #ffffff;
            border: 1px solid #3498db;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
            transition: background-color 0.3s, color 0.3s;
        }

        .search-input:hover,
        .search-button:hover {
            border-color: #2980b9;
        }

        .search-button:hover {
            background-color: #ffffff;
            color: #3498db;
        }
        .input-container {
            width: 300px;
            margin-bottom: 1em;
        }

        label {
            display: block;
            margin-bottom: 0.5em;
            color: #333;
        }

        input {
            width: 100%;
            padding: 0.5em;
            font-size: 16px;
        }
        select {
            width: 107%;
            padding: 0.5em;
            font-size: 16px;
        }
        .divforflex{
            display:flex;
        }
        h2{
            display:flex;
            justify-content:center;
        }
    </style>
</head>
<body>

    <header>
        <img src="ppc.png" alt="" class="ppc">
    </header>
    <a href="index.php" class="back-button">Trở về</a>
    <h2>THÊM DANH SÁCH HỢP ĐỒNG</h2>
    <main>
    <form action="" method="post">
        <div class="input-container">
            <label for="hoTen">Họ và tên:</label>
            <input type="text" name="customer_name" required><br>
        </div>

        <div class="input-container">
            <label for="namSinh">Năm sinh:</label>
            <input type="text" name="year_of_birth" required><br>
        </div>
        <div class="input-container">
            <label for="namSinh">CCCD:</label>
            <input type="text" name="ssn" required><br>
        </div>
        <div class="input-container">
            <label for="namSinh">Địa chỉ:</label>
            <input type="text" name="customer_address" required><br>

        </div>
        <div class="input-container">
            <label for="namSinh">Số điện thoại:</label>
            <input type="text" name="mobile" required><br>

        </div>
        <div class="input-container">
            <label for="namSinh">Mã bất động sản</label>
            <select name="property_id" required >
        <?php
        $propertyListSql = "SELECT `Property_Code` FROM `dbo.property`";
        $propertyListResult = $conn->query($propertyListSql);

        if ($propertyListResult !== false && $propertyListResult->num_rows > 0) {
            while ($property = $propertyListResult->fetch_assoc()) {
                echo "<option value='" . $property['Property_Code'] . "'>" . $property['Property_Code'] . "</option>";
            }
        }
        ?>
    </select><br>
        </div>
        <div class="input-container">
            <label for="namSinh">Ngày lập hợp đồng:</label>
            <input type="text" name="date_of_contract" value="<?php echo date('Y-m-d'); ?>" required><br>
        </div>
        <div class="input-container">
            <label for="namSinh">Giá trị hợp đồng:</label>
            <select name="price" id="price" disabled><?php
        $propertyListSql = "SELECT `Price` FROM `dbo.property`";
        $propertyListResult = $conn->query($propertyListSql);

        if ($propertyListResult !== false && $propertyListResult->num_rows > 0) {
            while ($property = $propertyListResult->fetch_assoc()) {
                echo "<option value='" . $property['Price'] . "'>" . $property['Price'] . "</option>";
            }
        }
        ?></select>
        </div>
        <div class="input-container">
            <label for="namSinh">Số tiền đã cọc:</label>
            <input type="text" name="deposit" required><br>
        </div>
        <!-- <div class="input-container">
            <label for="namSinh">Số tiền còn lại:</label>
            <input type="text" id="valuecontract" name="valuecontract" placeholder="">
        </div> -->
        <div class="input-container" >
            <label for="namSinh">Trạng thái:</label>
            <select name="status" id="status" >
        <?php
        foreach ($propertyStatusOptions as $statusOption) {
            echo "<option value='$statusOption'>$statusOption</option>";
        }
        ?>
    </select><br>
        </div>
        <div class="divforflex">
        <a href="#" class="my-button">HỦY</a> 
        <input class="my-button" type="submit" name="add" value="LƯU">
        </div>
      
        </form>
    </main>
     <script>
        // Get the select box and price field elements
        var propertySelectBox = document.querySelector('select[name="property_id"]');
        var priceField = document.querySelector('select[name="price"]');


        // Listen for changes on the select box
        propertySelectBox.addEventListener('change', function() {
    // Get the selected property code
        var propertyCode = this.value;

        // Make an AJAX request to the server to fetch the price
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'get_price.php?property_code=' + propertyCode, true);
        xhr.onload = function() {
            if (this.status == 200) {
                // Update the price field with the fetched price
                priceField.value = this.responseText;
            }
        };
        xhr.send();
    });



    //Get status Property
    // Get the select box and status field elements
var propertySelectBox = document.querySelector('select[name="property_id"]');
var statusField = document.querySelector('select[name="status"]');

// Listen for changes on the select box
propertySelectBox.addEventListener('change', function() {
    // Get the selected property code
    var propertyCode = this.value;

    // Make an AJAX request to the server to fetch the status
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'get_status.php?property_code=' + propertyCode, true);
    xhr.onload = function() {
        if (this.status == 200) {
            // Update the status field with the fetched status
            statusField.value = this.responseText;
        }
    };
    xhr.send();
});

     </script>
    <script>
function confirmSubmission() {
    return new Promise((resolve, reject) => {
        Swal.fire({
            title: 'Are you sure?',
            text: "You are about to submit the form.",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, submit it!'
        }).then((result) => {
            if (result.isConfirmed) {
                resolve(true);
            } else {
                resolve(false);
            }
        });
    });
}
</script>

    <footer>
        <p>Copyright by Team SDESIGN</p>
        <img src="Logo.png" alt="">
    </footer>

</body>
</html>