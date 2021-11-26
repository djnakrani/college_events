import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/participate_screen/participate_name_screen.dart';
import 'package:college_events/screen/team_screen/team_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class DetailEventScreen extends StatefulWidget {
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
      {required this.imgUrl,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.lastDate,
      required this.time,
      required this.place,
      required this.description,
      required this.whomFor,
      required this.mainTitle,
      required this.maxparticipate});

  @override
  State<StatefulWidget> createState() {
    return _DetailEventScreenState();
  }
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  var dateFormatter = new DateFormat('dd-MM-yyyy');
  var timeFormatter = new DateFormat('kk:mm');

  @override
  Widget build(BuildContext context) {
    DateTime sDate = widget.startDate.toDate();
    DateTime eDate = widget.endDate.toDate();
    DateTime lDate = widget.lastDate.toDate();
    DateTime time = widget.time.toDate();
    String formattedDate = timeFormatter.format(time);
    String startDate = dateFormatter.format(sDate);
    String endDate = dateFormatter.format(eDate);
    String lastDate = dateFormatter.format(lDate);

    return Scaffold(
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
                    padding: EdgeInsets.only(top: 10, left: 10.0),
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
                  widget.mainTitle == "Admin"
                      ? IconButton(
                          padding: EdgeInsets.only(top: 10, right: 10.0),
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(Icons.delete),
                          iconSize: 30.0,
                          color: Colors.white,
                        )
                      : SizedBox(),
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
                  padding: EdgeInsets.all(15.0),
                  child: ReadMoreText(
                    widget.description,
                    style: GoogleFonts.openSans(color: Colors.black),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
            child: RaisedButton(
              child: Text(
                widget.mainTitle == "Today Events"
                    ? "View"
                    : widget.mainTitle == "Past Events"
                        ? "View Result"
                        : widget.mainTitle == "Upcoming Events"
                            ? "Apply"
                            : "Else",
                style: GoogleFonts.openSans(fontSize: 20),
              ),
              onPressed: () {
                if (widget.mainTitle == "Today Events") {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TeamNameScreen()));
                } else if (widget.mainTitle == "Upcoming Events") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParticipateNameScreen()));
                } else if (widget.mainTitle == "Past Events") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParticipateNameScreen()));
                } else {}
              },
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              padding: EdgeInsets.all(8.0),
              splashColor: Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  raisedButtonText() {
    if (widget.mainTitle == "Today Events") {
      return Text(
        "View",
        style: GoogleFonts.openSans(fontSize: 20),
      );
    } else if (widget.mainTitle == "Past Events") {
      return Text(
        "View Result",
        style: GoogleFonts.openSans(fontSize: 20),
      );
    } else if (widget.mainTitle == "Upcoming Events") {
      return Text(
        "Apply",
        style: GoogleFonts.openSans(fontSize: 20),
      );
    } else {}
  }
}
