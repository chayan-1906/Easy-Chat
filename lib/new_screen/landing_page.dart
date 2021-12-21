import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'login_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50.0),
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 29.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15.0),
              Flexible(
                child: Image.asset(
                  'assets/images/bg.png',
                  color: Colors.greenAccent[700],
                  height: 340.0,
                  width: 340.0,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height / 15.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 17.0),
                    children: [
                      TextSpan(
                        text: 'Agree and Continue to accept the',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      TextSpan(
                        text: ' Whatsapp Terms and Services and Privacy Policy',
                        style: TextStyle(color: Colors.cyan),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false);
                },
                child: Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width - 110,
                  child: Card(
                    margin: EdgeInsets.all(0.0),
                    color: Colors.greenAccent.shade700,
                    elevation: 8.0,
                    child: Center(
                      child: Text(
                        'AGREE AND CONTINUE',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
