import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/screens/individual_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCard extends StatelessWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  const CustomCard({Key key, this.chatModel, this.sourceChat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => IndividualChatScreen(
              chatModel: chatModel,
              sourceChat: sourceChat,
            ),
          ),
        );
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30.0,
              child: SvgPicture.asset(
                chatModel.isGroup
                    ? 'assets/images/groups.svg'
                    : 'assets/images/person.svg',
                color: Colors.white,
                height: 36.0,
                width: 36.0,
              ),
              backgroundColor: Colors.blueGrey,
            ),
            title: Text(
              chatModel.name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(MaterialCommunityIcons.check_all, size: 18.0),
                SizedBox(width: 4.0),
                Text(
                  chatModel.currentMessage,
                  style: TextStyle(fontSize: 13.0),
                ),
              ],
            ),
            trailing: Text(chatModel.time),
          ),
          Divider(
            indent: 65.0,
            endIndent: 20.0,
            thickness: 1.0,
          ),
        ],
      ),
    );
  }
}
