import 'package:easy_chat/custom_ui/head_own_status.dart';
import 'package:easy_chat/custom_ui/others_status.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  Widget label({String labelName}) {
    return Container(
      height: 33.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.0, vertical: 7.0),
        child: Text(
          labelName,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(height: 10.0),
            HeadOwnStatus(),
            label(labelName: 'Recent Updates'),
            OthersStatus(
              name: 'Padmanabha Das',
              time: '01:27',
              imageName: 'assets/images/2.jpeg',
              isSeen: false,
              statusNum: 15,
            ),
            OthersStatus(
              name: 'Saket Sinha',
              time: '01:30',
              imageName: 'assets/images/1.jpg',
              isSeen: false,
              statusNum: 2,
            ),
            OthersStatus(
              name: 'Bhanu Dev',
              time: '11:05',
              imageName: 'assets/images/1.png',
              isSeen: false,
              statusNum: 3,
            ),
            SizedBox(height: 10.0),
            label(labelName: 'Viewed Updates'),
            OthersStatus(
              name: 'Padmanabha Das',
              time: '01:27',
              imageName: 'assets/images/2.jpeg',
              isSeen: true,
              statusNum: 1,
            ),
            OthersStatus(
              name: 'Saket Sinha',
              time: '01:30',
              imageName: 'assets/images/1.jpg',
              isSeen: true,
              statusNum: 2,
            ),
            OthersStatus(
              name: 'Bhanu Dev',
              time: '11:05',
              imageName: 'assets/images/1.png',
              isSeen: true,
              statusNum: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 48.0,
            child: FloatingActionButton(
              backgroundColor: Colors.blueGrey[100],
              onPressed: () {},
              child: Icon(
                Icons.edit,
                color: Colors.blueGrey[900],
              ),
            ),
          ),
          SizedBox(height: 13.0),
          FloatingActionButton(
            onPressed: () {},
            elevation: 5.0,
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.camera_alt),
          ),
        ],
      ),
    );
  }
}
