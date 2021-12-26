<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6";

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['submit'])) {
    
    $username = $_POST['username'];
    $password = $_POST['password'];

    $sql = "select * from admin where username = '$username' and password = '$password'";  
        $result = mysqli_query($con, $sql);  
        $row = mysqli_fetch_array($result, MYSQLI_ASSOC);  
        $count = mysqli_num_rows($result);  
          
        if($count == 1){  
            echo "<h1><center> Login successful </center></h1>";  
          	header("Location: https://quickserviceapp.educationhost.cloud/admin-dashboard.php");
        }  
        else{  
            echo "<h1> Login failed. Invalid username or password.</h1>";  
        }     

}
mysqli_close($con);
