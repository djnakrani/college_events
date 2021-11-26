import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  int pId;
  ProfileScreen({required this.pId});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> items = <String>[
    "Enrollment Number",
    "Roll Number",
    "Gender",
    "Date of Birth",
    "Email Id",
    "Mobile Number",
    "Blood Group",
    "Address",
    "College Name",
  ];
  List<String> items1 = <String>[
    "205690694039",
    "92",
    "Male",
    "08-05-2000",
    "kashyap@gmail.com",
    "9889898989",
    "A+",
    "Surat",
    "GMCA",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Participate Details",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
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
                "Kashyap Ghanshyambhai Kalathiya",
                style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 26),
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
                    style: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                  ),
                  dense: true,
                );
              },
            ),
            widget.pId == 0 ? Container(
              child: RaisedButton(
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
            ) : SizedBox(),
          ],
        ),
      ),
    );
  }
}

