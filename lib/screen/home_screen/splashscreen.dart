import 'package:flutter/material.dart';
import 'package:college_events/screen/home_screen//homescreen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class splashscreen extends StatefulWidget{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<splashscreen>{
  @override
  void initState(){
    super.initState();
    _navigatepage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('images/splash.png'),
                )),
        )
    );
  }

  void _navigatepage() async{
    await Future.delayed(Duration(milliseconds: 1500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}