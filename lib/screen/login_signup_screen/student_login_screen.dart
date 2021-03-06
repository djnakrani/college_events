import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/login_signup_screen/forgot_screen.dart';
import 'package:college_events/screen/login_signup_screen/std_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginas_screen.dart';
import 'dart:math';

class StudentLoginPageScreen extends StatefulWidget {
  final int uId;

  StudentLoginPageScreen({required this.uId});

  @override
  _StudentLoginPageScreenState createState() => _StudentLoginPageScreenState();
}

class _StudentLoginPageScreenState extends State<StudentLoginPageScreen> {
  CollectionReference objStudentDetails =
      FirebaseFirestore.instance.collection('student_details');
  late String _enrollno;
  late String _email,_password;
  final auth = FirebaseAuth.instance;
  final _formLoginKey = GlobalKey<FormState>();
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
            ),
          ),
          child: Stack(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formLoginKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Image.asset('images/blogo.png'),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              width: 170,
                              child: Image(
                                image: AssetImage('images/login.png'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Text(
                                "Enter Your Enrollment Number to Login as",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20, top: 5),
                              child: Text(
                                "Student",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Enter Enrollment Number '),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your enrollment number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _enrollno = value.toString();
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: MaterialButton(
                                child: Text(
                                  "LOGIN",
                                  style: GoogleFonts.openSans(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_formLoginKey.currentState!.validate()) {
                                    _email = "kaahs@gmail.com";
                                    _password = "9205";
                                    auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
                                      snackBar = SnackBar(content: Text("Link Send Into Email"));
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentPasswordScreen(uId: widget.uId, email: _email,)));
                                    }).catchError((onError){
                                      ShowError(onError);
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    });

                                  }
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                              ),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(10.0),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginAsScreen()));
                              },
                              child: Text(
                                'Back to LOGIN AS',
                                style: GoogleFonts.openSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
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
    } else {
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}
