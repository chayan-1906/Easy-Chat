import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_chat/custom_ui/own_file_card.dart';
import 'package:easy_chat/custom_ui/own_message_card.dart';
import 'package:easy_chat/custom_ui/reply_card.dart';
import 'package:easy_chat/custom_ui/reply_file_card.dart';
import 'package:easy_chat/model/chat_model.dart';
import 'package:easy_chat/model/message_model.dart';
import 'package:easy_chat/screens/camera_screen.dart';
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'camera_view_screen.dart';

class IndividualChatScreen extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel sourceChat;
  const IndividualChatScreen({Key key, this.chatModel, this.sourceChat})
      : super(key: key);

  @override
  _IndividualChatScreenState createState() => _IndividualChatScreenState();
}

class _IndividualChatScreenState extends State<IndividualChatScreen> {
  bool _showEmojiPicker = false;
  FocusNode focusNode = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  IO.Socket socket;
  bool sendButton = false;
  List<MessageModel> messages = [];
  ImagePicker _imagePicker = ImagePicker();
  XFile file;
  int popTime = 0;

  Widget emojiSelect() {
    return EmojiPicker(
        rows: 4,
        columns: 7,
        buttonMode: ButtonMode.MATERIAL,
        onEmojiSelected: (emoji, category) {
          print(emoji);
          setState(() {
            _textEditingController.text += emoji.emoji;
          });
        });
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 250.0,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Card(
              margin: EdgeInsets.all(18.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// document, camera, gallery
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _createIcon(
                            backgroundColor: Color(0xFF5584AC),
                            iconData: MaterialCommunityIcons.file,
                            iconName: 'Document',
                            onTap: () {
                              print('Document');
                              Navigator.of(context).pop();
                            },
                          ),
                          _createIcon(
                            backgroundColor: Color(0xFF161E54),
                            iconData: MaterialCommunityIcons.camera,
                            iconName: 'Camera',
                            onTap: () {
                              print('Camera');
                              setState(() {
                                popTime = 3;
                              });
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CameraScreen(onImageSend: onImageSend),
                                ),
                              );
                            },
                          ),
                          _createIcon(
                            backgroundColor: Color(0xFFEC255A),
                            iconData: MaterialCommunityIcons.image,
                            iconName: 'Gallery',
                            onTap: () async {
                              print('Gallery');
                              setState(() {
                                popTime = 2;
                              });
                              file = await _imagePicker.pickImage(
                                  source: ImageSource.gallery);
                              // Navigator.of(context).pop();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CameraViewScreen(
                                    path: file.path,
                                    onImageSend: onImageSend,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),

                      /// audio, location, contact
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _createIcon(
                            backgroundColor: Colors.cyan,
                            iconData: MaterialIcons.headset_mic,
                            iconName: 'Audio',
                            onTap: () {
                              print('Audio');
                              Navigator.of(context).pop();
                            },
                          ),
                          _createIcon(
                            backgroundColor: Colors.green.shade400,
                            iconData: MaterialIcons.location_on,
                            iconName: 'Location',
                            onTap: () {
                              print('Location');
                              Navigator.of(context).pop();
                            },
                          ),
                          _createIcon(
                            backgroundColor: Colors.teal.shade500,
                            iconData: MaterialIcons.contact_phone,
                            iconName: 'Contact',
                            onTap: () {
                              print('Contact');
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _createIcon(
      {Color backgroundColor,
      IconData iconData,
      String iconName,
      Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundColor: backgroundColor,
            child: Icon(iconData, size: 29.0, color: Colors.white),
          ),
          SizedBox(height: 5.0),
          Text(
            iconName,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  void connect() {
    socket = IO.io("http://192.168.137.196:5000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.emit("signin", widget.sourceChat.id);
    socket.onConnect((data) {
      print('Connected');
      socket.on("message", (msg) {
        print(msg);
        setMessage(
            type: 'destination', message: msg['message'], path: msg["path"]);
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
    print(socket.connected);
  }

  void sendMessage({String message, int sourceId, int targetId, String path}) {
    setMessage(type: 'source', message: message, path: path);
    socket.emit("message", {
      "message": message,
      "sourceId": sourceId,
      "targetId": targetId,
      "path": path,
    });
  }

  void setMessage({String type, String message, String path}) {
    MessageModel messageModel = MessageModel(
      type: type,
      message: message,
      time: DateTime.now().toString().substring(10, 16),
      path: path,
    );
    setState(() {
      messages.add(messageModel);
    });
  }

  void onImageSend(String path, String message) async {
    print('hey there working $message');
    for (int i = 0; i < popTime; i++) {
      Navigator.of(context).pop();
    }
    setState(() {
      popTime = 0;
    });
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.137.1:5000/routes/addimage'));
    request.files.add(await http.MultipartFile.fromPath('img', path));
    request.headers.addAll({
      "Content-type": "multipart/form-data",
    });
    http.StreamedResponse response = await request.send();
    var httpResponse = await http.Response.fromStream(response);
    var data = json.decode(httpResponse.body);
    print(data['path']);
    print(response.statusCode);
    setMessage(type: 'source', message: message, path: path);
    socket.emit("message", {
      "message": message,
      "sourceId": widget.sourceChat.id,
      "targetId": widget.chatModel.id,
      "path": data['path'],
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          _showEmojiPicker = false;
        });
      }
    });
    connect();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/chat_background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            // leadingWidth: 70.0,
            leadingWidth: 100.0,
            titleSpacing: 0,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },

              /// back & profile picture
              child: Container(
                // color: Colors.redAccent,
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back_ios, size: 24.0),
                    CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.blueGrey,
                      child: SvgPicture.asset(
                        widget.chatModel.isGroup
                            ? 'assets/images/groups.svg'
                            : 'assets/images/person.svg',
                        color: Colors.white,
                        height: 28.0,
                        width: 28.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// user's name
            title: GestureDetector(
              onTap: () {},
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    widget.chatModel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                  Visibility(
                    visible: true, // based on user's last seen
                    child: AutoSizeText(
                      'last seen at today 12:05 PM',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              /// video call
              IconButton(
                onPressed: () {},
                icon: Icon(Feather.video),
              ),

              /// voice call
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.call),
              ),

              /// more popup menu button
              PopupMenuButton<String>(
                  elevation: 8.0,
                  offset: Offset(-10.0, kToolbarHeight),
                  onSelected: (value) {
                    print(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      /// new group
                      PopupMenuItem(
                        child: Text('View contact'),
                        value: 'View contact',
                      ),

                      /// media, links and docs
                      PopupMenuItem(
                        child: Text('Media, links and docs'),
                        value: 'Media, links and docs',
                      ),

                      /// whatsApp web
                      PopupMenuItem(
                        child: Text('Search'),
                        value: 'Search',
                      ),

                      /// starred messages
                      PopupMenuItem(
                        child: Text('Mute notifications'),
                        value: 'Mute notifications',
                      ),

                      /// wallpaper
                      PopupMenuItem(
                        child: Text('Wallpaper'),
                        value: 'Wallpaper',
                      ),
                    ];
                  }),
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (_showEmojiPicker) {
                  setState(() {
                    _showEmojiPicker = false;
                  });
                } else {
                  Navigator.of(context).pop();
                }
                return Future.value(false);
              },
              child: Column(
                children: [
                  Expanded(
                    // height: MediaQuery.of(context).size.height - 140.0,
                    child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: messages.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == messages.length) {
                          return Container(height: 70.0);
                        }
                        if (messages[index].type == 'source') {
                          if (messages[index].path.length > 0) {
                            return OwnFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return OwnMessageCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        } else {
                          if (messages[index].path.length > 0) {
                            return ReplyFileCard(
                              path: messages[index].path,
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          } else {
                            return ReplyCard(
                              message: messages[index].message,
                              time: messages[index].time,
                            );
                          }
                        }
                      },
                    ),
                    // child: ListView(
                    //   children: [
                    //     OwnFileCard(),
                    //     ReplyFileCard(),
                    //   ],
                    // ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 70.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// container --> card --> textformfield
                              Flexible(
                                flex: 6,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 55.0,
                                  child: Card(
                                    margin: EdgeInsets.only(
                                        left: 2.0, right: 2.0, bottom: 8.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35.0),
                                    ),
                                    child: TextFormField(
                                      focusNode: focusNode,
                                      controller: _textEditingController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 1000,
                                      minLines: 1,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.all(20.0),
                                        prefixIcon: IconButton(
                                          onPressed: () {
                                            focusNode.unfocus();
                                            focusNode.canRequestFocus = false;
                                            setState(() {
                                              _showEmojiPicker =
                                                  !_showEmojiPicker;
                                            });
                                          },
                                          icon: Icon(MdiIcons.emoticonOutline),
                                        ),
                                        hintText: 'Type a message',
                                        suffixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                _showBottomSheet(context);
                                              },
                                              icon: Icon(Icons.attach_file),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  popTime = 2;
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CameraScreen(
                                                            onImageSend:
                                                                onImageSend),
                                                  ),
                                                );
                                              },
                                              icon: Icon(MaterialCommunityIcons
                                                  .camera),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onChanged: (text) {
                                        if (text.isNotEmpty) {
                                          setState(() {
                                            sendButton = true;
                                          });
                                        } else {
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),

                              /// message send button
                              Flexible(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 5.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    radius: 30.0,
                                    child: IconButton(
                                      icon: Icon(
                                        sendButton
                                            ? MaterialIcons.send
                                            : MaterialCommunityIcons.microphone,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                          sendMessage(
                                            message: _textEditingController.text
                                                .trim(),
                                            sourceId: widget.sourceChat.id,
                                            targetId: widget.chatModel.id,
                                            path: '',
                                          );
                                          _textEditingController.clear();
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // _showEmojiPicker ? emojiSelect() : Container(),
                          Visibility(
                            visible: _showEmojiPicker,
                            child: emojiSelect(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
