import 'package:college_events/screen/participate_screen/participate_name_screen.dart';
import 'package:college_events/screen/team_screen/team_name_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class DetailEventScreen extends StatefulWidget {
  final String imgUrl;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime lastDate;
  final String time;
  final String place;
  final String description;
  final String mainTitle;

  DetailEventScreen(
      {required this.imgUrl,
      required this.title,
      required this.startDate,
      required this.endDate,
      required this.lastDate,
      required this.time,
      required this.place,
      required this.description,
      required this.mainTitle});

  @override
  State<StatefulWidget> createState() {
    return _DetailEventScreenState();
  }
}

class _DetailEventScreenState extends State<DetailEventScreen> {
  var dateFormatter = new DateFormat('dd-MM-yyyy');

  @override
  Widget build(BuildContext context) {
    String startDate = dateFormatter.format(widget.startDate);
    String endDate = dateFormatter.format(widget.endDate);
    String lastDate = dateFormatter.format(widget.lastDate);
    return Scaffold(
      // backgroundColor: Colors.white,
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 10, right: 10.0),
                    onPressed: () {
                      setState(() {});
                    },
                    icon: Icon(Icons.favorite_border),
                    iconSize: 30.0,
                    color: Colors.white,
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '${startDate} to ${endDate}',
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  lastDate,
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  widget.time,
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  widget.place,
                  style: TextStyle(color: Colors.black, fontSize: 18),
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
                  style: TextStyle(
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
                    style: TextStyle(color: Colors.black),
                    trimLines: 3,
                    colorClickableText: Colors.black,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Show more',
                    trimExpandedText: 'Show less',
                    lessStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                    moreStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 30, left: 90, right: 90),
            child: RaisedButton(
              child: Text(
                widget.mainTitle == "Today Events"
                    ? "View"
                    : widget.mainTitle == "Past Events"
                        ? "View Result"
                        : widget.mainTitle == "Upcoming Events"
                            ? "Apply"
                            : "Else",
                style: TextStyle(fontSize: 20),
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
              color: Colors.blueAccent,
              textColor: Colors.black,
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
        style: TextStyle(fontSize: 20),
      );
    } else if (widget.mainTitle == "Past Events") {
      return Text(
        "View Result",
        style: TextStyle(fontSize: 20),
      );
    } else if (widget.mainTitle == "Upcoming Events") {
      return Text(
        "Apply",
        style: TextStyle(fontSize: 20),
      );
    } else {}
  }
}
