import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/create_event_screen.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:college_events/screen/profile_screen/student_profile_screen.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentListScreen extends StatefulWidget {
  final String title;

  StudentListScreen({required this.title});

  @override
  State<StatefulWidget> createState() {
    return _StudentListScreenState();
  }
}

class _StudentListScreenState extends State<StudentListScreen> {
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.title,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: objStudentDetails
            .where("class", isEqualTo: widget.title)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return SingleChildScrollView(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return ListTile(
                    leading: Icon(
                      Icons.person,
                      size: 34,
                    ),
                    title: Text(
                      documentSnapshot!["fullname"],
                      style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                    ),
                    subtitle: Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Text(
                        documentSnapshot.id,
                        style: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                        maxLines: 1,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DialogBox(
                              title: 'Are you sure??',
                              subtitle: "If you delete this Student, He can not login into our system.",
                              showTextBox: false,
                              showButton: true,
                              showOk: true,
                              askLaterText: 'Cancel',
                              submitText: 'Ok',
                              onSubmitCallback: (onSubmit) {},
                              onAskLaterCallback: (onSubmit) {},
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete),
                      iconSize: 24.0,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentProfileScreen(
                            pId: 0,
                            gender: documentSnapshot["gender"],
                            enrollNo: documentSnapshot.id,
                            sClass: documentSnapshot["class"],
                            clgName: documentSnapshot["collegename"],
                            mono: documentSnapshot["mobileno"],
                            fullName: documentSnapshot["fullname"],
                            emailId: documentSnapshot["emailid"],
                            dob: documentSnapshot["dateofbirth"],
                          ),
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              ),
            );
          }
          return Container(height: 100, child: Center(child: Text("NO DATA")));
        },
      ),
    );
  }
}
