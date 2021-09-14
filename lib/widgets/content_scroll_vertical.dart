import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/screen/event_details_screen/detailseventscreen.dart';
import 'package:college_events/screen/events_screen/eventscreen.dart';
import 'package:flutter/material.dart';

class ContentScrollVertical extends StatelessWidget {
  final List<Event> events;
  final String title;
  final double imageHeight;
  final double imageWidth;

  ContentScrollVertical({
    required this.events,
    required this.title,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventsScreen(
                      eventsAll: events,
                    ),
                  ),
                ),
                child: Text(
                  "See All",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                // Row(
                //   children: [
                //     Text("See All",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                //     Icon(
                //       Icons.arrow_forward,
                //       color: Colors.black,
                //       size: 22.0,
                //     ),
                //   ],
                // ),
                // child: Text("See All"),
              ),
            ],
          ),
        ),
        Container(
          height: imageHeight,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailEventScreen(
                            imgUrl:
                                events.map((e) => e.imageUrl).elementAt(index),
                            title: events.map((e) => e.title).elementAt(index),
                            date: events.map((e) => e.date).elementAt(index),
                            description: events
                                .map((e) => e.description)
                                .elementAt(index),
                          ),
                        ),
                      );
                    },
                    child: Image(
                      image: AssetImage(
                          events.map((e) => e.imageUrl).elementAt(index)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
