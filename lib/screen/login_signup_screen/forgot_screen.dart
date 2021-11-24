import 'dart:async';

import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/login_signup_screen/signup_page_screen.dart';
import 'package:college_events/screen/login_signup_screen/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class forgot_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: forgot(),
    );
  }
}

class forgot extends StatefulWidget {
  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<forgot> {


  late String _email;
  final auth = FirebaseAuth.instance;
  final _formForgotKey = GlobalKey<FormState>();

  late SnackBar snackBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   title: Text("LOGIN"),
      // ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/bgscreen.jpg'),
        )),
        child: Center(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 400,
              width: 350,
              padding: EdgeInsets.all(20.0),
              child: Form(
                key: _formForgotKey,
                child: ListView(
                  children: <Widget>[
                    Container(
                      width: 900,
                      height: 150,
                      child: Image.asset('images/blogo.png'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Email '),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if(value!.isEmpty){
                            return "This Field Is Requied";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _email = value;
                      },
                    ),
                    Center(
                      child: RaisedButton(
                        child: Text(
                          "Send Link",
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if(_formForgotKey.currentState!.validate()) {
                            auth.sendPasswordResetEmail(email: _email).then((value) {
                              snackBar = SnackBar(content: Text("Link Send Into Email"));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => login_page_screen()));
                            }).catchError((onError){
                              if (onError.toString().contains("user-not-found")) {
                                snackBar = SnackBar(content: Text("User Not Found"));
                              } else {
                                snackBar = SnackBar(content: Text("Internal Error"));
                              }
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50.0),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(20.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => login_page_screen()));
                      },
                      child: Text(
                        'Already Have a Account',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    FlatButton(
                      padding: EdgeInsets.all(20.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => signup_page_screen()));
                      },
                      child: Text(
                        'New User? Create Account',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
