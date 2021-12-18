import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/team_screen/team_participate_screen.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamNameScreen extends StatefulWidget {
  final String eventId;
  final String eventName;

  TeamNameScreen({required this.eventId, required this.eventName});

  @override
  State<StatefulWidget> createState() {
    return _TeamNameScreenState();
  }
}

class _TeamNameScreenState extends State<TeamNameScreen> {
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");
  final objTeamDetails = FirebaseFirestore.instance.collection("team_details");

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
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Text(
                  "Team Details",
                  style: GoogleFonts.openSans(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: objTeamDetails
                  .where("eventid", isEqualTo: widget.eventId)
                  .snapshots(),
              builder: (context, snapshot) {
                // print("Snapshot : $snapshot");
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                } else if (snapshot.hasData &&
                    snapshot.data?.docs.length != 0) {
                  print("Length : ${snapshot.data?.docs.length}");
                  return ListView.separated(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
                        trailing: GestureDetector(
                          child: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TeamParticipateScreen(
                                  teamId: documentSnapshot.id,
                                  teamName: documentSnapshot["teamname"],
                                ),
                              ),
                            );
                          },
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "${documentSnapshot["status"]}",
                            style: GoogleFonts.openSans(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                        onTap: () { showDialog(
                          context: context,
                          builder: (context) {
                            return DialogBox(
                              title: "Select Win or Loss",
                              subtitle: "Name : ${documentSnapshot['teamname']}",
                              showTextBox: false,
                              showButton: true,
                              askLaterText: 'Cancel',
                              showOk: true,
                              dropdown: true,
                              submitText: 'Submit',
                              hintText: "Enter Win or Loss",
                              onSubmitCallback: (onSubmit) {
                                String pScore = onSubmit["text"];
                                Navigator.of(context).pop();
                                print(pScore);
                                objTeamDetails
                                    .doc('${documentSnapshot.id}')
                                    .set(
                                    {'status': '$pScore'},
                                    SetOptions(merge: true));
                              },
                              onAskLaterCallback: (feedback) {

                              },
                            );
                          },
                        );},
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
