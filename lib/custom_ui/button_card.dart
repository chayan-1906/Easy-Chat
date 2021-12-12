import 'package:flutter/material.dart';

class ButtonCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  const ButtonCard({Key key, this.iconData, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      /// profile picture
      leading: CircleAvatar(
        radius: 25.0,
        child: Icon(iconData, size: 26.0, color: Colors.white),
        backgroundColor: Theme.of(context).accentColor,
      ),

      /// name
      title: Text(
        text,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
