import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/login_signup_screen/judge_login_screen.dart';
import 'package:college_events/screen/login_signup_screen/loginas_screen.dart';
import 'package:college_events/screen/login_signup_screen/std_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentRegisterScreen extends StatefulWidget {
  final int uId;

  StudentRegisterScreen({required this.uId});

  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  CollectionReference objStudentDetails =
      FirebaseFirestore.instance.collection('student_details');
  late String _email, _password;
  late String _enrollno;
  final auth1 = FirebaseAuth.instance;
  final _formSignupKey = GlobalKey<FormState>();
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
            child: Center(
              child: SingleChildScrollView(
                child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Form(
                        key: _formSignupKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
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
                                    fontSize: 15),
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
                                    fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  labelText: 'Enter Enrollment Number'),
                              onChanged: (value) {
                                _enrollno = value.toString();
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: MaterialButton(
                                child: Text(
                                  "REGISTER",
                                  style: GoogleFonts.openSans(fontSize: 20),
                                ),
                                onPressed: () {
                                  if (_formSignupKey.currentState!.validate()) {
                                    final stdDetails =
                                        objStudentDetails.doc(_enrollno).get();
                                    stdDetails.then(
                                      (value) {
                                        if (value.exists) {
                                          _email = value['emailid'];
                                          print(_email);
                                          print("value hai");
                                        } else {
                                          print("value nahi hai");
                                        }
                                      },
                                    );
                                    _password = "13572468";
                                    auth1
                                        .createUserWithEmailAndPassword(
                                            email: _email, password: _password)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  StudentPasswordScreen(uId: widget.uId, email: _email,)));
                                    }).catchError((onError) {
                                      ShowError(onError);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
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
                                        builder: (context) => JudgeLoginPageScreen(uId: widget.uId)));
                              },
                              child: Text(
                                'Have Password?? Login',
                                style: GoogleFonts.openSans(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              // margin: EdgeInsets.only(bottom: 10,top: 5),
                              child: Text(
                                "Or",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            MaterialButton(
                              padding: EdgeInsets.all(8.0),
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
                    )),
              ),
            )));
  }

  void ShowError(onError) {
    if (onError.toString().contains('invalid-email')) {
      snackBar = SnackBar(content: Text('Email Address Invalid'));
    } else {
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}
