import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: CompletedOrders(),
    debugShowCheckedModeBanner: false,
  ));
}

class Service {
  final String sno;

  const Service({
    this.sno,
  });
}

class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  SharedPreferences logindata;
  String mobile;

  Future getData() async {
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/customer-history.php?mobile=$mobile&status=Completed');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      mobile = logindata.getString('mobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (!snapshot.hasData) {
            // still waiting for data to come
            return Text("No Completed Orders found");
          } else {
            // got data and it is not empty
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.black,
                          primary: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        ),
                        onPressed: () {
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new Checkout(
                                value: Service(
                              sno: list[index]['sno'],
                            )),
                          );
                          Navigator.of(context).push(route);
                        },
                        child: Column(children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                                list[index]['service_name'] +
                                    '  - ' +
                                    list[index]['total_cost'] +
                                    '/hr',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(list[index]['servitor_name'],
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                        ]),
                      );
                    })
                : Center(
                    child: Text('You Dont have any Completed orders',
                        style: TextStyle(
                          fontSize: 18,
                        )),
                  );
          }
        },
      ),
    );
  }
}

class Checkout extends StatefulWidget {
  final Service value;

  Checkout({Key key, this.value}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final feedbackController = TextEditingController();
  SharedPreferences logindata;
  String mobile;
  int val = -1;
  var rating = 3.0;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      mobile = logindata.getString('mobile');
    });
  }

  Future getData() async {
    String sno = widget.value.sno;
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/order-details.php?sno=$sno');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text('Order Details'),
      backgroundColor:Colors.indigo[900],),
      body: Container(
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      List list = snapshot.data;
                      return Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'SUMMARY',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Service Name: ' + list[index]['service_name'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Servitor: ' + list[index]['servitor_name'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Servitor Mobile: ' +
                                    list[index]['servitor_mobile'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Cost/hour or Total cost: ' +
                                    list[index]['total_cost'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Your Rating: ' + list[index]['rating'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Your Feedback: ' + list[index]['feedback'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Status: ' + list[index]['status'],
                                style: TextStyle(fontSize: 16),
                              )),
                        ],
                      );
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ),
      ),
    );
  }
}
