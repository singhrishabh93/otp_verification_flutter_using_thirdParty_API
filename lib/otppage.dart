import 'package:flutter/material.dart';

class OTPPage extends StatelessWidget {
  final String otp;
  final TextEditingController _otpController = TextEditingController();

  OTPPage({Key? key, required this.otp}) : super(key: key);

  void verifyOtp(String inputOtp, BuildContext context) {
    if (inputOtp == otp) {
      print('OTP verified successfully');
      // Navigate to next page
    } else {
      print('Incorrect OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify OTP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _otpController,
              decoration: InputDecoration(
                labelText: 'OTP',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              child: Text('Verify'),
              onPressed: () {
                verifyOtp(_otpController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
