// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

void main() => runApp(Selectschedule());

class Selectschedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Service',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Select Schedule'),
        ),
        body: const Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}






















/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Selectprovider(),
  ));
}

/*class Selectprovider extends StatefulWidget {
  final Service value;

  Selectprovider({Key key, this.value}) : super(key: key);

  @override
  _SelectproviderState createState() => _SelectproviderState();
}

class _SelectproviderState extends State<Selectprovider> {
  Future getData() async {
    var url = 'https://abdulrahmandemo.000webhostapp.com/fetch_services.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Quick Service')),
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
                  'USERNAME : ${widget.value.servicename}',
                  style: new TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                padding: EdgeInsets.all(10.0),
              ),
              FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            List list = snapshot.data;
                            return ListTile(
                              title: Text(list[index]['service_name']),
                            );
                          })
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
class Selectprovider extends StatefulWidget {
  @override
  _SelectproviderState createState() => _SelectproviderState();
}

class _SelectproviderState extends State<Selectprovider> {

  Future getData()async{
    var url = 'https://abdulrahmandemo.000webhostapp.com/fetch_services.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Quick Service'),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.blueAccent
        ),
        body: FutureBuilder(
          future:getData(),
          builder:(context, snapshot){
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index){
                List list = snapshot.data;
                return ListTile(
                  title:Text(list[index]['service_name']),
                );
              }
              ):Center(child: CircularProgressIndicator(),);
          },
          ),
    );
  }
}*/
