import 'package:college_events/screen/login_signup_screen/judge_login_screen.dart';
import 'package:college_events/screen/login_signup_screen/student_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAsScreen extends StatefulWidget {
  @override
  _LoginAsScreenState createState() => _LoginAsScreenState();
}

class _LoginAsScreenState extends State<LoginAsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fitHeight,
                image: AssetImage('images/bgscreen.jpg'),
              )),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 80),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Image(
                  image: AssetImage('images/blogo.png'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 60),
                  width: 200,
                  child: Image(
                    image: AssetImage('images/login.png'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100),
                  child: Text(
                    "Click on Login As and Choose how you want to Login into College Event",
                    style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: MediaQuery.of(context).size.width * 0.82,
                  child: MaterialButton(
                    child: Text(
                      "LOGIN AS",
                      style: GoogleFonts.openSans(fontSize: 20),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                children: <Widget>[
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: MaterialButton(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Admin",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JudgeLoginPageScreen(
                                                  uId: 0,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Student",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    StudentRegisterScreen(
                                                  uId: 1,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                        margin: EdgeInsets.only(top: 3),
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "Judge",
                                              style: GoogleFonts.openSans(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JudgeLoginPageScreen(
                                                        uId: 2),
                                              ),
                                            );
                                          },
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.78,
                                        margin: EdgeInsets.only(top: 4),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
