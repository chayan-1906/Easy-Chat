import 'package:easy_chat/custom_ui/button_card.dart';
import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/screens/home_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ChatModel sourceChat;
  List<ChatModel> chatModels = [
    ChatModel(
      name: '+91 7310439725',
      icon: 'person.svg',
      isGroup: false,
      time: '4:00',
      currentMessage: 'Hello, How are you?',
      id: 1,
    ),
    ChatModel(
      name: 'Padmanabha',
      icon: 'person.svg',
      isGroup: false,
      time: '10:00',
      currentMessage: 'Hello, Padmanabha?',
      id: 2,
    ),
    ChatModel(
      name: 'Maa',
      icon: 'person.svg',
      isGroup: false,
      time: '10:00',
      currentMessage: 'Hi',
      id: 3,
    ),
    // ChatModel(
    //   name: 'Flutter Group',
    //   icon: 'groups.svg',
    //   isGroup: true,
    //   time: '16:00',
    //   currentMessage: 'Hello, this is a group',
    //   id: 4,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatModels.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              sourceChat = chatModels.removeAt(index);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    chatModels: chatModels,
                    sourceChat: sourceChat,
                  ),
                ),
              );
            },
            child: ButtonCard(
              text: chatModels[index].name,
              iconData: Icons.person,
            ),
          );
        },
      ),
    );
  }
}
