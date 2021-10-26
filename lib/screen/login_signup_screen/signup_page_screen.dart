import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/login_signup_screen/login_page_screen.dart';
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
                            // PERFORM VALIDATION
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email Id '),
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                          validator: (value) {
                            // PERFORM VALIDATION
                          },
                          onSaved: (value) {},
                        ),TextFormField(
                          decoration: InputDecoration(labelText: 'Mobile Number '),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            // PERFORM VALIDATION
                          },
                          onSaved: (value) {},
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password '),
                          // keyboardType: TextInputType.visiblePassword,
                          obscureText: true,
                          validator: (value) {
                            // PERFORM VALIDATION
                          },
                          onSaved: (value) {},
                        ),
                        Center(
                          child:RaisedButton(
                            child: Text("REGISTER",style: TextStyle(fontSize: 20),),
                            onPressed: () {},
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
}

