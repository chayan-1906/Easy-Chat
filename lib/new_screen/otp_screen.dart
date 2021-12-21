import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPScreen extends StatefulWidget {
  final String number;
  final String countryCode;
  const OTPScreen({Key key, this.number, this.countryCode}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  Widget bottomButton({String text, IconData iconData}) {
    return Row(
      children: [
        Icon(iconData, color: Colors.teal, size: 24.0),
        SizedBox(width: 10.0),
        Text(
          text,
          style: TextStyle(color: Colors.teal, fontSize: 14.5),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Verify ${widget.countryCode} ${widget.number}',
          style: TextStyle(color: Colors.teal.shade800, fontSize: 16.5),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 35.0),
        child: Column(
          children: [
            SizedBox(height: 10.0),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'We have sent an SMS with a code to \n',
                    style: TextStyle(fontSize: 14.5, color: Colors.black),
                  ),
                  TextSpan(
                    text: widget.countryCode + ' ' + widget.number + '\n',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: '\n'),
                  TextSpan(
                    text: ' Wrong Number?',
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.cyan.shade800,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width * 0.65 / 6,
              style: TextStyle(fontSize: 17.0),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onCompleted: (pin) {
                print('Completed: ' + pin);
              },
            ),
            SizedBox(height: 20.0),
            Text(
              'Enter 6 digit code',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.0),
            ),
            SizedBox(height: 30.0),

            /// resend sms
            bottomButton(text: 'Resend SMS', iconData: Icons.message),
            SizedBox(height: 12.0),
            Divider(thickness: 1.5),
            SizedBox(height: 12.0),

            /// resend sms
            bottomButton(text: 'Call Me', iconData: Icons.call),
          ],
        ),
      ),
    );
  }
}
