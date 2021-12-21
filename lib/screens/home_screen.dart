import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/new_screen/call_screen.dart';
import 'package:easy_chat/pages/camera_page.dart';
import 'package:easy_chat/pages/chat_page.dart';
import 'package:easy_chat/pages/status_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttericon/typicons_icons.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chatModels;
  final ChatModel sourceChat;
  const HomeScreen({
    Key key,
    this.chatModels,
    this.sourceChat,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy Chat'),
        actions: [
          /// search icon button
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),

          /// more popup menu button
          PopupMenuButton<String>(
              elevation: 8.0,
              onSelected: (value) {
                print(value);
              },
              itemBuilder: (BuildContext context) {
                return [
                  /// new group
                  PopupMenuItem(
                    child: Text('New Group'),
                    value: 'New Group',
                  ),

                  /// new broadcast
                  PopupMenuItem(
                    child: Text('New Broadcast'),
                    value: 'New Broadcast',
                  ),

                  /// whatsApp web
                  PopupMenuItem(
                    child: Text('WhatsApp Web'),
                    value: 'WhatsApp Web',
                  ),

                  /// starred messages
                  PopupMenuItem(
                    child: Text('Starred Messages'),
                    value: 'Starred Messages',
                  ),

                  /// settings
                  PopupMenuItem(
                    child: Text('Settings'),
                    value: 'Settings',
                  ),
                ];
              }),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(MaterialCommunityIcons.camera),
            ),
            Tab(
              icon: Icon(MaterialCommunityIcons.chat),
            ),
            Tab(
              icon: Icon(Typicons.video),
            ),
            Tab(
              icon: Icon(EvaIcons.phoneCall),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CameraPage(),
          ChatPage(
            chatModels: widget.chatModels,
            sourceChat: widget.sourceChat,
          ),
          StatusPage(),
          CallScreen(),
        ],
      ),
    );
  }
}
