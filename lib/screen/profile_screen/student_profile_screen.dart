import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/add_student_screen/add_student_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class StudentProfileScreen extends StatefulWidget {
  final int pId;
  final String emailId;
  final String enrollNo;
  final String fullName;
  final String gender;
  final Timestamp dob;
  final String mono;
  final String clgName;
  final String sClass;

  StudentProfileScreen(
      {required this.pId,
      required this.emailId,
      required this.enrollNo,
      required this.fullName,
      required this.gender,
      required this.mono,
      required this.clgName,
      required this.sClass, required this.dob});

  @override
  State<StatefulWidget> createState() {
    return _StudentProfileScreenState();
  }
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  List<String> items = <String>[
    "Enrollment Number",
    "Class",
    "Gender",
    "Date of Birth",
    "Email Id",
    "Mobile Number",
    "College Name",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var dtFormat = new DateFormat('dd-MM-yyyy');
    var dtFormat1 = new DateFormat('EEE, MMM d, yyyy');
    String dob = dtFormat.format(widget.dob.toDate());
    String dob1 = dtFormat1.format(widget.dob.toDate());
    List<String> items1 = <String>[
      widget.enrollNo,
      widget.sClass,
      widget.gender,
      dob,
      widget.emailId,
      widget.mono,
      widget.clgName,
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.pId == 0 ? "Profile" : "Participate Details",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              height: 180,
              child: Image(
                image: AssetImage('images/login.png'),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                widget.fullName,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 26),
                textAlign: TextAlign.center,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${items[index]} : ${items1[index]}',
                    style:
                        GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                  ),
                  dense: true,
                );
              },
            ),
            widget.pId == 0
                ? Container(
                    child: MaterialButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          "Edit",
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
                            builder: (context) => AddStudentScreen(
                              mTitle: 'Edit',
                              clg: widget.clgName,
                              emailId: widget.emailId,
                              eNumber: widget.enrollNo,
                              gender: widget.gender,
                              fName: widget.fullName,
                              mNumber: widget.mono,
                              dob: dob1,
                              sClass: widget.sClass,
                            ),
                          ),
                        );
                      },
                    ),
                    width: MediaQuery.of(context).size.width * 0.78,
                    margin: EdgeInsets.all(15),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
