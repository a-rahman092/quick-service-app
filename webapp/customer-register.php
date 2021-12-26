<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$name = $obj['name'];
$email = $obj['email'];
$mobile = $obj['mobile'];
$password = $obj['password'];
$token = $obj['token'];

$CheckSQL = "SELECT * FROM customers WHERE mobile='$mobile'";

$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
if(isset($check)){
	 $emailExist = 'Mobile Already Exist, Please Try Login!';
	$existEmailJSON = json_encode($emailExist);
	 echo $existEmailJSON ; 
  }
 else{
	 $Sql_Query = "INSERT INTO customers (name,email,mobile,password,gender,address,device_token) VALUES ('$name','$email','$mobile','$password','','','$token')";
	 if(mysqli_query($con,$Sql_Query)){
		$MSG = 'User Registered Successfully' ;
		$json = json_encode($MSG);
		echo $json ;
	 }
	 else{
		$MSG = 'Something went wrong';
		$json = json_encode($MSG);
		echo $json ;
	 }
 }
 mysqli_close($con);
?>