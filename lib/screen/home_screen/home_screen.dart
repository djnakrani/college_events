import 'package:college_events/screen/notification_screen/notifications_screen.dart';
import 'package:college_events/widgets/carousel_slider.dart';
import 'package:college_events/widgets/content_scroll_vertical.dart';
import 'package:college_events/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  int uId;

  HomeScreen({required this.uId});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  // var now = new DateTime.now();
  // var formatter = new DateFormat('dd-MM-yyyy');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // String tmpDate = formatter.format(now);
    // DateTime currentDate = formatter.parse(tmpDate);
    // _CurrentEvent = _Events.where((i) => ((i.startDate.isBefore(currentDate) && i.endDate.isAfter(currentDate)) || i.startDate.isAtSameMomentAs(currentDate) || i.endDate.isAtSameMomentAs(currentDate) )).toList();
    // _PastEvent = _Events.where((i) => (i.endDate.isBefore(currentDate))).toList();
    // _UpcomingEvent = _Events.where((i) => (i.startDate.isAfter(currentDate))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: navigationDrawer(
        uId: widget.uId,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(top:15, left: 10.0),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        title: Center(
          child: Container(
            padding: EdgeInsets.only(top:15),
            child: Text(
              "College Events",
              style: GoogleFonts.openSans(color: Colors.black, fontSize: 28,fontWeight: FontWeight.bold),
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(top:15, right: 10.0),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NotificationsScreen())),
            icon: Icon(Icons.notifications),
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
            child: CarouselSliderWidget(mainTitle: 'Today Events'),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
              mainTitle: 'Upcoming Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
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
