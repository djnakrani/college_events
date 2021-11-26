import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginas_screen.dart';

class StudentLoginPageScreen extends StatefulWidget {
  int uId;
  StudentLoginPageScreen({required this.uId});

  @override
  _StudentLoginPageScreenState createState() => _StudentLoginPageScreenState();
}

class _StudentLoginPageScreenState extends State<StudentLoginPageScreen> {
  late String _enrollno;
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
                              margin: EdgeInsets.only(bottom: 20,top: 5),
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
                              child: RaisedButton(
                                child: Text(
                                  "LOGIN",
                                  style: GoogleFonts.openSans(fontSize: 20),
                                ),
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                              ),
                            ),
                            FlatButton(
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
    } else if (onError.toString().contains('user-not-found')) {
      snackBar = SnackBar(content: Text('User Not Register'));
    } else {
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}
