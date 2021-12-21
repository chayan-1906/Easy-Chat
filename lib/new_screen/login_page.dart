import 'package:easy_chat/model/country_model.dart';
import 'package:easy_chat/new_screen/country_page.dart';
import 'package:easy_chat/new_screen/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String countryName = 'India';
  String countryCode = '+91';
  TextEditingController _phoneNumberController = TextEditingController();

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryName = countryModel.name;
      countryCode = countryModel.code;
    });
    Navigator.of(context).pop();
  }

  Widget CountryCard() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CountryPage(setCountryData: setCountryData),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.8,
              color: Colors.teal,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryName,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            Icon(Icons.arrow_drop_down, color: Colors.teal, size: 28.0),
          ],
        ),
      ),
    );
  }

  Widget Number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38.0,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          Container(
            width: 70.0,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 10.0),
                Text(
                  '+',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(width: 15.0),
                Text(
                  countryCode.substring(1),
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
          SizedBox(width: 30.0),
          Container(
            width: MediaQuery.of(context).size.width / 1.5 - 100,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(8.0),
                hintText: 'phone number',
              ),
              autofocus: false,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showSuccessDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Verify phone number'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We will be verifying your phone Number',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  countryCode + ' ' + _phoneNumberController.text,
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Is it okay or would you like to edit this number?',
                  style: TextStyle(fontSize: 13.5),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'EDIT',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(
                      number: _phoneNumberController.text,
                      countryCode: countryCode,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlertDialog() {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Warning!',
            style: TextStyle(color: Colors.orange),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Please enter a valid phone number',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w700,
            wordSpacing: 1,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Icon(Icons.more_vert, color: Colors.black),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              'Whatsapp will send an SMS to verify your number',
              style: TextStyle(fontSize: 13.5),
            ),
            SizedBox(height: 5.0),
            Text(
              'What\'s my number?',
              style: TextStyle(fontSize: 12.8, color: Colors.cyan[800]),
            ),
            SizedBox(height: 15.0),
            CountryCard(),
            SizedBox(height: 5.0),
            Number(),
            // Expanded(child: Container()),
            Spacer(),
            GestureDetector(
              onTap: () {
                if (_phoneNumberController.text.length < 10) {
                  showAlertDialog();
                } else {
                  showSuccessDialog();
                }
              },
              child: Container(
                height: 40.0,
                width: 70.0,
                color: Colors.tealAccent.shade400,
                child: Center(
                  child: Text(
                    'NEXT',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
