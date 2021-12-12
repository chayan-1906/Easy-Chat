import 'package:camera/camera.dart';
import 'package:easy_chat/screens/camera_screen.dart';
import 'package:easy_chat/screens/login_screen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xFF075E54),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF128C7E),
        ),
        primaryIconTheme: IconThemeData(
          color: Color(0xFF128C7E),
        ),
        primaryColor: Color(0xFF075E54),
        accentColor: Color(0xFF128C7E),
      ),
      // home: HomeScreen(),
      home: LoginScreen(),
    );
  }
}
