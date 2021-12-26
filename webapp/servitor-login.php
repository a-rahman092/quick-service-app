<?php
$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$mobile = $obj['mobile'];
$password = $obj['password'];

$CheckSQL = "SELECT * FROM service_person WHERE mobile='$mobile'";

$check = mysqli_fetch_array(mysqli_query($con,$CheckSQL));
if(isset($check)){
  $loginQuery = "select * from service_person where mobile = '$mobile' and password = '$password' ";
	
  $check = mysqli_fetch_array(mysqli_query($con,$loginQuery));
	if(isset($check)){
		 $onLoginSuccess = 'Login Matched';
		 $SuccessMSG = json_encode($onLoginSuccess);
		 echo $SuccessMSG ; 
	 }
	 else{
		$InvalidMSG = 'Invalid Username or Password Please Try Again' ;
		$InvalidMSGJSon = json_encode($InvalidMSG);
		echo $InvalidMSGJSon ;
	 } 
}
 else{
	$MSG = 'You did have permission to access';
	echo json_encode($MSG); 
 }







 

 mysqli_close($con);
?>

