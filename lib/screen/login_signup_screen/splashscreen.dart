import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'loginas_screen.dart';

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
        body: Center(
          child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: AssetImage('images/splash.png'),
                  )),
          ),
        )
    );
  }

  void _navigatepage() async{
    await Future.delayed(Duration(milliseconds: 2000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginAsScreen()));
  }
}