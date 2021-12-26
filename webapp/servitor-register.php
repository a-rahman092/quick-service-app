<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6";

$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);

if (isset($_POST['submit'])) {
    if (($_FILES['photo']['name'] != "")) {
        $target_dir = "photos/";
        $file = $_FILES['photo']['name'];
        $path = pathinfo($file);
        $filename = $_POST['mobile'];
        $ext = $path['extension'];
        $temp_name = $_FILES['photo']['tmp_name'];
        $path_filename_ext = $target_dir . $filename . "." . $ext;
        $type = 'photos/' . $file;
        // Check if file already exists
        if (file_exists($path_filename_ext)) {
            echo "Sorry, file already exists.";
        } else {
            move_uploaded_file($temp_name, $path_filename_ext);
            echo "Congratulations! File Uploaded Successfully.";
        }
    }
    $name = $_POST['name'];
    $mobile = $_POST['mobile'];
    $service = $_POST['service'];
    $cost = $_POST['cost'];

    $CheckSQL = "SELECT * FROM service_person WHERE mobile='$mobile'";
    $check = mysqli_fetch_array(mysqli_query($con, $CheckSQL));
    if (isset($check)) {
        $emailExist = 'Mobile Already Exist, Please Try Login!';
        $existEmailJSON = json_encode($emailExist);
        echo $existEmailJSON;
    } else {
        $Sql_Query = "INSERT INTO service_person (name,service_providing,mobile,cost,verified,photo) VALUES ('$name','$service','$mobile','$cost','NO','https://www.quickserviceapp.educationhost.cloud/photos/$filename.$ext')";
        if (mysqli_query($con, $Sql_Query)) {
            $MSG = 'User Registered Successfully';
            $json = json_encode($MSG);
            echo $json;
        } else {
            $MSG = 'Something went wrong';
            $json = json_encode($MSG);
            echo $json;
        }
    }

}
mysqli_close($con);
