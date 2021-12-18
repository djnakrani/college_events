import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/profile_screen/student_profile_screen.dart';
import 'package:college_events/screen/team_screen/team_name_screen.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ParticipateNameScreen extends StatefulWidget {
  final String eventId;
  final String judgeId;
  final String jId;
  final String eventName;
  final int uId;
  final DateTime sDate;
  final DateTime eDate;
  final num maxParticipate;

  ParticipateNameScreen(
      {required this.eventId,
      required this.maxParticipate,
      required this.sDate,
      required this.eDate,
      required this.uId,
      required this.eventName,
      required this.judgeId,
      required this.jId});

  late DateTime dateNow = DateTime.now();
  late DateTime dateAddOneEnd = eDate.add(Duration(days: 2));

  @override
  State<StatefulWidget> createState() {
    return _ParticipateNameScreenState();
  }
}

class _ParticipateNameScreenState extends State<ParticipateNameScreen> {
  final objStudentDetails =
      FirebaseFirestore.instance.collection("student_details");
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");
  final objTeamDetails = FirebaseFirestore.instance.collection("team_details");
  String jIds = "";
  List partiForTeam = [];
  List<dynamic> tmpList = [];

  @override
  void initState() {
    super.initState();
    print(
        '${widget.dateNow} and ${widget.dateAddOneEnd} and ${widget.dateNow}');
  }

