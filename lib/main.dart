import 'package:college_events/screen/admin_screens/add_student_screen/add_student_screen.dart';
import 'package:college_events/screen/admin_screens/add_student_screen/class_list_screen.dart';
import 'package:college_events/screen/feedback_screen/feedback_screen.dart';
import 'package:college_events/screen/home_screen/home_screen.dart';
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
      home: HomeScreen(uId: 0,),
      theme: ThemeData(
        primaryColor: Color(int.parse('0xff144365')),
        // accentColor: Color(int.parse('0xfff0f4f7')),
        backgroundColor: Color(int.parse('0xfff0f4f7')),
      ),
    );
  }
}
