import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/create_event_screen.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEventsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddEventsScreenState();
  }
}

class _AddEventsScreenState extends State<AddEventsScreen> {
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
          "Events",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 26),
        ),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("event_details")
              .orderBy("startdate")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 6.0,
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 8, left: 15, bottom: 8),
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailEventScreen(
                                imgUrl: documentSnapshot!["imgurl"],
                                title: documentSnapshot["eventtitle"],
                                startDate: documentSnapshot["startdate"],
                                endDate: documentSnapshot["enddate"],
                                lastDate: documentSnapshot["lastdate"],
                                time: documentSnapshot["time"],
                                place: documentSnapshot["place"],
                                whomFor: documentSnapshot["whomfor"],
                                mainTitle: "Admin",
                                description: documentSnapshot["description"],
                                maxparticipate:
                                    documentSnapshot["maxparticipate"],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.event,
                              size: 34,
                            ),
                            Expanded(
                              child: Text(
                                (documentSnapshot != null)
                                    ? (documentSnapshot["eventtitle"])
                                    : "",
                                style: GoogleFonts.openSans(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1,
                              ),
                            ),
                            Icon(
                              Icons.event,
                              size: 34,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateEventScreen()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
