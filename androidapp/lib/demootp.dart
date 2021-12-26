import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  

  @override
  void initState() {
    super.initState();
    /*_saveDeviceToken();*/
  
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Notification"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () => {
                getQue()
              },
              child: Text('Send Notification'),
            ),
          ],
        ),
      ),
    );
  }
  /*_saveDeviceToken() async {
    String token1 = await _fcm.getToken(); 

  }*/

  Future getQue() async {
    String token = await _fcm.getToken();
    print(token);
    var url =
      Uri.parse('https://www.quickserviceapp.educationhost.cloud/push-notification.php?token=$token');
    
    var response = await http.get(url);
    var message = json.decode(response.body);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
