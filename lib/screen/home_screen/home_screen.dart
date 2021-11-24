import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/widgets/carousel_slider.dart';
import 'package:college_events/widgets/content_scroll_vertical.dart';
import 'package:college_events/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> _Events = events;
  List<Event> _CurrentEvent = [];
  List<Event> _PastEvent = [];
  List<Event> _UpcomingEvent = [];
  var now = new DateTime.now();
  var formatter = new DateFormat('dd-MM-yyyy');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    String tmpDate = formatter.format(now);
    DateTime currentDate = formatter.parse(tmpDate);
    _CurrentEvent = _Events.where((i) => ((i.startDate.isBefore(currentDate) && i.endDate.isAfter(currentDate)) || i.startDate.isAtSameMomentAs(currentDate) || i.endDate.isAtSameMomentAs(currentDate) )).toList();
    _PastEvent = _Events.where((i) => (i.endDate.isBefore(currentDate))).toList();
    _UpcomingEvent = _Events.where((i) => (i.startDate.isAfter(currentDate))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: navigationDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(left: 10.0),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        title: Text(
          "    College Events",
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: CarouselSliderWidget(
              events: _CurrentEvent,
              mainTitle: 'Today Events'
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailEventScreen())),
            child: ContentScrollVertical(
              // images: events.map((e) => e.imageUrl).toList(),
              events: _UpcomingEvent,
              mainTitle: 'Upcoming Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailEventScreen())),
            child: ContentScrollVertical(
              events: _PastEvent,
              mainTitle: 'Past Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
        ],
      )),
    );
  }
}
