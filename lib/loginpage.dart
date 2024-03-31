import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'package:opt_verification_page/otppage.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();

  Future<void> sendOtp(String phoneNumber, BuildContext context) async {
    var url = Uri.parse('https://www.fast2sms.com/dev/bulkV2');
    var rng = new Random();
    var otp = (rng.nextInt(9000) + 1000).toString(); // Generate a random 4-digit OTP

    var response = await http.post(
      url,
      headers: {
        'authorization':
            'Add_your_authorization_key',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'route': 'v3',
        'sender_id': 'FSTSMS',
        'message': 'Your OTP is $otp',
        'language': 'english',
        'flash': 0,
        'numbers': phoneNumber,
      }),
    );

    if (response.statusCode == 200) {
      print('OTP sent successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OTPPage(otp: otp)),
      );
    } else {
      print('Failed to send OTP: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              child: Text('Send OTP'),
              onPressed: () {
                sendOtp(_phoneController.text, context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
