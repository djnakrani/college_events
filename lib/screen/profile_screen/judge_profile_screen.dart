import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class JudgeProfileScreen extends StatefulWidget {
  final int uId;
  final String fullName;
  final String mobileNo;
  final String emailID;
  final String address;
  final String gender;

  JudgeProfileScreen(
      {required this.uId,
      required this.fullName,
      required this.mobileNo,
      required this.emailID,
      required this.address,
      required this.gender});

  @override
  State<StatefulWidget> createState() {
    return _JudgeProfileScreenState();
  }
}

class _JudgeProfileScreenState extends State<JudgeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[
      "Mobile Number : ${widget.mobileNo}",
      "Gender : ${widget.gender}",
      "Email Id : ${widget.emailID}",
      "Address : ${widget.address}",
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.uId == 2 ? "Profile" :"Judge Details",
          style: GoogleFonts.openSans(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
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
                    fontWeight: FontWeight.w600, fontSize: 28),
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
                    '${items[index]} ',
                    style:
                        GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                  ),
                  dense: true,
                );
              },
            ),
            widget.uId == 0
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
