import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/widgets/content_scroll_horizontal.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  final List<Event> eventsAll;
  final String mainTitle;
  EventsScreen({
    required this.eventsAll,
    required this.mainTitle
  });

  @override
  State<StatefulWidget> createState() {
    return _EventsScreenState();
  }
}

class _EventsScreenState extends State<EventsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.mainTitle,
          style: TextStyle(color: Colors.black, fontSize: 26),
        ),
      ),
      body: Center(
        child: ListView(
          children: [
            GestureDetector(
              // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailEventScreen(event: events[index]))),
              child: ContentScrollHorizontal(
                events: widget.eventsAll,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
