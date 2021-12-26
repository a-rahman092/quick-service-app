import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import './Animation/FadeAnimation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MaterialApp(
    home: ServitorLogin(),
    debugShowCheckedModeBanner: false,
  ));
}

class Service {
  final String sno;

  const Service({
    this.sno,
  });
}

class ServitorLogin extends StatefulWidget {
  @override
  _ServitorLoginState createState() => _ServitorLoginState();
}

class _ServitorLoginState extends State<ServitorLogin> {
  // Getting value from TextField widget.
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();

  SharedPreferences logindata;
  String servitormobile;
  bool newuser;

  @override
  void initState() {
    super.initState();
    checkifalreadylogin();
  }

  void checkifalreadylogin() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      servitormobile = logindata.getString('servitormobile');
    });
    newuser = (logindata.getBool('servitorlogin') ?? true);
    if (newuser == false) {
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => ServitorHistory()));
    }
  }

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  Future logincall() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String mobile = mobileController.text;
    String password = passwordController.text;

    // SERVER LOGIN API URL
    var url = Uri.parse(
        'http://www.quickserviceapp.educationhost.cloud/servitor-login.php');

    // Store all data with Param Name.
    var data = {'mobile': mobile, 'password': password};

    // Starting Web API Call.
    var response = await http.post(url, body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If the Response Message is Matched.
    if (message == 'Login Matched') {
      logindata.setBool('servitorlogin', false);
      logindata.setString('servitormobile', mobile);

      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Navigate to Profile Screen & Sending Email to Next Screen.
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ServitorHistory()));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
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

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 30,
                        width: 80,
                        height: 200,
                        child: FadeAnimation(
                            1,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/light-1.png'))),
                            )),
                      ),
                      Positioned(
                        left: 140,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.3,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/light-2.png'))),
                            )),
                      ),
                      Positioned(
                        right: 40,
                        top: 40,
                        width: 80,
                        height: 150,
                        child: FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('images/clock.png'))),
                            )),
                      ),
                      Positioned(
                        child: FadeAnimation(
                            1.6,
                            Container(
                              margin: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Text(
                                  "Servitor Login",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Column(
                    children: <Widget>[
                      FadeAnimation(
                          1.8,
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(143, 148, 251, .2),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10))
                                ]),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey[100]))),
                                  child: TextField(
                                    controller: mobileController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Phone number",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle:
                                            TextStyle(color: Colors.grey[400])),
                                  ),
                                )
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      FadeAnimation(
                          2,
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(colors: [
                                  Color.fromRGBO(143, 148, 251, 1),
                                  Color.fromRGBO(143, 148, 251, .6),
                                ])),
                            child: Center(
                                child: TextButton(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: logincall,
                            )),
                          )),
                      Visibility(
                          visible: visible,
                          child: Container(child: CircularProgressIndicator())),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class ServitorHistory extends StatefulWidget {
  @override
  _ServitorHistoryState createState() => _ServitorHistoryState();
}

class _ServitorHistoryState extends State<ServitorHistory> {
  SharedPreferences logindata;
  String servitormobile;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      servitormobile = logindata.getString('servitormobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Servitor History'),
            backgroundColor: Colors.indigo[900],
            bottom: TabBar(
              tabs: [
                Tab(text: "Pending Orders"),
                Tab(text: "Completed Orders")
              ],
            ),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                iconSize: 30,
                color: Colors.white,
                splashColor: Colors.purple,
                onPressed: () {
                  logindata.setBool('servitorlogin', true);
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ServitorLogin()));
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              PendingOrders(),
              CompletedOrders(),
            ],
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PendingOrders extends StatefulWidget {
  @override
  _PendingOrdersState createState() => _PendingOrdersState();
}

class _PendingOrdersState extends State<PendingOrders> {
  SharedPreferences servitorlogindata;
  String servitormobile;

  Future getData() async {
    var url = Uri.parse(
        'http://www.quickserviceapp.educationhost.cloud/servitor-history.php?mobile=$servitormobile&status=Pending');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    servitorlogindata = await SharedPreferences.getInstance();
    setState(() {
      servitormobile = servitorlogindata.getString('servitormobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("No Pending Orders found");
          }
          if (!snapshot.hasData) {
            // still waiting for data to come
            return Text("No Pending Orders found");
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
                            builder: (BuildContext context) =>
                                new Pendingorderdetail(
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
                            child: Text(list[index]['customer_name'],
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                          ),
                        ]),
                      );
                    })
                : Center(
                    child: Text('You Dont have any Pending orders',
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

class Pendingorderdetail extends StatefulWidget {
  final Service value;

  Pendingorderdetail({Key key, this.value}) : super(key: key);

  @override
  _PendingorderdetailState createState() => _PendingorderdetailState();
}

class _PendingorderdetailState extends State<Pendingorderdetail> {
  final costController = TextEditingController();
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
        'http://www.quickserviceapp.educationhost.cloud/order-details.php?sno=$sno');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  Future webCall(String servitormobile) async {
    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String sno = widget.value.sno;
    String cost = costController.text;

    // API URL
    var url = Uri.parse(
        'http://www.quickserviceapp.educationhost.cloud/update-cost.php');

    // Store all data with Param Name.
    var data = {'sno': sno, 'cost': cost, 'servitormobile': servitormobile};

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
                Navigator.of(context).pop();
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
        title: new Text('Order Details'),
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
                      String servitormobile = list[index]['servitor_mobile'];
                      return Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                'SUMMARY',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                                'Customer Name: ' +
                                    list[index]['customer_name'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Customer Mobile: ' +
                                    list[index]['customer_mobile'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Cost/hour: ' + list[index]['total_cost'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Text(
                                'ENTER COST',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: TextField(
                              controller: costController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Enter Total cost',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                onPrimary: Colors.white,
                                primary: Colors.indigo[900],
                                padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text('Mark Service As Complete'),
                              onPressed: () {
                                webCall(servitormobile);
                              },
                            ),
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

class CompletedOrders extends StatefulWidget {
  @override
  _CompletedOrdersState createState() => _CompletedOrdersState();
}

class _CompletedOrdersState extends State<CompletedOrders> {
  SharedPreferences logindata;
  String servitormobile;

  Future getData() async {
    var url = Uri.parse(
        'http://www.quickserviceapp.educationhost.cloud/servitor-history.php?mobile=$servitormobile&status=Completed');
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
      servitormobile = logindata.getString('servitormobile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("No Completed Orders found");
          }
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
                            builder: (BuildContext context) =>
                                new Completedorderdetail(
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
                            child: Text(list[index]['customer_name'],
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

class Completedorderdetail extends StatefulWidget {
  final Service value;

  Completedorderdetail({Key key, this.value}) : super(key: key);

  @override
  _CompletedorderdetailState createState() => _CompletedorderdetailState();
}

class _CompletedorderdetailState extends State<Completedorderdetail> {
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
        'http://www.quickserviceapp.educationhost.cloud/order-details.php?sno=$sno');
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Order Details'),
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
                                'Service Name: ' + list[index]['service_name'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Customer Name: ' +
                                    list[index]['customer_name'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Customer Mobile: ' +
                                    list[index]['customer_mobile'],
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
                                'Customer Rating: ' + list[index]['rating'],
                                style: TextStyle(fontSize: 16),
                              )),
                          Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 6),
                              child: Text(
                                'Customer Feedback: ' + list[index]['feedback'],
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
