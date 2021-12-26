import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;

  const User({
    this.username,
  });
}

class Passdata extends StatefulWidget {
  @override
  _PassdataState createState() => _PassdataState();
}

class _PassdataState extends State<Passdata> {
  //TextEditingController is controller for editable text fields.
  //It's role is to update itself and notify listeners whenever it's associated
  //textfield changes.

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Data Passing'),
      ),
      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: new Text(
                  'Type and Pass Data',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Username'),
              ),
              new ElevatedButton(
                onPressed: () {
                  // A MaterialPageRoute is a  modal route that replaces the entire screen
                  // with a platform-adaptive transition.
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new SecondPage(
                        value: User(username: '_usernameController')),
                  );
                  Navigator.of(context).push(route);
                },
                child: new Text('Click to Pass Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final User value;

  SecondPage({Key key, this.value}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future getData() async {
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/fetch_services.php');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Second Page')),
      body: new Container(
        child: new Center(
          child: Column(
            children: <Widget>[
              Padding(
                child: new Text(
                  'PASSED VALUES',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                padding: EdgeInsets.only(bottom: 20.0),
              ),
              Padding(
                child: new Text(
                  'USERNAME : ${widget.value.username}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Passdata(),
      ),
    );
  }
}

void main() => runApp(new MyApp());
