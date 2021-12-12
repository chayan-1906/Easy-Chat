import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:video_player/video_player.dart';

class VideoViewScreen extends StatefulWidget {
  final String videoPath;
  const VideoViewScreen({Key key, this.videoPath}) : super(key: key);

  @override
  State<VideoViewScreen> createState() => _VideoViewScreenState();
}

class _VideoViewScreenState extends State<VideoViewScreen> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then((_) {
        setState(() {});
      });
  }

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
              child: _videoPlayerController.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: _videoPlayerController.value.aspectRatio,
                      child: VideoPlayer(_videoPlayerController),
                    )
                  : Container(),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                color: Colors.black38,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                child: TextFormField(
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
                    suffixIcon: CircleAvatar(
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
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _videoPlayerController.value.isPlaying
                        ? _videoPlayerController.pause()
                        : _videoPlayerController.play();
                  });
                },
                child: CircleAvatar(
                  radius: 33.0,
                  backgroundColor: Colors.black38,
                  child: Icon(
                    _videoPlayerController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50.0,
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
