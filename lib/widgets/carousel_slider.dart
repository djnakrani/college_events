import 'package:carousel_slider/carousel_slider.dart';
import 'package:college_events/models/allevents_model.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';

class CarouselSliderWidget extends StatelessWidget{
  final List<Event> events;
  final String mainTitle;

  CarouselSliderWidget({
    required this.events,
    required this.mainTitle,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 240.0,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      items: events.map((i) {
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
                // child: Image(
                //   image: AssetImage(i.imageUrl),
                //   fit: BoxFit.cover,
                // ),
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage(i.imageUrl),
                      fit: BoxFit.fill,
                      width: (MediaQuery.of(context).size.width),
                    ),
                    Positioned(
                      child: Container(
                        child:Text(
                          i.title,
                          style: TextStyle(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                          // maxLines: 1,
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailEventScreen(
                            imgUrl: i.imageUrl,
                            title: i.title,
                            date: i.date,
                            place: i.place,
                            mainTitle: mainTitle,
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
    );
  }

}