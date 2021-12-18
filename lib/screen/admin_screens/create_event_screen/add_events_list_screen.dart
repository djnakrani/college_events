import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/create_event_screen.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddEventsScreen extends StatefulWidget {
  final int uId;

  AddEventsScreen({required this.uId});

  @override
  State<StatefulWidget> createState() {
    return _AddEventsScreenState();
  }
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  final objEventDetails =
      FirebaseFirestore.instance.collection("event_details");
  var dateFormatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Events",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            objEventDetails.orderBy("startdate", descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  DateTime sDate = documentSnapshot!["startdate"].toDate();
                  DateTime eDate = documentSnapshot["enddate"].toDate();
                  String startDate = dateFormatter.format(sDate);
                  String endDate = dateFormatter.format(eDate);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 4.0,
                            vertical: 6.0,
                          ),
                          // height: 60,
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
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.event,
                                  size: 24,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            documentSnapshot["whomfor"] ==
                                                    "Male"
                                                ? '${documentSnapshot["eventtitle"]} for Male'
                                                : documentSnapshot["whomfor"] ==
                                                        "Female"
                                                    ? '${documentSnapshot["eventtitle"]} for Female'
                                                    : (documentSnapshot[
                                                        "eventtitle"]),
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          margin: EdgeInsets.only(top: 3),
                                          child: Text(
                                            startDate == endDate
                                                ? "$startDate"
                                                : "$startDate to $endDate",
                                            style: GoogleFonts.openSans(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            maxLines: 1,
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return DialogBox(
                                          title: 'Are you sure??',
                                          subtitle: "If you delete this event it's participate also be removed",
                                          showTextBox: false,
                                          showButton: true,
                                          showOk: true,
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
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailEventScreen(
                                uId: widget.uId,
                                eventId: documentSnapshot.id,
                                imgUrl: documentSnapshot["imgurl"],
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
                                judgeId: documentSnapshot["judgeid"],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            );
          }
          return Container(height: 100, child: Center(child: Text("NO DATA")));
        },
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
