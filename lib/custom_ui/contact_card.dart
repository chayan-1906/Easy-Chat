import 'package:easy_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactCard extends StatelessWidget {
  final ChatModel contact;
  const ContactCard({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          /// profile picture
          CircleAvatar(
            radius: 25.0,
            child: SvgPicture.asset(
              'assets/images/person.svg',
              color: Colors.white,
              height: 30.0,
              width: 30.0,
            ),
            backgroundColor: Colors.blueGrey.shade200,
          ),

          /// check icon
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Visibility(
              visible: contact.select,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).accentColor,
                radius: 11.0,
                child: Icon(
                  MaterialCommunityIcons.check_circle_outline,
                  color: Colors.white,
                  size: 18.0,
                ),
              ),
            ),
          ),
        ],
      ),

      /// name
      title: Text(
        contact.name,
        style: TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),
      ),

      /// status
      subtitle: Text(
        contact.status,
        style: TextStyle(fontSize: 13.0),
      ),
    );
  }
}
