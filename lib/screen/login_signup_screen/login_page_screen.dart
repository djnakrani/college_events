import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/login_signup_screen/signup_page_screen.dart';
import 'package:college_events/screen/login_signup_screen/forgot_screen.dart';
import 'package:flutter/material.dart';

class login_page_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
 
}

class login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();

}

class _LoginState extends State<login>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text("LOGIN"),
      // ),
      body:
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image:AssetImage('images/bgscreen.jpg'),
            )
        ),
        child:ListView(
        children:[
            Column(
              children:<Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Container(
                        width: 350,
                        height: 200,
                        margin: EdgeInsets.all(5.0),
                        child: Image.asset('images/blogo.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username Or Email Id',
                        hintText: 'Enter Your Register Email Id'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextField(

                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password'),
                  ),
                ),
                FlatButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => forgot_screen()));
                  },
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.red, fontSize: 15),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      // PERFORM LOGIN ACTIVITY
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(30.0),
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => signup_page_screen()));
                  },
                  child: Text(
                    'New User? Create Account',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                // SizedBox(height: 250,)
              ],
            ),
        ],
        ),//
      ),
    );
  }

}