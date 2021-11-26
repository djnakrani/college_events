import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/add_student_screen/add_student_screen.dart';
import 'package:college_events/screen/admin_screens/add_student_screen/student_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClassListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClassListScreenState();
  }
}

class _ClassListScreenState extends State<ClassListScreen> {
  final List<String> data = ["FYMCA","SYMCA","TYMCA"];
  final objEventDetails =
      FirebaseFirestore.instance.collection("event_details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Students",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        scrollDirection: Axis.vertical,
        itemCount: data.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StudentListScreen(title: data[index],),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 6.0,
              ),
              height: 60,
              width: MediaQuery.of(context).size.width,
              // padding: EdgeInsets.only(top: 8, left: 15, bottom: 8),
              // alignment: Alignment.centerLeft,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Text(
                        data[index],
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_forward),
                      iconSize: 24.0,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddStudentScreen()));
        },
        child: const Icon(Icons.add),
        tooltip: "Add Student",
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
