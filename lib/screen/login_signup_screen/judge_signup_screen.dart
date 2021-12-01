import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/login_signup_screen/judge_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class JudgeSignupScreen extends StatefulWidget{
  final int uId;
  JudgeSignupScreen({required this.uId});

  @override
  _JudgeSignupScreenState createState() => _JudgeSignupScreenState();
}

class _JudgeSignupScreenState extends State<JudgeSignupScreen>{
  late String _name,_email,_mono,_password,_cpassword;
  final auth = FirebaseAuth.instance;
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
              image:AssetImage('images/bgscreen.jpg'),
            )
        ),
        child:
            Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 15,vertical: 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: _formSignupKey,
                      child:Column(
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
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Enter Your Full Name '),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your name';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _name = value.toString();
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Enter Email Id '),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Email ID';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _email = value.toString();
                            },
                          ),TextFormField(
                            decoration: InputDecoration(labelText: 'Mobile Number '),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Your Mobile Number';
                              }
                              else if(value.length != 10){
                                return "Invalid Mobile Number";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _mono = value.toString();
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password '),
                            // keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter Password';
                              }else if(value.length <= 8 ){
                                return "Minimum 8 letters required";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _password = value.toString();
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Confirm Password '),
                            // keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            validator: (value) {
                              if(value!.length <= 8 ){
                                return "Minimum 8 Digit Password";
                              }
                              return null;
                            },
                            onChanged: (value) {
                              _cpassword = value.toString();
                            },
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            width: MediaQuery.of(context).size.width * 0.78,
                            child:MaterialButton(
                              child: Text("REGISTER",style: GoogleFonts.openSans(fontSize: 20),),
                              onPressed: () {
                                if(_formSignupKey.currentState!.validate()){
                                  auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
                                    snackBar = SnackBar(content: Text("Link Send Into Email"));
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen(uId: widget.uId,)));
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => JudgeLoginPageScreen(uId: widget.uId,)));
                            },
                            child: Text(
                              'Already have an account?   LOGIN',
                              style: GoogleFonts.openSans(color: Theme.of(context).primaryColor, fontSize: 16,fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ),
              ),
            )
        )
    );
  }

  void ShowError(onError) {
    if (onError.toString().contains('invalid-email')) {
      snackBar = SnackBar(content: Text('Email Address Invalid'));
    }
    else{
      snackBar = SnackBar(content: Text("Something Went Wrong..."));
    }
  }
}

