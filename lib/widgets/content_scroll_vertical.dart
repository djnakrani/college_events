import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:college_events/screen/events_screen/events_list_screen.dart';
import 'package:flutter/material.dart';

class ContentScrollVertical extends StatelessWidget {
  final List<Event> events;
  final String mainTitle;
  final double imageHeight;
  final double imageWidth;

  ContentScrollVertical({
    required this.events,
    required this.mainTitle,
    required this.imageHeight,
    required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                mainTitle,
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
                      mainTitle: this.mainTitle,
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
            padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                            imgUrl:events.map((e) => e.imageUrl).elementAt(index),
                            title: events.map((e) => e.title).elementAt(index),
                            startDate: events.map((e) => e.startDate).elementAt(index),
                            endDate: events.map((e) => e.endDate).elementAt(index),
                            lastDate: events.map((e) => e.lastDate).elementAt(index),
                            time: events.map((e) => e.time).elementAt(index),
                            place: events.map((e) => e.place).elementAt(index),
                            mainTitle: mainTitle,
                            description: events
                                .map((e) => e.description)
                                .elementAt(index),
                          ),
                        ),
                      );
                    },
                    // child: Image(
                    //   image: AssetImage(
                    //       events.map((e) => e.imageUrl).elementAt(index)),
                    //   fit: BoxFit.cover,
                    // ),
                    child: Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage(
                              events.map((e) => e.imageUrl).elementAt(index)),
                          fit: BoxFit.cover,
                          height:(MediaQuery.of(context).size.height),
                          width: (MediaQuery.of(context).size.width),
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
