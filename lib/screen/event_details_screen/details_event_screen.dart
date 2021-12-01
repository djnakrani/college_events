import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/participate_screen/participate_name_screen.dart';
import 'package:college_events/screen/team_screen/team_name_screen.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailEventScreen extends StatefulWidget {
  final int uId;
  final String eventId;
  final String imgUrl;
  final String title;
  final Timestamp startDate;
  final Timestamp endDate;
  final Timestamp lastDate;
  final Timestamp time;
  final String place;
  final String description;
  final String whomFor;
  final String mainTitle;
  final num maxparticipate;

  DetailEventScreen(
      {required this.uId,
      required this.imgUrl,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.lastDate,
      required this.time,
      required this.place,
      required this.description,
      required this.whomFor,
      required this.mainTitle,
      required this.maxparticipate,
      required this.eventId});

  @override
  State<StatefulWidget> createState() {
    return _DetailEventScreenState();
  }
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  var dateFormatter = new DateFormat('dd-MM-yyyy');
  var timeFormatter = new DateFormat('kk:mm');
  final objParticipateDetails =
      FirebaseFirestore.instance.collection("participate_details");

  late String enrollNo;

  @override
  Widget build(BuildContext context) {
    getPrefData();
    DateTime sDate = widget.startDate.toDate();
    DateTime eDate = widget.endDate.toDate();
    DateTime lDate = widget.lastDate.toDate();
    DateTime time = widget.time.toDate();
    String formattedDate = timeFormatter.format(time);
    String startDate = dateFormatter.format(sDate);
    String endDate = dateFormatter.format(eDate);
    String lastDate = dateFormatter.format(lDate);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                child: Image(
                  height: 400.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage(widget.imgUrl),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 3),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
              ),
              Container(
                transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                height: 400.0,
                color: Colors.black26,
                // child:
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(top: 10, left: 15.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  widget.uId == 0 && widget.mainTitle == "Upcoming Events"
                      ? IconButton(
                          padding: EdgeInsets.only(top: 10, right: 15.0),
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                          iconSize: 30.0,
                          color: Colors.white,
                        )
                      : SizedBox(
                          width: 30,
                        ),
                ],
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Event Date :",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  startDate == endDate
                      ? startDate
                      : '${startDate} to ${endDate}',
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "Last Applying Date :",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  lastDate,
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "Event Time :",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  formattedDate,
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "Event Place :",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  widget.place,
                  style:
                      GoogleFonts.openSans(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20, left: 10),
                child: Text(
                  "Event Description :",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                  child: ReadMoreText(
                    widget.description,
                    style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    trimLines: 2,
                    colorClickableText: Colors.black,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    lessStyle: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    moreStyle: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          (widget.mainTitle == "Today Events" && widget.uId == 1)
              ? SizedBox()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
                  child: MaterialButton(
                    child: Text(
                      materialButtonText(),
                      style: GoogleFonts.openSans(fontSize: 20),
                    ),
                    onPressed: () => clickMaterialButton(context),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    splashColor: Colors.grey,
                  ),
                ),
        ],
      ),
    );
  }

  materialButtonText() {
    if (widget.mainTitle == "Today Events" ||
        widget.mainTitle == "Upcoming Events" && widget.uId == 0) {
      return "View Participate";
    } else if (widget.mainTitle == "Upcoming Events" && widget.uId == 1) {
      return "Apply";
    } else if (widget.mainTitle == "Today Events" ||
        widget.mainTitle == "Upcoming Events" && widget.uId == 2) {
      return "View Participate";
    } else if (widget.mainTitle == "Past Events") {
      return "View Result";
    } else {
      return "";
    }
  }

  clickMaterialButton(BuildContext context) {
    if (widget.mainTitle == "Today Events" ||
        widget.mainTitle == "Upcoming Events" && widget.uId == 0) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ParticipateNameScreen()));
    } else if (widget.mainTitle == "Upcoming Events" && widget.uId == 1) {
      objParticipateDetails
          .where('studentid', isEqualTo: enrollNo)
          .where('eventid', isEqualTo: widget.eventId)
          .get()
          .then((value) {
        if (value.docs.first.exists) {
          dialog_box(context,"You Already Apply","You can check it in your events.");
        } else {
          print("value nathi");
        }
      }).catchError((e) {
        objParticipateDetails
            .add({
              'studentid': enrollNo,
              'eventid': widget.eventId,
              'date': Timestamp.now(),
            })
            .then((value) => dialog_box(context,"Successfully Applied","You can check it in your events"))
            .catchError((error) => print("Failed to add Notification: $error"));
      });
    } else if (widget.mainTitle == "Today Events" ||
        widget.mainTitle == "Upcoming Events" && widget.uId == 2) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ParticipateNameScreen()));
    } else if (widget.mainTitle == "Past Events") {
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => TeamNameScreen()));
    } else {
      return "";
    }
  }

  getPrefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    enrollNo = prefs.getString("stdId")!;
  }
}
