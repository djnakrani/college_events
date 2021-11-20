import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/participate_screen/participate_details_screen.dart';
import 'package:college_events/screen/participate_screen/participate_name_screen.dart';
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
      home: ParticipateDetailsScreen(),
    );
  }
}
