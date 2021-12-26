<?php
define('API_ACCESS_KEY','AAAA3d6US80:APA91bH_0TVFGx86Rh7q2Jmd-jsVUCwkvhlcM7-WJG0QDa1hd12ZaZXHJK6Hqx0HvGJqoiX06CZbETubvaSEvAgFb_HNr9R6RRelC3rkY-6Q2wNw9TDDJH08Epd0TvyP4oeArKTL-_oQ');

$fcmUrl = 'https://fcm.googleapis.com/fcm/send';

$HostName = "localhost";
$DatabaseName = "yvxrlaix_quickservice";
$HostUser = "yvxrlaix_quickservice";
$HostPass = "S5up3oV6"; 

$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);

$json = file_get_contents('php://input');
$obj = json_decode($json,true);

$sno = $obj['sno'];
$cost = $obj['cost'];
$servitormobile = $obj['servitormobile'];

$Sql_Query = "SELECT customer_mobile FROM orders WHERE sno='$sno'";
$result = mysqli_query($con, $Sql_Query);

if (mysqli_num_rows($result) > 0) {
  while($row = mysqli_fetch_assoc($result)) {
    $mobile = $row["customer_mobile"];
  }
  
}

$Sql_Query = "SELECT c.device_token FROM customers c INNER JOIN orders o on c.mobile = o.customer_mobile WHERE c.mobile='$mobile'";
$result = mysqli_query($con, $Sql_Query);

if (mysqli_num_rows($result) > 0) {
  while($row = mysqli_fetch_assoc($result)) {
    $token = $row["device_token"];
  }
  
} 

$Sql_Query = "UPDATE orders SET total_cost='$cost', status='Completed' WHERE sno='$sno';UPDATE service_person SET availability='YES' WHERE mobile='$servitormobile'";
	if(mysqli_multi_query($con,$Sql_Query)){
      $notification = [
	'title' => 'Service Completed',
  	'body' => $servicename,
  	'icon' => 'myIcon',
  	'sound' => 'mySound'
];

$extraNotificationData = ["message" => $notification,"moredata" =>'dd'];

$fcmNotification = [
//'registration_ids' => $tokenList, //multple token array
'to'        =>$token, 
'notification' => $notification,
'data' => $extraNotificationData
];

$headers = [
'Authorization: key=' . API_ACCESS_KEY,
'Content-Type: application/json'
];


$ch = curl_init();
curl_setopt($ch, CURLOPT_URL,$fcmUrl);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fcmNotification));
$result = curl_exec($ch);
curl_close($ch);
		$MSG = 'You have Successfully completed your service' ;
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