import 'package:easy_chat/custom_ui/button_card.dart';
import 'package:easy_chat/custom_ui/contact_card.dart';
import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/screens/create_group_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SelectContactScreen extends StatefulWidget {
  const SelectContactScreen({Key key}) : super(key: key);

  @override
  _SelectContactScreenState createState() => _SelectContactScreenState();
}

class _SelectContactScreenState extends State<SelectContactScreen> {
  List<ChatModel> _contacts = [
    ChatModel(
      name: 'Padmanabha',
      status: 'A flutter developer',
    ),
    ChatModel(
      name: 'Ayush',
      status: 'A fullstack developer',
    ),
    ChatModel(
      name: 'Saket',
      status: 'A React developer',
    ),
    ChatModel(
      name: 'Sania',
      status: 'An android developer',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Contact',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '256 Contacts',
              style: TextStyle(fontSize: 13.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 26.0),
          ),

          /// more popup menu button
          PopupMenuButton<String>(
              elevation: 8.0,
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  /// invite a friend
                  PopupMenuItem(
                    child: Text('Invite a friend'),
                    value: 'Invite a friend',
                  ),

                  /// contacts
                  PopupMenuItem(
                    child: Text('Contacts'),
                    value: 'Contacts',
                  ),

                  /// refresh
                  PopupMenuItem(
                    child: Text('Refresh'),
                    value: 'Refresh',
                  ),

                  /// help
                  PopupMenuItem(
                    child: Text('Help'),
                    value: 'Help',
                  ),
                ];
              }),
        ],
      ),
      body: ListView.builder(
        itemCount: _contacts.length + 2,
        itemBuilder: (context, index) {
          if (index == 0) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return CreateGroupScreen();
                  }),
                );
              },
              child: ButtonCard(
                iconData: MaterialIcons.group,
                text: 'New group',
              ),
            );
          } else if (index == 1) {
            return ButtonCard(
              iconData: MaterialIcons.person_add,
              text: 'New contact',
            );
          }
          return ContactCard(contact: _contacts[index - 2]);
        },
      ),
    );
  }
}
