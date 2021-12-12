import 'package:flutter/material.dart';

class HeadOwnStatus extends StatelessWidget {
  const HeadOwnStatus({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 27.0,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/images/padmanabha.jpg'),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).accentColor,
              radius: 10.0,
              child: Icon(Icons.add, size: 20.0, color: Colors.white),
            ),
          ),
        ],
      ),
      title: Text(
        'My Status',
        style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
      ),
      subtitle: Text(
        'Tap to add status update',
        style: TextStyle(fontSize: 13.0, color: Colors.grey[900]),
      ),
    );
  }
}
