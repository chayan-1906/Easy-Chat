import 'package:easy_chat/custom_ui/custom_card.dart';
import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/screens/select_contact_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  const ChatPage({Key key, this.chatModels, this.sourceChat}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.chatModels.length,
        itemBuilder: (BuildContext context, int index) => CustomCard(
          chatModel: widget.chatModels[index],
          sourceChat: widget.sourceChat,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SelectContactScreen(),
            ),
          );
        },
        child: Icon(EvaIcons.people),
      ),
    );
  }
}
