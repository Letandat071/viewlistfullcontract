<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "quanlybds_01";

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Kết nối thất bại: " . $conn->connect_error);
}

// Xử lý sự kiện xóa
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['delete'])) {
    if (!empty($_POST['contract_ids'])) {
        $contractIds = implode(",", $_POST['contract_ids']);
        $deleteSql = "DELETE FROM `dbo.Full_Contract` WHERE ID IN ($contractIds)";
        
        if ($conn->query($deleteSql) === TRUE) {
            echo "Xóa thành công";
        } else {
            echo "Lỗi xóa: " . $conn->error;
        }
    } else {
        echo "Chưa chọn hợp đồng nào để xóa";
    }
}

// Thực hiện tìm kiếm
$searchTerm = isset($_GET['search']) ? $_GET['search'] : '';
$sql = "SELECT * FROM `dbo.Full_Contract` WHERE 
        Full_Contract_Code LIKE ? OR
        Customer_Name LIKE ? OR
        Year_Of_Birth LIKE ? OR
        SSN LIKE ? OR
        Customer_Address LIKE ? OR
        Mobile LIKE ? OR
        Property_ID LIKE ? OR
        Date_Of_Contract LIKE ? OR
        Price LIKE ? OR
        Deposit LIKE ? OR
        Remain LIKE ? OR
        Status LIKE ?";

$stmt = $conn->prepare($sql);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
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
        }

        main {
            padding: 2em;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1em;
            margin-bottom:20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #333;
            color: white;
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
            position: relative;
            left: 45%;
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
        h2{
            display:flex;
            justify-content:center;
        }
    </style>
    </style>
</head>
<body>

    <header>
        <img src="ppc.png" alt="" class="ppc">
    </header>

    <main>
        <h2>DANH SÁCH HỢP ĐỒNG</h2>
        <div class="search-container">
            <form action="" method="get">
                <input type="text" class="search-input" name="search" placeholder="Nhập từ khóa..." value="<?php echo htmlspecialchars($searchTerm); ?>">
                <button type="submit" class="search-button">Tìm Kiếm</button>
            </form>
        </div>

        <?php
        // Check if the statement was prepared successfully
        if ($stmt) {
            // Bind parameters and execute the statement
            $searchTermPattern = "%$searchTerm%";
            $stmt->bind_param("ssssssssssss", 
                $searchTermPattern, $searchTermPattern, $searchTermPattern, 
                $searchTermPattern, $searchTermPattern, $searchTermPattern, 
                $searchTermPattern, $searchTermPattern, $searchTermPattern, 
                $searchTermPattern, $searchTermPattern, $searchTermPattern
            );

            $stmt->execute();
            $result = $stmt->get_result();

            // Output the search form
            echo "<form action='' method='post'>";
            echo "<table class='tab'>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full_Contract_Code</th>
                            <th>Customer_Name</th>
                            <th>Year_Of_Birth</th>
                            <th>SSN</th>
                            <th>Customer_Address</th>
                            <th>Mobile</th>
                            <th>Property_ID</th>
                            <th>Date_Of_Contract</th>
                            <th>Price</th>
                            <th>Deposit</th>
                            <th>Remain</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>";

            // Output the table rows based on the search result
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['ID']}</td>
                        <td>{$row['Full_Contract_Code']}</td>
                        <td>{$row['Customer_Name']}</td>
                        <td>{$row['Year_Of_Birth']}</td>
                        <td>{$row['SSN']}</td>
                        <td>{$row['Customer_Address']}</td>
                        <td>{$row['Mobile']}</td>
                        <td>{$row['Property_ID']}</td>
                        <td>{$row['Date_Of_Contract']}</td>
                        <td>{$row['Price']}</td>
                        <td>{$row['Deposit']}</td>
                        <td>{$row['Remain']}</td>
                        <td>{$row['Status']}</td>
                        <td><input type='checkbox' name='contract_ids[]' value='{$row['ID']}'></td>
                    </tr>";
            }

            // Close the table and form tags
            echo "</tbody></table>";
            
          

            // Close the statement
            $stmt->close();

            // Thêm nút "Thêm" và "Xóa" phía sau
            echo "
                <div>
                 <a href='add_contract.php' class='my-button'>Thêm</a>
                 <input type='submit' class='my-button' name='delete' value='Xóa'></form>  
                 <input type='submit' class='my-button' name='' value='Sửa'></form>
                 </div>";
        } else {
            // Error handling if the statement was not prepared successfully
            echo "Lỗi chuẩn bị truy vấn: " . $conn->error;
        }

        // Close the connection
        $conn->close();
        ?>
    </main>

    <footer>
        <p>Copyright by SDESIGN</p>
        <img src="Logo.png" alt="">
    </footer>

</body>
</html>
