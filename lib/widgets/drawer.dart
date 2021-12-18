import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/add_student_screen/class_list_screen.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/add_events_list_screen.dart';
import 'package:college_events/screen/admin_screens/manage_judge_screen/judge_list_screen.dart';
import 'package:college_events/screen/events_screen/events_list_screen.dart';
import 'package:college_events/screen/feedback_screen/feedback_list_screen.dart';
import 'package:college_events/screen/feedback_screen/quick_feedback.dart';
import 'package:college_events/screen/gallery_screen/gallery_screen.dart';
import 'package:college_events/screen/login_signup_screen/loginas_screen.dart';
import 'package:college_events/screen/profile_screen/judge_profile_screen.dart';
import 'package:college_events/screen/profile_screen/student_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class navigationDrawer extends StatelessWidget {
  final int uId;
  final String fName;
  final String email;

  navigationDrawer({
    required this.uId,
    required this.fName,
    required this.email,
  });

  late String userDocId = "";
  late String gender = "";
  late String mono = "";
  late String clgName = "";
  late String sClass = "";
  late String address = "";

  logoutPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (uId == 1) {
      sClass = prefs.getString("class")!;
      userDocId = prefs.getString("stdId")!;
      gender = prefs.getString("gender")!;
      mono = prefs.getString("mobileno")!;
      clgName = prefs.getString("collegename")!;
    } else if (uId == 2) {
      userDocId = prefs.getString("judgeId")!;
      gender = prefs.getString("gender")!;
      mono = prefs.getString("mobileno")!;
      address = prefs.getString("address")!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final objFeedbackDetails =
        FirebaseFirestore.instance.collection("feedback_details");
    getPrefData();
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(context),
            createDrawerBodyItem(
              icon: Icons.account_circle,
              text: uId == 0 ? 'Add Student' : 'Profile',
              onTap: () {
                uId == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassListScreen(),
                        ))
                    : uId == 1
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfileScreen(
                                pId: 1,
                                gender: gender,
                                enrollNo: userDocId,
                                sClass: sClass,
                                clgName: clgName,
                                mono: mono,
                                fullName: fName,
                                emailId: email,
                                dob: Timestamp.now(),
                              ),
                            ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JudgeProfileScreen(
                                gender: gender,
                                fullName: fName,
                                emailID: email,
                                mobileNo: mono,
                                address: address,
                                uId: uId,
                                jId: userDocId,
                              ),
                            ));
              },
            ),
            createDrawerBodyItem(
              icon: Icons.event_note,
              text: uId == 1
                  ? 'Your Events'
                  : uId == 2
                      ? "Assign Events"
                      : "Create Event",
              onTap: () {
                uId == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEventsScreen(
                            uId: uId,
                          ),
                        ))
                    : uId == 2
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventsScreen(
                                uId: uId,
                                mainTitle: "Assign Events",
                                userDocId: userDocId,
                              ),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventsScreen(
                                mainTitle: "Your Events",
                                uId: uId,
                                userDocId: userDocId,
                              ),
                            ));
              },
            ),
            if (uId == 0)
              createDrawerBodyItem(
                icon: Icons.contact_page,
                text: 'Manage Judge',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JudgeListScreen(
                        uId: uId,
                      ),
                    ),
                  );
                },
              ),
            createDrawerBodyItem(
              icon: Icons.collections,
              text: 'Gallery',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryScreen(uId),
                  ),
                );
              },
            ),
            if (uId != 0)
              createDrawerBodyItem(
                icon: Icons.contact_page,
                text: 'About Institute',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => JudgeListScreen(uId: uId,),
                  //   ),
                  // );
                },
              ),
            createDrawerBodyItem(
              icon: Icons.feedback,
              text: uId == 0 ? 'View Feedback' : 'Feedback',
              onTap: () {
                uId == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackListScreen(),
                        ),
                      )
                    : Navigator.pop(context);
                uId != 0
                    ? showDialog(
                        context: context,
                        builder: (context) {
                          return QuickFeedback(
                            title: 'Feedback',
                            defaultRating: 4,
                            showTextBox: true,
                            textBoxHint: 'Share your Thoughts',
                            submitText: 'SUBMIT',
                            onSubmitCallback: (feedback) {
                              print('${feedback['rating']}');
                              objFeedbackDetails
                                  .add({
                                    'email': email,
                                    'description': feedback['feedback'] ?? "",
                                    'star': feedback['rating'],
                                    'date': Timestamp.now(),
                                  })
                                  .then((value) => Navigator.pop(context))
                                  .catchError((error) =>
                                      print("Failed to add user: $error"));
                              Navigator.of(context).pop();
                            },
                            askLaterText: 'ASK LATER',
                            onAskLaterCallback: () {
                              print('Do something on ask later click');
                            },
                          );
                        },
                      )
                    : null;
              },
            ),
            createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                logoutPreferences();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => LoginAsScreen()),
                    ModalRoute.withName('/'));
              },
            ),
            ListTile(
              enabled: false,
              title: Text('App version 1.0.0',
                  style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerHeader(BuildContext context) {
    return Container(
      height: 268,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: Theme.of(context).backgroundColor,
                backgroundImage: AssetImage("images/login.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                uId == 0 ? "Admin" : "$fName",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "$email",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
