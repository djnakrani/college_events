import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailEventScreen extends StatelessWidget {
  final String imgUrl;
  final String title;
  final DateTime date;
  final String place;
  final String description;
  final String mainTitle;
  var dateFormatter = new DateFormat('dd-MM-yyyy');
  var timeFormatter = new DateFormat('hh:mm a');

  DetailEventScreen({required this.imgUrl, required this.title,
      required this.date,required this.place,
      required this.description,required this.mainTitle});

  @override
  Widget build(BuildContext context) {
    String strDate = dateFormatter.format(date);
    String strTime = timeFormatter.format(date);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Image(
                  height: 400.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  image: AssetImage(imgUrl),
                ),
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
                      title,
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.only(top: 10, right: 10.0),
                    onPressed: () => print('Add to Favorites'),
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
                  padding: EdgeInsets.only(left : 10),
                  child: Text(
                    "Event Date :",
                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
              ),
              Padding(
                padding: EdgeInsets.only(left : 10),
                child: Text(
                  strDate,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:15,left : 10),
                child: Text(
                  "Event Time :",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15,left : 10),
                child: Text(
                  strTime,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:15,left : 10),
                child: Text(
                  "Event Place :",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:15,left : 10),
                child: Text(
                  place,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:20,left : 10),
                child: Text(
                  "Event Description :",
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
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
                  child: Text(
                    description,
                    // textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: 50,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 5, bottom: 30, left: 90, right: 90),
            child: RaisedButton(
              child: Text("Apply", style: TextStyle(fontSize: 20),),
              onPressed: (){},
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
}
