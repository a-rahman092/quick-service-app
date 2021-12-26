<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$mobile = $obj['mobile'];
$name = $obj['name'];

$Sql_Query = "UPDATE customers SET name='$name' WHERE mobile = '$mobile'";
	if(mysqli_query($con,$Sql_Query)){
		$MSG = 'Name Changed Successfully' ;
		$json = json_encode($MSG);
		echo $json ;
	 }
	 else{
		$MSG = 'Something went wrong';
		$json = json_encode($MSG);
		echo $json ;
	 }
 mysqli_close($con);
?>