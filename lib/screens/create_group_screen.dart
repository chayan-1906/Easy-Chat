import 'package:easy_chat/custom_ui/avatar_card.dart';
import 'package:easy_chat/custom_ui/contact_card.dart';
import 'package:easy_chat/model/chat_model.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({Key key}) : super(key: key);

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
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

  List<ChatModel> groups = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'New group',
              style: TextStyle(
                fontSize: 19.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Add participants',
              style: TextStyle(fontSize: 13.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, size: 26.0),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: _contacts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                /// the selected group members also considered as the first item of the listview
                return Container(height: groups.length > 0 ? 90 : 10);
              }
              return GestureDetector(
                onTap: () {
                  if (_contacts[index - 1].select == false) {
                    setState(() {
                      _contacts[index - 1].select = true;
                      groups.add(_contacts[index - 1]);
                    });
                  } else {
                    setState(() {
                      _contacts[index - 1].select = false;
                      groups.remove(_contacts[index - 1]);
                    });
                  }
                },
                child: ContactCard(contact: _contacts[index - 1]),
              );
            },
          ),

          /// select group members list
          Visibility(
            visible: groups.length > 0,
            child: Column(
              children: [
                Container(
                  height: 75.0,
                  color: Colors.white,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _contacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_contacts[index].select) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                groups.remove(_contacts[index]);
                                _contacts[index].select = false;
                              });
                            },
                            child: AvatarCard(contact: _contacts[index]));
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                Divider(thickness: 1, height: 1.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
