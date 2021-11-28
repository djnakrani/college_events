import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsScreen extends StatefulWidget {
  int uId;
  final String mainTitle;

  EventsScreen({required this.uId, required this.mainTitle});

  @override
  State<StatefulWidget> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen> {
  final objEventDetails =
      FirebaseFirestore.instance.collection("event_details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.mainTitle,
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.mainTitle == "Past Events"
              ? objEventDetails
                  .where("enddate", isLessThan: new DateTime.now())
                  .snapshots()
              : widget.mainTitle == "Upcoming Events"
                  ? FirebaseFirestore.instance
                      .collection("event_details")
                      .where("startdate", isGreaterThan: new DateTime.now())
                      .snapshots()
                  : FirebaseFirestore.instance
                      .collection("event_details")
                      .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
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
                                imgUrl: documentSnapshot!["imgurl"],
                                title: documentSnapshot["eventtitle"],
                                startDate: documentSnapshot["startdate"],
                                endDate: documentSnapshot["enddate"],
                                lastDate: documentSnapshot["lastdate"],
                                time: documentSnapshot["time"],
                                place: documentSnapshot["place"],
                                whomFor: documentSnapshot["whomfor"],
                                mainTitle: widget.mainTitle,
                                description: documentSnapshot["description"],
                                maxparticipate:
                                    documentSnapshot["maxparticipate"],
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Image(
                              image: AssetImage(documentSnapshot!["imgurl"]),
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: 240,
                            ),
                            Positioned(
                              child: Container(
                                child: Text(
                                  (documentSnapshot["eventtitle"]),
                                  style: GoogleFonts.openSans(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                ),
                                color: Colors.white54,
                                padding: EdgeInsets.only(
                                    top: 8, left: 15, bottom: 8),
                                width: (MediaQuery.of(context).size.width),
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
}
