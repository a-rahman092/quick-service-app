import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';

void main() {
  runApp(MaterialApp(
    home: SendOtp(),
  ));
}

// Now instantiate FlutterOtp class in order to call sendOtp function
FlutterOtp otp = FlutterOtp();

class SendOtp extends StatelessWidget {
  final String phoneNumber = "8919668452"; //enter your 10 digit number
  final int minNumber = 1000;
  final int maxNumber = 6000;
  final String countryCode =
      "+91"; // give your country code if not it will take +1 as default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("send otp using flutter_otp ")),
      body: Container(
        child: Center(
            child: ElevatedButton(
          child: Text("Send"),
          onPressed: () {
            // call sentOtp function and pass the parameters

            otp.sendOtp('958347XXXX', 'OTP is : ');
          },
        )),
      ),
    );
  }
}
