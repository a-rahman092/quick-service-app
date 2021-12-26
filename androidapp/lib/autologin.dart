import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Auto());

class Auto extends StatefulWidget {
  @override
  _AutoState createState() => _AutoState();
}

class _AutoState extends State<Auto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Auto Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController mobileController = TextEditingController();

  bool isLoggedIn = false;
  String mobile = '';

  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId = prefs.getString('mobile');

    if (userId != null) {
      setState(() {
        isLoggedIn = true;
        mobile = userId;
      });
      return;
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', null);

    setState(() {
      mobile = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mobile', mobileController.text);

    setState(() {
      mobile = mobileController.text;
      isLoggedIn = true;
    });

    mobileController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auto Login Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            !isLoggedIn
                ? Padding(
                  padding: EdgeInsets.all(10),
                  child: ListView(
                    children:<Widget>[
                      Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile',
                      ),
                    ),
                  ),
                    ]
                  )
                  
                  
                )
                : Text('You are logged in as $mobile'),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                isLoggedIn ? logout() : loginUser();
              },
              child: isLoggedIn ? Text('Logout') : Text('Login'),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
