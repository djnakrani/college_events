import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/login_signup_screen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(

  ));
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "College Events",
      home: splashscreen(),
      theme: ThemeData(
        primaryColor: Color(int.parse('0xff144365')),
        backgroundColor: Color(int.parse('0xfff2f5f7')),
      ),
    );
  }
}
