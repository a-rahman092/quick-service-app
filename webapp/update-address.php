<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$address = $obj['address'];
$mobile = $obj['mobile'];

$Sql_Query = "UPDATE customers SET address='$address' WHERE mobile='$mobile'";
	if(mysqli_query($con,$Sql_Query)){
		$MSG = 'Address Changed Successfully' ;
		$json = json_encode($MSG);
		echo $json ;
	 }
	 else{
		$MSG = 'Something went wrong';
		$json = json_encode($rating);
		echo $json ;
	 }
 mysqli_close($con);
?>