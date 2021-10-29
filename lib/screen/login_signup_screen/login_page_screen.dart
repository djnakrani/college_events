import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/login_signup_screen/signup_page_screen.dart';
import 'package:college_events/screen/login_signup_screen/forgot_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class login_page_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<login> {

  late String _email,_password;
  final auth = FirebaseAuth.instance;
  final _formSigninKey = GlobalKey<FormState>();
  late SnackBar snackBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('images/bgscreen.jpg'),
          )),
          child: Stack(
            children: <Widget>[
              // Container(
              //   width: 350,
              //   height: 200,
              //   margin: EdgeInsets.only(top: 30.0,left: 5.0,right: 5.0,bottom: 20.0),
              //   child: Image.asset('images/blogo.png'),
              // ),
              Center(
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    height: 500,
                    width: 350,
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formSigninKey,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            width: 900,
                            height: 150,
                            margin: EdgeInsets.only(
                                top: 5.0, left: 5.0, right: 5.0, bottom: 5.0),
                            child: Image.asset('images/blogo.png'),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Email '),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Not Field Is Required';
                              }
                              return null;                            },
                            onChanged: (value) {
                              _email = value.toString();
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password '),
                            // keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Not Field Is Required';
                              }
                              else if(value.length <= 8){
                                return 'Minimum 8 Character';
                              }
                              return null;                            },
                            onChanged: (value) {
                              _password = value.toString();
                            },
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => forgot_screen()));
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            ),
                          ),
                          Center(
                            child: RaisedButton(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(fontSize: 20),
                              ),
                              onPressed: () {
                                if(_formSigninKey.currentState!.validate()){
                                  auth.signInWithEmailAndPassword(email: _email, password: _password).then((value) {
                                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                                  }).catchError((onError){
                                    ShowError(onError);
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
                            padding: EdgeInsets.all(30.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          signup_page_screen()));
                            },
                            child: Text(
                              'New User? Create Account',
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void ShowError(onError) {
    if (onError.toString().contains('invalid-email')) {
      snackBar = SnackBar(content: Text('Email Address Invalid'));
    }
    else if (onError.toString().contains('user-not-found')) {
      snackBar = SnackBar(content: Text('User Not Register'));
    }
    else{
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}
