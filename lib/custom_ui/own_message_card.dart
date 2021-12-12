import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class OwnMessageCard extends StatelessWidget {
  final String message;
  final String time;
  const OwnMessageCard({Key key, this.message, this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45.0),
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
          color: Color(0xFFDCF8C6),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                  right: 60.0,
                  top: 5.0,
                  bottom: 20.0,
                ),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              Positioned(
                bottom: 4.0,
                right: 10.0,
                child: Row(
                  children: [
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Icon(MaterialCommunityIcons.check_all, size: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
