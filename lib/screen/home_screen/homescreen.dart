import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/screen/event_details_screen/detailseventscreen.dart';
import 'package:college_events/screen/login_signup_screen/login_page_screen.dart';
import 'package:college_events/widgets/content_scroll_vertical.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  void initState() {
    super.initState();
    String tmpDate = formatter.format(now);
    DateTime currentDate = formatter.parse(tmpDate);

    _CurrentEvent = _Events.where((i) => (i.date.isAtSameMomentAs(currentDate))).toList();
    _PastEvent = _Events.where((i) => (i.date.isBefore(currentDate))).toList();
    _UpcomingEvent = _Events.where((i) => (i.date.isAfter(currentDate))).toList();
    print(_CurrentEvent);
    print(_PastEvent);
    print(_UpcomingEvent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "College Events",
          style: TextStyle(color: Colors.black, fontSize: 28),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 30.0),
          onPressed: () => print('Menu'),
          icon: Icon(Icons.menu),
          iconSize: 30.0,
          color: Colors.black,
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),IconButton(
            padding: EdgeInsets.only(right: 30.0),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => login_page_screen())),
            icon: Icon(Icons.login),
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
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 240.0,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    enableInfiniteScroll: true,
                    viewportFraction: 0.8,
                  ),
                  items: _CurrentEvent.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          // padding: EdgeInsets.all(2),
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.amber,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                offset: Offset(0, 2),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            child: Image(
                              image: AssetImage(i.imageUrl),
                              fit: BoxFit.cover,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailEventScreen(
                                        imgUrl: i.imageUrl,
                                        title: i.title,
                                        date: i.date,
                                        description: i.description,
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  }).toList(),
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
