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
  final objJudgeDetails =
      FirebaseFirestore.instance.collection("judge_details");
  var objEventDetails = FirebaseFirestore.instance.collection("event_details");
  String userDocId = "";
  String email = "";
  String fName = "";
  String gender = "";
  List<dynamic> tmpList = [];
  List<dynamic> currentList = [];
  List<dynamic> currentNameList = [""];

  @override
  void initState() {
    setPreferences();
    // getName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(userDocId);
    return Scaffold(
      key: _scaffoldKey,
      drawer: navigationDrawer(
        uId: widget.uId,
        fName: fName,
        email: email,
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
                currentNameList: currentNameList,
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              child: ContentScrollVertical(
                uId: widget.uId,
                mainTitle: 'Upcoming Events',
                imageHeight: 300.0,
                imageWidth: 200.0,
                stdId: userDocId,
              ),
            ),
            SizedBox(height: 20.0),
            GestureDetector(
              child: ContentScrollVertical(
                uId: widget.uId,
                mainTitle: 'Past Events',
                imageHeight: 300.0,
                imageWidth: 200.0,
                stdId: userDocId,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future setPreferences() async {
    await Future.delayed(Duration(seconds: 2));
    final User? user = widget.auth.currentUser;
    String? userEmail = user!.email;
    email = userEmail!;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("emailId", userEmail);
    if (widget.uId == 0) {
      await prefs.setBool("isAdminLogin", true);
      await prefs.setString("fullname", "Admin");
      await getName();
    } else if (widget.uId == 1) {
      await prefs.setBool("isStdLogin", true);
      final id = objStudentDetails
          .where('emailid', isEqualTo: userEmail)
          .get()
          .then((value) => value.docs.first.id);
      await getStdUserId(id);
      await getName();
    } else if (widget.uId == 2) {
      await prefs.setBool("isJudgeLogin", true);
      final id = objJudgeDetails
          .where('emailid', isEqualTo: userEmail)
          .get()
          .then((value) => value.docs.first.id);
      await getJudgeUserId(id);
      await getName();
    } else {}
    await getPastEventsList();
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
          await prefs.setString("fullname", value['fullname']);
          await prefs.setString("gender", value['gender']);
          await prefs.setString("mobileno", value['mobileno']);
          await prefs.setString("collegename", value['collegename']);
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
          await prefs.setString("gender", value['gender']);
          await prefs.setString("address", value['address']);
          await prefs.setString("mobileno", value['mobileno']);
        } else {
          print("not set");
        }
      },
    );
  }

  Future<void> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    fName = await prefs.getString("fullname")!;
    gender = await prefs.getString("gender")!;
  }

  Future<List<String>> getPastEvents() async {
    final id = objEventDetails
        .where('startdate',
            isLessThanOrEqualTo: new DateTime.now().add(Duration(hours: 12)))
        .get()
        .then((value) => value.docs.map((e) => e.id).toList());
    return await id;
  }

  Future getPastEventsList() async {
    final Future<List<dynamic>> futureList = getPastEvents();
    var list = await futureList;
    print("Past is $list");
    tmpList = list;
    await getUpcomingEventsList();
  }

  Future<List<String>> getUpcomingEvents1() async {
    final id = objEventDetails
        .where('enddate',
            isGreaterThanOrEqualTo: new DateTime.now().add(Duration(hours: 1)))
        .get()
        .then((value) => value.docs.map((e) => e.id).toList());
    return await id;
  }

  Future getUpcomingEventsList() async {
    final Future<List<dynamic>> futureList = getUpcomingEvents1();
    final currentList = await futureList;
    print("List is $currentList");
    currentList.removeWhere((element) => !tmpList.contains(element));
    print("currentList = $currentList");
    for (var e in currentList) {
      objEventDetails.doc(e).get().then((value) {
        if (value.exists) {
          currentNameList.add(value["eventtitle"]);
          print("Value ${value["eventtitle"]}");
        }
      });
    }
  }
}
