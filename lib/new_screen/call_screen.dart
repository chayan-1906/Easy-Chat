import 'package:flutter/material.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({Key key}) : super(key: key);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  Widget CallCard(
      {String name, IconData iconData, Color iconColor, String time}) {
    return Card(
      margin: EdgeInsets.only(bottom: 0.5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 26.0,
        ),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Row(
          children: [
            Icon(iconData, color: iconColor, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              time,
              style: TextStyle(fontSize: 12.8),
            ),
          ],
        ),
        trailing: Icon(Icons.call, size: 28.0, color: Colors.teal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CallCard(
            name: 'Padmanabha',
            iconData: Icons.call_made,
            iconColor: Colors.green,
            time: 'Dec 21, 11:23',
          ),
          CallCard(
            name: 'Maa',
            iconData: Icons.call_missed,
            iconColor: Colors.red,
            time: 'Dec 18, 13:23',
          ),
          CallCard(
            name: 'Padmanabha',
            iconData: Icons.call_made,
            iconColor: Colors.green,
            time: 'Dec 21, 11:23',
          ),
          CallCard(
            name: 'Padmanabha',
            iconData: Icons.call_made,
            iconColor: Colors.green,
            time: 'Dec 21, 11:23',
          ),
          CallCard(
            name: 'Padmanabha',
            iconData: Icons.call_made,
            iconColor: Colors.green,
            time: 'Dec 21, 11:23',
          ),
        ],
      ),
    );
  }
}
