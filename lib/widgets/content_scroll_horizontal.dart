import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';

class ContentScrollHorizontal extends StatelessWidget {
  final List<Event> events;
  final String mainTitle;

  ContentScrollHorizontal({
    required this.events,
    required this.mainTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: (MediaQuery.of(context).size.height),
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.vertical,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 15.0,
                ),
                width: MediaQuery.of(context).size.width,
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
                            place: events.map((e) => e.place).elementAt(index),
                            mainTitle: mainTitle,
                            description: events
                                .map((e) => e.description)
                                .elementAt(index),
                          ),
                        ),
                      );
                    },
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              events.map((e) => e.imageUrl).elementAt(index)),
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                            child: Container(
                              child:Text(
                                  events.map((e) => e.title).elementAt(index),
                                  style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                                  maxLines: 1,
                              ),
                              color: Colors.white54,
                              padding: EdgeInsets.only(top: 8, left: 15, bottom: 8),
                              width: (MediaQuery.of(context).size.width),
                              alignment: Alignment.bottomLeft,
                            ),
                          bottom: 0,
                        ),
                      ],
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
