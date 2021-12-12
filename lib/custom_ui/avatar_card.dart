import 'package:easy_chat/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';

class AvatarCard extends StatelessWidget {
  final ChatModel contact;
  const AvatarCard({Key key, this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
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
                child: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 11.0,
                  child: Icon(
                    MaterialCommunityIcons.close_circle_outline,
                    color: Colors.white,
                    size: 18.0,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.0),
          Text(
            contact.name,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }
}
