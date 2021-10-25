import 'package:college_events/screen/home_screen/homescreen.dart';
import 'package:college_events/screen/login_signup_screen/login_page_screen.dart';
import 'package:flutter/material.dart';

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
      body:Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitHeight,
              image:AssetImage('images/bgscreen.jpg'),
            )
        ),
        child: ListView(
          children: [
            Column(
              children:<Widget>[
                // Padding(
                //   padding: EdgeInsets.only(top: 40.0,bottom: 10.0),
                //   child: Center(
                //     child: Text("REGISTER",
                //       style: TextStyle(color: Colors.black,fontSize: 36,fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top:2.0),
                  child: Center(
                    child: Container(
                        width: 350,
                        height: 200,
                        margin: EdgeInsets.all(5.0),
                        child: Image.asset('images/blogo.png')),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Full Name',
                        hintText: 'Enter Your Full Name'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email Id',
                        hintText: 'Enter Your Email Id'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Mobile Number',
                        hintText: 'Enter Your Mobile Number'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter Password'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.all(30.0),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => login_page_screen()));
                  },
                  child: Text(
                    'Already Signup?',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

