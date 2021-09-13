import 'package:college_events/models/movie_model.dart';
import 'package:college_events/widgets/content_scroll_horizontal.dart';
import 'package:flutter/material.dart';

class UpcomingEvent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpcomingEvent();
  }
}

class _UpcomingEvent extends State<UpcomingEvent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Upcoming Events",
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            ContentScrollHorizontal(
              images: upcoming,
              title: 'Upcoming Events',
            ),
          ],
        ),
      ),
    );
  }
}
