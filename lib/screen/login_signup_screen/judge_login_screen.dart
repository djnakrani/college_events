import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/login_signup_screen/judge_signup_screen.dart';
import 'package:college_events/screen/login_signup_screen/forgot_screen.dart';
import 'package:college_events/screen/login_signup_screen/student_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'loginas_screen.dart';

class JudgeLoginPageScreen extends StatefulWidget {
  final int uId;

  JudgeLoginPageScreen({required this.uId});

  @override
  _JudgeLoginPageScreenState createState() => _JudgeLoginPageScreenState();
}

class _JudgeLoginPageScreenState extends State<JudgeLoginPageScreen> {
  late String _email, _password;
  final auth = FirebaseAuth.instance;
  final _formSigninKey = GlobalKey<FormState>();
  late SnackBar snackBar;
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  final objJudgeDetails =
      FirebaseFirestore.instance.collection("judge_details");
  var objEventDetails = FirebaseFirestore.instance.collection("event_details");
  String userDocId = "";
  String email = "";
  String fName = "";
  String gender = "";

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
                        key: _formSigninKey,
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
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                "Enter Valid Credentials to Login as",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10, top: 5),
                              child: Text(
                                widget.uId == 2
                                    ? "Judge"
                                    : widget.uId == 0
                                        ? "Admin"
                                        : "Student",
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'Email '),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Registered Email ID';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                _email = value.toString();
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Password '),
                              // keyboardType: TextInputType.visiblePassword,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter password';
                                }

                                return null;
                              },
                              onChanged: (value) {
                                _password = value.toString();
                              },
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotScreen(widget.uId)));
                                  },
                                  child: Text(
                                    'Forgot Password?',
                                    style: GoogleFonts.openSans(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.78,
                              child: MaterialButton(
                                child: Text(
                                  "LOGIN",
                                  style: GoogleFonts.openSans(fontSize: 20),
                                ),
                                onPressed: () async {
                                  if (_formSigninKey.currentState!.validate()) {
                                    auth
                                        .signInWithEmailAndPassword(
                                            email: _email, password: _password)
                                        .then((value) {
                                      email = _email;
                                      setPreferences();
                                      Navigator.of(context)
                                          .pushReplacement(MaterialPageRoute(
                                              builder: (context) => HomeScreen(
                                                    uId: widget.uId,
                                                  )));
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
                            Container(
                              child: widget.uId != 0
                                  ? MaterialButton(
                                      padding: EdgeInsets.all(8.0),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    widget.uId == 1
                                                        ? StudentRegisterScreen(
                                                            uId: widget.uId)
                                                        : JudgeSignupScreen(
                                                            uId: widget.uId)));
                                      },
                                      child: Text(
                                        widget.uId == 1
                                            ? "Don't have credentials?? REGISTER"
                                            : 'New User?  REGISTER',
                                        style: GoogleFonts.openSans(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  : SizedBox(),
                            ),
                            Container(
                              // margin: EdgeInsets.only(bottom: 10,top: 5),
                              child: widget.uId != 0
                                  ? Text(
                                      "Or",
                                      style: GoogleFonts.openSans(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 17),
                                      textAlign: TextAlign.center,
                                    )
                                  : SizedBox(),
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
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future setPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("emailId", email);
    if (widget.uId == 0) {
      await prefs.setBool("isAdminLogin", true);
      await prefs.setString("fullname", "Admin");
      await prefs.setString("email", email);
    } else if (widget.uId == 1) {
      await prefs.setBool("isStdLogin", true);
      final id = objStudentDetails
          .where('emailid', isEqualTo: email)
          .get()
          .then((value) => value.docs.first.id);
      await getStdUserId(id);
    } else if (widget.uId == 2) {
      await prefs.setBool("isJudgeLogin", true);
      final id = objJudgeDetails
          .where('emailid', isEqualTo: email)
          .get()
          .then((value) => value.docs.first.id);
      await getJudgeUserId(id);
    } else {}
  }

  Future<void> getStdUserId(futureString) async {
    final sId = await futureString;
    setState(() => userDocId = sId);
    final stdDetails = objStudentDetails.doc(userDocId).get();
    stdDetails.then(
      (value) async {
        if (value.exists) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("stdId", userDocId);
          await prefs.setString("class", value['class']);
          await prefs.setString("email", value['emailid']);
          await prefs.setString("fullname", value['fullname']);
          await prefs.setString("gender", value['gender']);
          await prefs.setString("mobileno", value['mobileno']);
          await prefs.setString("collegename", value['collegename']);
          print("Set Data");
        } else {
          print("not set");
        }
      },
    );
  }

  Future<void> getJudgeUserId(futureString) async {
    final jId = await futureString;
    setState(() => userDocId = jId);
    final judgeDetails = objJudgeDetails.doc(userDocId).get();
    judgeDetails.then(
      (value) async {
        if (value.exists) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          print("Set Data");
          await prefs.setString("judgeId", userDocId);
          await prefs.setString("fullname", value['fullname']);
          await prefs.setString("email", value['emailid']);
          await prefs.setString("gender", value['gender']);
          await prefs.setString("address", value['address']);
          await prefs.setString("mobileno", value['mobileno']);
        } else {
          print("not set");
        }
      },
    );
  }

  void ShowError(onError) {
    if (onError.toString().contains('invalid-email')) {
      snackBar = SnackBar(content: Text('Email Address Invalid'));
    } else if (onError.toString().contains('user-not-found')) {
      snackBar = SnackBar(content: Text('User Not Register'));
    } else {
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}