  @override
  Widget build(BuildContext context) {
    getPrefData();
    print("JId : ${widget.jId}");
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
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            onPressed: () {
              getSelectedIdsList();
              print("Id = $partiForTeam");
              showDialog(
                context: context,
                builder: (context) {
                  return DialogBox(
                    title: "Create Team",
                    subtitle: "",
                    showTextBox: true,
                    showButton: true,
                    askLaterText: 'Cancel',
                    showOk: true,
                    submitText: 'Submit',
                    hintText: "Enter Name of Team",
                    onSubmitCallback: (onSubmit) {
                      String tName = onSubmit["text"];

                      objTeamDetails.add({
                        "teamname": tName,
                        "eventid": widget.eventId,
                        "judgeid": widget.judgeId,
                        "studentids": FieldValue.arrayUnion(partiForTeam),
                        "status": "Pending",
                      }).then((value) {
                        for (var i in tmpList) {
                          print("i is $i");
                          objParticipateDetails.doc('$i').set({
                            'isselect': false,
                            "isscore": true,
                          }, SetOptions(merge: true));
                        }
                        Navigator.pop(context);
                      }).catchError((error) =>
                          print("Failed to add Notification: $error"));
                    },
                    onAskLaterCallback: (feedback) {},
                  );
                },
              );
            },
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            (widget.maxParticipate == 1 &&
                    widget.dateAddOneEnd.isBefore(widget.dateNow))
                ? SizedBox()
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        "Participates Details",
                        style: GoogleFonts.openSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
            (widget.maxParticipate == 1 &&
                    widget.dateAddOneEnd.isBefore(widget.dateNow))
                ? SizedBox()
                : streamBuilder(0),
            widget.maxParticipate == 1 &&
                    (widget.sDate.isAtSameMomentAs(widget.dateNow) ||
                        widget.sDate.isBefore(widget.dateNow))
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      child: Text(
                        "Participates Score Details",
                        style: GoogleFonts.openSans(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  )
                : SizedBox(),
            widget.maxParticipate == 1 &&
                    (widget.sDate.isAtSameMomentAs(widget.dateNow) ||
                        widget.sDate.isBefore(widget.dateNow))
                ? streamBuilder(1)
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamNameScreen(
                eventId: widget.eventId,
                eventName: widget.eventName,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget streamBuilder(isScore) {
    return StreamBuilder<QuerySnapshot>(
      stream: isScore == 0
          ? objParticipateDetails
              .where("eventid", isEqualTo: widget.eventId)
              .where("isscore", isEqualTo: false)
              .snapshots()
          : objParticipateDetails
              .where("eventid", isEqualTo: widget.eventId)
              .where("isscore", isEqualTo: true)
              .snapshots(),
      builder: (context, snapshot) {
        // print("Snapshot : $snapshot");
        if (snapshot.hasError) {
          return Text('Something went wrong');
        } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
          // print("Length : ${snapshot.data?.docs.length}");
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            scrollDirection: Axis.vertical,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
              return FutureBuilder(
                future: objStudentDetails
                    .doc("${documentSnapshot!['studentid']}")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData) {
                    final docEvent = snapshot.data as DocumentSnapshot;
                    return ListTile(
                      title: Text(
                        docEvent["fullname"],
                        style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      dense: true,
                      trailing: isScore == 1
                          ? Text(
                              documentSnapshot["score"],
                              style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            )
                          : widget.maxParticipate != 1
                              ? Checkbox(
                                  value: documentSnapshot['isselect'],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      objParticipateDetails
                                          .doc('${documentSnapshot.id}')
                                          .set({'isselect': value},
                                              SetOptions(merge: true));
                                    });
                                  })
                              : Icon(Icons.keyboard_arrow_right),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          "${docEvent.id} - ${docEvent["class"]}",
                          style: GoogleFonts.openSans(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                      onTap: () {
                        if (widget.maxParticipate == 1 &&
                            isScore == 0 &&
                            widget.uId == 2 &&
                            widget.sDate.isBefore(widget.dateNow) &&
                            widget.dateAddOneEnd.isAfter(widget.dateNow)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogBox(
                                title: "Give Score",
                                subtitle: "Name : ${docEvent['fullname']}",
                                showTextBox: true,
                                showButton: true,
                                askLaterText: 'Cancel',
                                showOk: true,
                                submitText: 'Submit',
                                hintText: "Enter Score",
                                onSubmitCallback: (onSubmit) {
                                  String pScore = onSubmit["text"];
                                  print(pScore);
                                  Navigator.of(context).pop();
                                  objParticipateDetails
                                      .doc('${documentSnapshot.id}')
                                      .set(
                                          {'score': '$pScore', 'isscore': true},
                                          SetOptions(merge: true));
                                },
                                onAskLaterCallback: (feedback) {
                                  // Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        } else if (widget.maxParticipate == 1 &&
                            isScore == 1 &&
                            widget.uId == 2 &&
                            widget.sDate.isBefore(widget.dateNow) &&
                            widget.dateAddOneEnd.isAfter(widget.dateNow)) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogBox(
                                title: "Change Score",
                                subtitle: "Name : ${docEvent['fullname']}",
                                showTextBox: true,
                                showOk: true,
                                showButton: true,
                                askLaterText: 'Cancel',
                                submitText: 'Update',
                                hintText: "Enter Score",
                                textScore: documentSnapshot["score"],
                                onSubmitCallback: (onSubmit) {
                                  String pScore = onSubmit["text"];
                                  print(pScore);
                                  Navigator.of(context).pop();
                                  objParticipateDetails
                                      .doc('${documentSnapshot.id}')
                                      .set(
                                          {'score': '$pScore', 'isscore': true},
                                          SetOptions(merge: true));
                                },
                                onAskLaterCallback: (feedback) {
                                  // Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        } else {
                          print(documentSnapshot.id);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfileScreen(
                                pId: 1,
                                gender: docEvent["gender"],
                                enrollNo: docEvent.id,
                                sClass: docEvent["class"],
                                clgName: docEvent["collegename"],
                                mono: docEvent["mobileno"],
                                fullName: docEvent["fullname"],
                                emailId: docEvent["emailid"],
                                dob: docEvent["dateofbirth"],
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                  return SizedBox();
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
          ),
        );
      },
    );
  }

  Future<List<String>> getSelectedIds() async {
    final id = objParticipateDetails
        .where("eventid", isEqualTo: widget.eventId)
        .where("isselect", isEqualTo: true)
        .get()
        .then((value) => value.docs.map((e) => e.id).toList());
    return await id;
  }

  Future getSelectedIdsList() async {
    final Future<List<dynamic>> futureList = getSelectedIds();
    var list = await futureList;
    tmpList = list;
    await get();
    // print("Id is $tmpList");
  }

  Future get() async {
    partiForTeam = [];
    for (var i in tmpList) {
      objParticipateDetails.doc(i).get().then((value) {
        if (value.exists) {
          partiForTeam.add(value["studentid"]);
        }
      });
    }
  }

  getPrefData() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    jIds = (await prefs.getString("judgeId"))!;
  }
}
