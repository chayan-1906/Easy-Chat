import 'dart:math';

import 'package:camera/camera.dart';
import 'package:easy_chat/screens/camera_view_screen.dart';
import 'package:easy_chat/screens/video_view_screen.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras;

class CameraScreen extends StatefulWidget {
  final Function onImageSend;
  const CameraScreen({Key key, this.onImageSend}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController _cameraController;
  Future<void> cameraValue;
  bool _isRecording = false;
  bool _flash = false;
  bool _isCameraFront = true;
  double transformAngle = 0;

  void takePhoto(BuildContext context) async {
    // final path =
    //     join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    XFile file = await _cameraController.takePicture();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return CameraViewScreen(
          path: file.path,
          onImageSend: widget.onImageSend,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: CameraPreview(_cameraController),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// flash_off iconbutton
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _flash = !_flash;
                          });
                          _flash
                              ? _cameraController.setFlashMode(FlashMode.torch)
                              : _cameraController.setFlashMode(FlashMode.off);
                        },
                        icon: Icon(
                          _flash ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                          size: 28.0,
                        ),
                      ),

                      /// panorama_fish_eye iconbutton
                      GestureDetector(
                        onTap: () {
                          if (!_isRecording) {
                            takePhoto(context);
                          }
                        },
                        onLongPress: () async {
                          await _cameraController.startVideoRecording();
                          setState(() {
                            _isRecording = true;
                          });
                        },
                        onLongPressUp: () async {
                          XFile videoPath =
                              await _cameraController.stopVideoRecording();
                          setState(() {
                            _isRecording = false;
                          });
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return VideoViewScreen(videoPath: videoPath.path);
                          }));
                        },
                        child: _isRecording
                            ? Icon(
                                Icons.radio_button_on,
                                color: Colors.redAccent,
                                size: 80.0,
                              )
                            : Icon(
                                Icons.panorama_fish_eye,
                                color: Colors.white,
                                size: 70.0,
                              ),
                      ),

                      /// flip_camera_ios iconbutton
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            _isCameraFront = !_isCameraFront;
                            transformAngle = transformAngle + pi;
                          });
                          int cameraPosition = _isCameraFront ? 0 : 1;
                          _cameraController = CameraController(
                              cameras[cameraPosition], ResolutionPreset.high);
                          cameraValue = _cameraController.initialize();
                        },
                        icon: Transform.rotate(
                          angle: transformAngle,
                          child: Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Hold for video, tap for photo',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
