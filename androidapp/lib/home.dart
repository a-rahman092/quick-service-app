import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './history.dart';
import './profile.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Service {
  final String servicename;
  final String serviceperson;
  final String cost;
  final String servitormobile;

  const Service({
    this.servicename,
    this.serviceperson,
    this.cost,
    this.servitormobile,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String text = "Text";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Quick Service'),
          backgroundColor: Colors.indigo[900],
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.access_time,
              ),
              iconSize: 30,
              color: Colors.white,
              splashColor: Colors.purple,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => History()));
              },
            ),
            IconButton(
              icon: Icon(
                Icons.account_circle,
              ),
              iconSize: 30,
              color: Colors.white,
              splashColor: Colors.purple,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
          ],
        ),
        body: Container(
            child: new SingleChildScrollView(
          child: Column(children: <Widget>[
            CarouselSlider(
              items: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Image.asset('images/1.png',
                      width: double.infinity, height: 300),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Image.asset(
                    'images/2.png',
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Image.asset(
                    'images/3.png',
                    width: double.infinity,
                  ),
                ),
              ],
              //Slider Container properties
              options: CarouselOptions(
                autoPlay: true,
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              padding: EdgeInsets.all(14.0),
              child: Text(
                "EXPLORE ON DEMAND SERVICES",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 19, 8, 19),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/home-cleaning.png',
                                height: 90, width: 90),
                            Text(
                              'Home Cleaning',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'Home Cleaning')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/kitchen-cleaning.png',
                                height: 90, width: 90),
                            Text(
                              'Kitchen Cleaning',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value:
                                    Service(servicename: 'Kitchen Cleaning')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/bath.png',
                                height: 90, width: 90),
                            Text(
                              'Bathroom Cleaning',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value:
                                    Service(servicename: 'Bathroom Cleaning')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/mobile-repair.png',
                                height: 90, width: 90),
                            Text(
                              'Mobile Repairing',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value:
                                    Service(servicename: 'Mobile Repairing')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/fridge.png',
                                height: 90, width: 90),
                            Text(
                              'Refrigerator Repairing',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(
                                    servicename: 'Refrigerator Repairing')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(8, 19, 8, 19),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/ac-repair.png',
                                height: 90, width: 90),
                            Text(
                              'AC Repairing',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'AC Repairing')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/television.png',
                                height: 90, width: 90),
                            Text(
                              'TV Repairing',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'Television Repaiing')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/plumber.png',
                                height: 90, width: 90),
                            Text(
                              'Plumber',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'Plumber')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <
                Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/electrition.png',
                                height: 90, width: 90),
                            Text(
                              'Electrition',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'Electrition')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    border: Border.all(
                      color: Colors.blue[50],
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue[50].withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      TextButton(
                        child: Column(
                          children: <Widget>[
                            Image.asset('images/carpentry.png',
                                height: 90, width: 90),
                            Text(
                              'Carpentry',
                              style: TextStyle(fontSize: 16.0),
                            )
                          ],
                        ),
                        onPressed: () {
                          // A MaterialPageRoute is a  modal route that replaces the entire screen
                          // with a platform-adaptive transition.
                          var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new SecondPage(
                                value: Service(servicename: 'Carpentry')),
                          );
                          Navigator.of(context).push(route);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(
                          color: Colors.blue[50],
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[50].withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Image.asset('images/make-up.png',
                                    height: 90, width: 90),
                                Text(
                                  'Makeup',
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                            onPressed: () {
                              // A MaterialPageRoute is a  modal route that replaces the entire screen
                              // with a platform-adaptive transition.
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new SecondPage(
                                        value: Service(servicename: 'Beauty/Makeup')),
                              );
                              Navigator.of(context).push(route);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        border: Border.all(
                          color: Colors.blue[50],
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue[50].withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: <Widget>[
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Image.asset('images/washing-machine.png',
                                    height: 90, width: 90),
                                Text(
                                  'Laundry',
                                  style: TextStyle(fontSize: 16.0),
                                )
                              ],
                            ),
                            onPressed: () {
                              // A MaterialPageRoute is a  modal route that replaces the entire screen
                              // with a platform-adaptive transition.
                              var route = new MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    new SecondPage(
                                        value: Service(servicename: 'Laundry')),
                              );
                              Navigator.of(context).push(route);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
          ]),
        )));
  }
}

class SecondPage extends StatefulWidget {
  final Service value;

  SecondPage({Key key, this.value}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  Future getData() async {
    String servicename = widget.value.servicename;
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/fetch-servitor.php?servicename=$servicename');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Select Service Provider'),
        backgroundColor: Colors.indigo[900],
      ),
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
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1.0, color: Colors.black12),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Image.network(
                                  list[index]['photo'],
                                  width: 60,
                                  height: 60),
                            ),
                            Column(children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(list[index]['name'],
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    Text(list[index]['rating']),
                                  ])),
                            ]),
                            Column(children: <Widget>[
                              Container(
                                child: Text(
                                    '\u{20B9}' + list[index]['cost'] + '/hr',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.lightBlue[600],
                                    )),
                              ),
                              Container(
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.deepOrangeAccent[
                                        400], // This is a custom color variable
                                  ),
                                  child: Text('Book Now',
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  onPressed: () {
                                    var route = new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Checkout(
                                              value: Service(
                                                  servicename:
                                                      widget.value.servicename,
                                                  serviceperson: list[index]
                                                      ['name'],
                                                  cost: list[index]['cost'],
                                                  servitormobile: list[index]
                                                      ['mobile'])),
                                    );
                                    Navigator.of(context).push(route);
                                  },
                                ),
                              ),
                            ]),
                          ],
                        ),
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

class Checkout extends StatefulWidget {
  final Service value;

  Checkout({Key key, this.value}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  SharedPreferences logindata;
  String mobile;
  int val = -1;

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
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/checkout.php?mobile=$mobile');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  Future webCall(String name, String address) async {
    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String servicename = widget.value.servicename;
    String serviceperson = widget.value.serviceperson;
    String cost = widget.value.cost;
    String servitormobile = widget.value.servitormobile;

    // API URL
    var url = Uri.parse(
        'https://abdulrahmandemo.000webhostapp.com/book-service.php');

    // Store all data with Param Name.
    var data = {
      'servicename': servicename,
      'serviceperson': serviceperson,
      'cost': cost,
      'mobile': mobile,
      'servitormobile': servitormobile,
      'name': name,
      'address': address
    };

    // Starting Web Call with data.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(message),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => History()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Checkout'),
        backgroundColor: Colors.indigo[900],
      ),
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
                      String name = list[index]['name'];
                      String address = list[index]['address'];
                      return Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'SUMMARY',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Service Name: ' + widget.value.servicename,
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Servitor: ' + widget.value.serviceperson,
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Servitor Mobile: ' +
                                    widget.value.servitormobile,
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Cost: ' + widget.value.cost + '/hr',
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topCenter,
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              padding: EdgeInsets.all(10),
                              child: Text(
                                'YOUR DETAILS',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Name: ' + list[index]['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Mobile: $mobile',
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 26),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Address: ' + list[index]['address'],
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: Colors.indigo[900],
                              padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ),
                            child: Text('Place Order'),
                            onPressed: () {
                              if (list[index]['address'] == '') {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Your profile is incomplete.Please update your address"),
                                      );
                                    });
                              } else {
                                webCall(name, address);
                              }
                            },
                          ),
                          Visibility(
                              visible: visible,
                              child: Container(
                                  child: CircularProgressIndicator())),
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
