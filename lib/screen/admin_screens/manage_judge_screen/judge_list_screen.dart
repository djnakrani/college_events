import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/manage_judge_screen/assign_judge_screen.dart';
import 'package:college_events/screen/admin_screens/manage_judge_screen/create_judge_screen.dart';
import 'package:college_events/screen/profile_screen/judge_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JudgeListScreen extends StatefulWidget {
  final int uId;

  JudgeListScreen({required this.uId});

  @override
  State<StatefulWidget> createState() {
    return _JudgeListScreenState();
  }
}

class _JudgeListScreenState extends State<JudgeListScreen> {
  CollectionReference objJudgeDetails =
      FirebaseFirestore.instance.collection('judge_details');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Manage Judge",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: objJudgeDetails.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssignJudgeScreen()));
                    },
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 10),

                      // height: 60,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(vertical: 8),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 2),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: ListTile(
                          title: Text(
                            "Assign Judge",
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            maxLines: 1,
                          ),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.assignment_ind_rounded),
                            iconSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        "All Judges",
                        style: GoogleFonts.openSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  ListView.builder(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data?.docs.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JudgeProfileScreen(
                                        uId: widget.uId,
                                        gender: documentSnapshot!["gender"],
                                        emailID: documentSnapshot["emailid"],
                                        fullName: documentSnapshot["fullname"],
                                        address: documentSnapshot["address"],
                                        mobileNo: documentSnapshot["mobileno"],
                                      )));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 6.0,
                          ),
                          // height: 60,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: ListTile(
                              title: Text(
                                (documentSnapshot!["fullname"]),
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.arrow_forward),
                                iconSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return Container(height: 100, child: Center(child: Text("NO DATA")));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateJudgeScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
