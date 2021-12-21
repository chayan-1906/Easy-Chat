import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CameraViewScreen extends StatelessWidget {
  final String path;
  final Function onImageSend;
  const CameraViewScreen({Key key, this.path, this.onImageSend})
      : super(key: key);

  static TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          /// crop_rotate
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.crop_rotate, size: 27.0),
          ),

          /// emoji_emotions_outlined
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.emoji_emotions_outlined, size: 27.0),
          ),

          /// title
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.title, size: 27.0),
          ),

          /// edit
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, size: 27.0),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(path),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: TextFormField(
                  controller: _textEditingController,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                  ),
                  maxLines: 1000,
                  minLines: 1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Add caption...',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                    prefixIcon: Icon(
                      Icons.add_photo_alternate,
                      color: Colors.white,
                      size: 27.0,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        onImageSend(path, _textEditingController.text.trim());
                      },
                      child: CircleAvatar(
                        radius: 27.0,
                        child: Icon(
                          MaterialCommunityIcons.check_circle_outline,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        backgroundColor: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
