import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfileScreen extends StatefulWidget {
  final int pId;
  final String emailId;
  final String enrollNo;
  final String fullName;
  final String gender;
  final String mono;
  final String clgName;
  final String sClass;

  StudentProfileScreen({required this.pId, required this.emailId, required this.enrollNo, required this.fullName, required this.gender, required this.mono, required this.clgName, required this.sClass});
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

  @override void initState() {
    super.initState();
    // _getPrefData();
  }
  @override
  Widget build(BuildContext context) {
    List<String> items1 = <String>[
      widget.enrollNo,
      widget.sClass,
      widget.gender,
      "08-05-2000",
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
          widget.pId == 0 ? "Profile" :"Participate Details",
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
                      onPressed: () {},
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
