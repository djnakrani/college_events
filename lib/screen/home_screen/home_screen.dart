import 'package:college_events/screen/notification_screen/notification_list_screen.dart';
import 'package:college_events/widgets/carousel_slider.dart';
import 'package:college_events/widgets/content_scroll_vertical.dart';
import 'package:college_events/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final int uId;
  HomeScreen({required this.uId});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: navigationDrawer(
        uId: widget.uId,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
        leading: IconButton(
          padding: EdgeInsets.only(top: 4, left: 10.0),
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        title: Center(
          child: Text(
            "College Events",
            style: GoogleFonts.openSans(
                color: Colors.black, fontSize: 28, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(top: 4, right: 10.0),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationsListScreen(widget.uId))),
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
            child: CarouselSliderWidget(
              uId: widget.uId,
              mainTitle: 'Today Events',
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
              uId: widget.uId,
              mainTitle: 'Upcoming Events',
              imageHeight: 300.0,
              imageWidth: 200.0,
            ),
          ),
          SizedBox(height: 20.0),
          GestureDetector(
            child: ContentScrollVertical(
              uId: widget.uId,
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
