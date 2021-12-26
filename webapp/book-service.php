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

$servicename = $obj['servicename'];
$serviceperson = $obj['serviceperson'];
$cost = $obj['cost'];
$mobile = $obj['mobile'];
$servitormobile = $obj['servitormobile'];
$name = $obj['name'];
$address = $obj['address'];

$Sql_Query = "SELECT c.device_token FROM customers c INNER JOIN service_person s on c.mobile = s.mobile WHERE c.mobile='$servitormobile'";
$result = mysqli_query($con, $Sql_Query);

if (mysqli_num_rows($result) > 0) {
  while($row = mysqli_fetch_assoc($result)) {
    $token = $row["device_token"];
  }
  
} 


$Sql_Query = "INSERT INTO orders (customer_name, customer_mobile, customer_address, service_name, servitor_name, servitor_mobile, total_cost, status) VALUES ('$name','$mobile','$address','$servicename','$serviceperson','$servitormobile','$cost','Pending');UPDATE service_person SET availability = 'NO' WHERE mobile = $servitormobile;";

	 if(mysqli_multi_query($con,$Sql_Query)){
       $notification = [
	'title' => 'New Order Received',
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



		$MSG = 'Service Booked Successfully' ;
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