import 'package:college_events/screen/login_signup_screen/judge_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentPasswordScreen extends StatefulWidget {
  final int uId;
  final String email;

  StudentPasswordScreen({required this.uId, required this.email});

  @override
  _StudentPasswordScreenState createState() => _StudentPasswordScreenState();
}

class _StudentPasswordScreenState extends State<StudentPasswordScreen> {
  final auth = FirebaseAuth.instance;
  final _formForgotKey = GlobalKey<FormState>();

  late SnackBar snackBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
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
                  key: _formForgotKey,
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
                        margin: EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          "College Events",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "will send one time password to verify your Email ID",
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       labelText: 'Enter Registered Email ID'),
                      //   keyboardType: TextInputType.emailAddress,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "This Field Is Required";
                      //     }
                      //     return null;
                      //   },
                      //   onChanged: (value) {
                      //     _pwd = value;
                      //   },
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width * 0.78,
                        child: RaisedButton(
                          child: Text(
                            "Send Link",
                            style: GoogleFonts.openSans(fontSize: 20),
                          ),
                          onPressed: () {
                            if (_formForgotKey.currentState!.validate()) {
                              auth
                                  .sendPasswordResetEmail(email: widget.email)
                                  .then((value) {
                                snackBar = SnackBar(
                                    content: Text("Link Send Into Email"));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JudgeLoginPageScreen(
                                                uId: widget.uId)));
                              }).catchError((onError) {
                                if (onError
                                    .toString()
                                    .contains("user-not-found")) {
                                  snackBar =
                                      SnackBar(content: Text("User Not Found"));
                                } else {
                                  snackBar =
                                      SnackBar(content: Text("Internal Error"));
                                }
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
                        child: widget.uId == 2
                            ? FlatButton(
                                padding: EdgeInsets.all(10),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              JudgeLoginPageScreen(
                                                  uId: widget.uId)));
                                },
                                child: Text(
                                  'New User?  REGISTER',
                                  style: GoogleFonts.openSans(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            : SizedBox(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
