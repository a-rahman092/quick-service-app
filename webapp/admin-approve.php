<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6";

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['submit'])) {
    $mobile = $_POST['mobile'];

    $CheckSQL = "UPDATE service_person SET verified='YES',availability='YES' WHERE mobile='$mobile'";
    $check = mysqli_query($con, $CheckSQL);
    if (isset($check)) {
        $emailExist = 'Service Provider Approved Successfully';
        $existEmailJSON = json_encode($emailExist);
        echo $existEmailJSON;
      header('Location:https://www.quickserviceapp.educationhost.cloud/admin-dashboard.php');
    } 
  else {
            $MSG = 'Something went wrong';
            $json = json_encode($MSG);
            echo $json;
  }
}
mysqli_close($con);
