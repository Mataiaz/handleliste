<?php
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "testtest";
    $table = $_POST['tName'];

    $action = $_POST['action'];

    // Connection to the db
    $conn = new mysqli($servername, $username, $password, $dbname);

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    
    // Create a table if table does not exist
    if('CREATE_TABLE' == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table (
            id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
            title VARCHAR(30) NOT NULL,
            amount VARCHAR(30) NOT NULL
            )";
        if ($conn->query($sql) === TRUE) {
            echo "success";
        } else {
            echo "s";
        }
        $conn->close();
        return;
    }
    
    // Get all values from table by id if it has values
    if('GET_ALL' == $action){
        $dbdata = array();
        $sql = "SELECT id, title, amount FROM $table ORDER BY id DESC";
        $result = $conn->query($sql);
        if ($result->num_rows > 0) {
            while($row = $result->fetch_assoc()) {
                $dbdata[]=$row;
            }
            echo json_encode($dbdata);
        } else {
            echo "Error : There is nothing to get";
        }
        $conn->close();
        return;
    }

    // Clear Table A, Insert all values from Table B to Table A Clear Table B
    if('REPLACE_ALL_ITEMS' == $action){
        $sql = "TRUNCATE TABLE Shop";
        $result = $conn->query($sql);
        $sql = "INSERT INTO Shop (SELECT * FROM $table)";
        $result = $conn->query($sql);
        $sql = "TRUNCATE TABLE $table";
        $result = $conn->query($sql);
        $conn->close();
        return;
    }

    // Add values to table with prepared statement
    if ('ADD_EMP' == $action) {
        $title = $_POST['title'];
        $amount = $_POST['amount'];
        $sql = "INSERT INTO $table(title, amount) VALUES (?, ?)";
        $stmt = $conn->prepare($sql);
        if ($stmt === false) {
            trigger_error($this->mysqli->error, E_USER_ERROR);
            return;
          }
        $stmt->bind_param("ss", $title, $amount);
        $stmt->execute();
        $stmt->close();
        return;
    }
    
    // Update values by id with prepared statement
    if ("UPDATE_EMP" == $action) {
        $emp_id = $_POST['emp_id'];
        $amount = $_POST["amount"];
        $title = $_POST["title"];
        $sql = "UPDATE $table SET amount = ?, title = ? WHERE id = ?";
        $stmt = $conn->prepare($sql);
        if ($stmt === false) {
            echo "Error : Could not prepare statement inside UPDATE_EMP";
            return;
        }
        $stmt->bind_param("ssi", $amount, $title, $emp_id);
        $stmt->execute();
        $stmt->close();
        return;
    }

    // Delete values by id with prepared statement
    if('DELETE_EMP' == $action){
        $emp_id = $_POST['emp_id'];
        $sql = "DELETE FROM $table WHERE id = ?";
        $stmt = $conn->prepare($sql);
        if ($stmt === false) {
            echo "Error : Could not prepare statement inside DELETE_EMP";
            return;
        }
        $stmt->bind_param("i", $emp_id);
        $stmt->execute();
        $stmt->close();
        return;
    }

    // Delete all values from the table
    if('DELETE_ALL_EMP' == $action){
        $sql = "TRUNCATE TABLE $table";
        $result = $conn->query($sql);
        $conn->close();
        return;
    }
?>