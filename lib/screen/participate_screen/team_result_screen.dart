import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamResultScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final int uId;
  final DateTime sDate;
  final DateTime eDate;
  final num maxParticipate;

  TeamResultScreen(
      {required this.eventId,
      required this.maxParticipate,
      required this.sDate,
      required this.eDate,
      required this.uId,
      required this.eventName});

  late DateTime dateNow = DateTime.now();
  late DateTime dateAddOneEnd = eDate.add(Duration(days: 2));

  @override
  State<StatefulWidget> createState() {
    return _TeamResultScreenState();
  }
}

class _TeamResultScreenState extends State<TeamResultScreen> {
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");
  final objTeamDetails = FirebaseFirestore.instance.collection("team_details");

  @override
  void initState() {
    super.initState();
    print(
        '${widget.dateNow} and ${widget.dateAddOneEnd} and ${widget.dateNow}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.eventName,
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
            widget.maxParticipate != 1 &&
                    (widget.sDate.isAtSameMomentAs(widget.dateNow) ||
                        widget.sDate.isBefore(widget.dateNow))
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        "Team Result Details",
                        style: GoogleFonts.openSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.maxParticipate != 1 &&
                    (widget.sDate.isAtSameMomentAs(widget.dateNow) ||
                        widget.sDate.isBefore(widget.dateNow))
                ? streamBuilder()
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget streamBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: objTeamDetails
          .where("eventid", isEqualTo: widget.eventId)
          .where("status", whereIn: ["Winner","1st RunnerUp","2nd RunnerUp"])
          .snapshots(),
      builder: (context, snapshot) {
        print("Snapshot : $snapshot");
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
          print("Length : ${snapshot.data?.docs.length}");
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
              return ListTile(
                title: Text(
                  documentSnapshot!["teamname"],
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                dense: true,
                trailing: Icon(Icons.keyboard_arrow_right),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    documentSnapshot["status"],
                    style:
                        GoogleFonts.openSans(color: Colors.black, fontSize: 14),
                  ),
                ),
                onTap: () {

                },
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
        }
        return Container(
            height: 60,
            child: Center(
              child: Text(
                "NO DATA",
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ));
      },
    );
  }
}
