<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 
$components = "";

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

$mobile =  $_GET['mobile'];
$status = $_GET['status'];

$sql = "SELECT * FROM orders WHERE status='$status' AND customer_mobile='$mobile'";
$db_data = array(); 
$result = mysqli_query($con, $sql);

if (mysqli_num_rows($result) > 0) {
  while($row = mysqli_fetch_assoc($result)) {
    $db_data[] = $row;
  }
  echo json_encode($db_data);
} 
mysqli_close($con);
?>