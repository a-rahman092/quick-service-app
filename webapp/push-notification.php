<?php


define('API_ACCESS_KEY','AAAA3d6US80:APA91bH_0TVFGx86Rh7q2Jmd-jsVUCwkvhlcM7-WJG0QDa1hd12ZaZXHJK6Hqx0HvGJqoiX06CZbETubvaSEvAgFb_HNr9R6RRelC3rkY-6Q2wNw9TDDJH08Epd0TvyP4oeArKTL-_oQ');

$fcmUrl = 'https://fcm.googleapis.com/fcm/send';

$token = $_GET['token'];


$notification = [
	'title' => 'title',
  	'body' => 'body of message',
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



$json = json_encode($result);
echo $result ;

?>

