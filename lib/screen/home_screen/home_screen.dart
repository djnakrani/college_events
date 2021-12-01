import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/notification_screen/notification_list_screen.dart';
import 'package:college_events/widgets/carousel_slider.dart';
import 'package:college_events/widgets/content_scroll_vertical.dart';
import 'package:college_events/widgets/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final int uId;

  HomeScreen({required this.uId});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  String _sId = "";
  String email = "";
  String _fName = "";

  @override
  void initState() {
    super.initState();
    setPreferences();
  }

  @override
  Widget build(BuildContext context) {
    print(_sId);
    return Scaffold(
      key: _scaffoldKey,
      drawer: navigationDrawer(
        uId: widget.uId, fName: _fName, email: email,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(top: 4, left: 10.0),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        title: Center(
          child: Text(
            "College Events",
            style: GoogleFonts.openSans(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(top: 4, right: 10.0),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsListScreen(widget.uId))),
            icon: Icon(Icons.notifications),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: CarouselSliderWidget(
              uId: widget.uId,
              mainTitle: 'Today Events',
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
              uId: widget.uId,
              mainTitle: 'Upcoming Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
              uId: widget.uId,
              mainTitle: 'Past Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
        ],
      )),
    );
  }

  setPreferences() async {
    final User? user = widget.auth.currentUser;
    // final userId = user!.uid;
    String? userEmail = user!.email;
    email = userEmail!;
    print("User Id is : $userEmail");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("set Preference");
    await prefs.setString("emailId", userEmail);
    if (widget.uId == 0) {
      await prefs.setBool("isAdminLogin", true);
    } else if (widget.uId == 1) {
      await prefs.setBool("isStdLogin", true);
      final id = objStudentDetails
          .where('emailid', isEqualTo: userEmail)
          .get()
          .then((value) => value.docs.first.id);
      getUserId(id);

    } else if (widget.uId == 2) {
      await prefs.setBool("isJudgeLogin", true);
    } else {}
    _fName = prefs.getString("fullname")!;
  }
  Future<void> getUserId(futureString) async {
    final sId = await futureString;
    setState(() => _sId = sId);
    final stdDetails = objStudentDetails.doc(_sId).get();
    stdDetails.then(
          (value) async {
        if (value.exists) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("stdId", _sId);
          await prefs.setString("class", value['class']);
          await prefs.setString("fullname", value['fullname']);
          await prefs.setString("gender", value['gender']);
          await prefs.setString("mobileno", value['mobileno']);
          await prefs.setString("collegename", value['collegename']);
        } else { print("not set");}
      },
    );
  }
}
