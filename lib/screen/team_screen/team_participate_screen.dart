import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamParticipateScreen extends StatefulWidget {
  final String teamId;
  final String teamName;

  TeamParticipateScreen({required this.teamName, required this.teamId});

  @override
  State<StatefulWidget> createState() {
    return _TeamParticipateScreenState();
  }
}

class _TeamParticipateScreenState extends State<TeamParticipateScreen> {
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");
  final objTeamDetails = FirebaseFirestore.instance.collection("team_details");
  List stdIds = [];
  List studName = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.teamName,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                    title: 'Are you sure??',
                    subtitle: "If you delete this team member are no longer in any team",
                    showTextBox: false,
                    showButton: true,
                    showOk: false,
                    showDelete: true,
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Team Members",
                  style: GoogleFonts.openSans(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            StreamBuilder<DocumentSnapshot>(
              stream: objTeamDetails.doc("${widget.teamId}").snapshots(),
              builder: (context, snapshot) {
                print("Snapshot : $snapshot");
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData) {

                  final docEvent = snapshot.data as DocumentSnapshot;
                  stdIds = docEvent['studentids'];
                  for (var i in stdIds) {
                    objStudentDetails.doc(i).get().then((value) {
                      if (value.exists) {
                        studName.add(value["fullname"]);
                      }
                    });
                  }
                  print("Id : ${snapshot.data!.get('studentids')}");
                  return ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: stdIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          '${stdIds[index]}',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        dense: true,
                        trailing: Icon(Icons.keyboard_arrow_right),
                        onTap: () {},
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
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
