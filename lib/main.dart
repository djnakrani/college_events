import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/home_screen/splashscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "College Events",
      home: splashscreen(),
    );
  }
}
