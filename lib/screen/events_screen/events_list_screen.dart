import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsScreen extends StatefulWidget {
  final int uId;
  final String userDocId;
  final String mainTitle;

  EventsScreen(
      {required this.uId, required this.mainTitle, required this.userDocId});

  @override
  State<StatefulWidget> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen> {
  final objEventDetails =
      FirebaseFirestore.instance.collection("event_details");
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");

  @override
  Widget build(BuildContext context) {
    print("Document id is ${widget.userDocId}");
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.mainTitle,
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: widget.mainTitle == "Your Events"
            ? StreamBuilder<QuerySnapshot>(
                stream: objParticipateDetails
                    .where("studentid", isEqualTo: widget.userDocId)
                    .snapshots(),
                builder: (context, snapshot) {
                  print("Snapshote : $snapshot");
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData &&
                      snapshot.data?.docs.length != 0) {
                    // print("Snapshote : ${snapshot.data?.docs.length}");
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot<Object?>? documentSnapshot1 =
                            snapshot.data?.docs[index];
                        return FutureBuilder(
                          future: objEventDetails
                              .doc("${documentSnapshot1!["eventid"]}")
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            } else if (snapshot.hasData) {
                              print("DAta");
                              final docEvent = snapshot.data as DocumentSnapshot;
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 15.0,
                                ),
                                height: 240,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(0.0, 4.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DetailEventScreen(
                                            uId: widget.uId,
                                            eventId: docEvent.id,
                                            imgUrl: docEvent["imgurl"],
                                            title: docEvent["eventtitle"],
                                            startDate: docEvent["startdate"],
                                            endDate: docEvent["enddate"],
                                            lastDate: docEvent["lastdate"],
                                            time: docEvent["time"],
                                            place: docEvent["place"],
                                            whomFor: docEvent["whomfor"],
                                            mainTitle: widget.mainTitle,
                                            description:
                                                docEvent["description"],
                                            maxparticipate:
                                                docEvent["maxparticipate"],
                                                judgeId: docEvent["judgeid"],
                                          ),
                                        ),
                                      );
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage(docEvent["imgurl"]),
                                          fit: BoxFit.cover,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 240,
                                        ),
                                        Positioned(
                                          child: Container(
                                            child: Text(
                                              docEvent["whomfor"] == "Male"
                                                  ? '${docEvent["eventtitle"]} - Male'
                                                  : docEvent["whomfor"] ==
                                                          "Female"
                                                      ? '${docEvent["eventtitle"]} - Female'
                                                      : docEvent["eventtitle"],
                                              style: GoogleFonts.openSans(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 1,
                                            ),
                                            color: Colors.white54,
                                            padding: EdgeInsets.only(
                                                top: 8, left: 15, bottom: 8),
                                            width: (MediaQuery.of(context)
                                                .size
                                                .width),
                                            alignment: Alignment.bottomLeft,
                                          ),
                                          bottom: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return SizedBox();
                          },
                        );
                      },
                    );
                  }
                  return Container(
                      height: 100, child: Center(child: Text("NO DATA")));
                },
              )
            : StreamBuilder<QuerySnapshot>(
                stream: widget.mainTitle == "Past Events"
                    ? objEventDetails
                        .where("enddate", isLessThan: new DateTime.now())
                        .orderBy("enddate", descending: true)
                        .snapshots()
                    : widget.mainTitle == "Upcoming Events"
                        ? objEventDetails
                            .where("startdate",
                                isGreaterThan: new DateTime.now())
                            .orderBy("startdate", descending: false)
                            .snapshots()
                        : widget.mainTitle == "Assign Events"
                            ? objEventDetails
                                .where("judgeid", isEqualTo: widget.userDocId)
                                .snapshots()
                            : objEventDetails.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong${snapshot.error}');
                  } else if (snapshot.hasData &&
                      snapshot.data?.docs.length != 0) {
                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        QueryDocumentSnapshot<Object?>? documentSnapshot =
                            snapshot.data?.docs[index];
                        return Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 15.0,
                          ),
                          height: 240,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(0.0, 4.0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailEventScreen(
                                      uId: widget.uId,
                                      eventId: documentSnapshot!.id,
                                      imgUrl: documentSnapshot["imgurl"],
                                      title: documentSnapshot["eventtitle"],
                                      startDate: documentSnapshot["startdate"],
                                      endDate: documentSnapshot["enddate"],
                                      lastDate: documentSnapshot["lastdate"],
                                      time: documentSnapshot["time"],
                                      place: documentSnapshot["place"],
                                      whomFor: documentSnapshot["whomfor"],
                                      mainTitle: widget.mainTitle,
                                      description:
                                          documentSnapshot["description"],
                                      maxparticipate:
                                          documentSnapshot["maxparticipate"],
                                      judgeId: documentSnapshot["judgeid"],
                                    ),
                                  ),
                                );
                              },
                              child: Stack(
                                children: <Widget>[
                                  Image(
                                    image:
                                        AssetImage(documentSnapshot!["imgurl"]),
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                    height: 240,
                                  ),
                                  Positioned(
                                    child: Container(
                                      child: Text(
                                        documentSnapshot["whomfor"] == "Male"
                                            ? '${documentSnapshot["eventtitle"]} - Male'
                                            : documentSnapshot["whomfor"] ==
                                                    "Female"
                                                ? '${documentSnapshot["eventtitle"]} - Female'
                                                : (documentSnapshot[
                                                    "eventtitle"]),
                                        style: GoogleFonts.openSans(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                      ),
                                      color: Colors.white54,
                                      padding: EdgeInsets.only(
                                          top: 8, left: 15, bottom: 8),
                                      width:
                                          (MediaQuery.of(context).size.width),
                                      alignment: Alignment.bottomLeft,
                                    ),
                                    bottom: 0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                      height: 100, child: Center(child: Text("NO DATA")));
                },
              ),
      ),
    );
  }
  //
  // Future<void> getEventId(futureString) async {
  //   final eId = await futureString;
  //   setState(() => particularId = eId);
  // }
}
