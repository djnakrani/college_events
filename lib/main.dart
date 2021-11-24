import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/match_screen/match_name_screen.dart';
import 'package:college_events/screen/team_screen/team_name_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "College Events",
      home: HomeScreen(),
      theme: ThemeData(
        primaryColor: Color(int.parse('0xff144365')),
      ),
    );
  }
}
