import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';
 import './resetpassword.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OTP(),
    );
  }
}

class OTP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quick Service"),
      ),
      body: Center(
          child: ListView(children: <Widget>[
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Enter OTP',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: PinEntryTextField(
              showFieldAsBox: true,
              onSubmit: (String pin) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Pin"),
                        content: Text('Pin entered is $pin'),
                      );
                    }); //end showDialog()
              }, // end onSubmit
            ), // end PinEntryTextField()
          ), // end Padding()
        ),
        Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                        primary: Colors.blue,//change background color of button
                        onPrimary: Colors.white,//change text color of button
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        elevation: 15.0,
                      ),
              child: Text('Submit'),
              onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Resetpassword()));
                        },
            )),
      ])),
    );
  }
}
