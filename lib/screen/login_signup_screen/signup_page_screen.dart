import 'package:college_events/screen/home_screen/home_screen.dart';
import 'package:college_events/screen/login_signup_screen/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class signup_page_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signup(),
    );
  }
 
}

class signup extends StatefulWidget{
  @override
  _signupState createState() => _signupState();

}

class _signupState extends State<signup>{
  late String _name,_email,_mono,_password;
  final auth = FirebaseAuth.instance;
  final _formSignupKey = GlobalKey<FormState>();


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
              fit: BoxFit.fitHeight,
              image:AssetImage('images/bgscreen.jpg'),
            )
        ),
        child:
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Container(
                  height: 550,
                  width: 350,
                  padding: EdgeInsets.all(20.0),
                  child: Form(
                    key: _formSignupKey,
                    child:ListView(
                      children: [
                        Container(
                          width: 900,
                          height: 150,
                          child: Image.asset('images/blogo.png'),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Student Full Name '),
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            // print("Name:"+ value.toString());
                            if (value == null || value.isEmpty) {
                              return 'Not Field Is Required';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _name = value.toString();
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email Id '),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Not Field Is Required';
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
                              return 'Not Field Is Required';
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
                            if(value!.length <= 8 ){
                              return "Minimum 8 Digit Password";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _password = value.toString();
                          },
                        ),
                        Center(
                          child:RaisedButton(
                            child: Text("REGISTER",style: TextStyle(fontSize: 20),),
                            onPressed: () {
                                // print(_name);
                                // print(_email);
                                // print(_mono);
                                // print(_password);
                              if(_formSignupKey.currentState!.validate()){
                                auth.createUserWithEmailAndPassword(email: _email, password: _password).then((value) {
                                  snackBar = SnackBar(content: Text("Link Send Into Email"));
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomeScreen()));
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
                                    builder: (context) => login_page_screen()));
                          },
                          child: Text(
                            'Already Signup?',
                            style: TextStyle(color: Colors.blue, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
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

