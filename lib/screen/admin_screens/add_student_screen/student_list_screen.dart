import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/create_event_screen.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.title,
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: objStudentDetails
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return ListView.separated(
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                QueryDocumentSnapshot<Object?>? documentSnapshot =
                    snapshot.data?.docs[index];
                return ListTile(
                  leading: Icon(Icons.person,size: 34,),
                  title: Text(
                    (documentSnapshot != null)
                        ? (documentSnapshot["fullname"])
                        : "",
                    style: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    maxLines: 1,
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward),
                    iconSize: 24.0,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
          return Container(
              height: 100, child: Center(child: Text("NO DATA")));
        },
      ),
    );
  }
}
