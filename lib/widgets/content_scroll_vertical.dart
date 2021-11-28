import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:college_events/screen/events_screen/events_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ContentScrollVertical extends StatelessWidget {
  final String mainTitle;
  final double imageHeight;
  final double imageWidth;
  int uId;

  ContentScrollVertical({
    required this.uId,
    required this.mainTitle,
    required this.imageHeight,
    required this.imageWidth,
  });

  final objEventDetails =
      FirebaseFirestore.instance.collection("event_details");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                mainTitle,
                style: GoogleFonts.openSans(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventsScreen(
                      mainTitle: this.mainTitle,
                      uId: uId,
                    ),
                  ),
                ),
                child: Text(
                  "See All",
                  style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
                // Row(
                //   children: [
                //     Text("See All",style: GoogleFonts.openSans(fontWeight: FontWeight.bold,fontSize: 15),),
                //     Icon(
                //       Icons.arrow_forward,
                //       color: Colors.black,
                //       size: 22.0,
                //     ),
                //   ],
                // ),
                // child: Text("See All"),
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: mainTitle == "Past Events"
              ? objEventDetails
                  .where("enddate", isLessThan: new DateTime.now())
                  .orderBy("enddate", descending: true)
                  .snapshots()
              : objEventDetails
                  .where("startdate", isGreaterThan: new DateTime.now())
                  .orderBy("startdate", descending: false)
                  .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
              return Container(
                height: imageHeight,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    QueryDocumentSnapshot<Object?>? documentSnapshot =
                        snapshot.data?.docs[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 20.0,
                      ),
                      width: imageWidth,
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
                                  uId: uId,
                                  imgUrl: documentSnapshot!["imgurl"],
                                  title: documentSnapshot["eventtitle"],
                                  startDate: documentSnapshot["startdate"],
                                  endDate: documentSnapshot["enddate"],
                                  lastDate: documentSnapshot["lastdate"],
                                  time: documentSnapshot["time"],
                                  place: documentSnapshot["place"],
                                  whomFor: documentSnapshot["whomfor"],
                                  mainTitle: mainTitle,
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
                                height: (MediaQuery.of(context).size.height),
                                width: (MediaQuery.of(context).size.width),
                              ),
                              Positioned(
                                child: Container(
                                  child: Text(
                                    documentSnapshot["eventtitle"],
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
                ),
              );
            }
            return Container(
                height: 100, child: Center(child: Text("NO DATA")));
          },
        ),
      ],
    );
  }
}
