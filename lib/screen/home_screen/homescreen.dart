import 'package:college_events/screen/models/movie_model.dart';
import 'package:college_events/screen/widgets/content_scroll.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
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
          ),
        ],
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: CarouselSlider(
              options: CarouselOptions(
                height: 220.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
              items: current.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.amber,
                      ),
                      child: Image(
                        image: AssetImage('$i'),
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20.0),
          ContentScroll(
            images: upcoming,
            title: 'Upcoming Events',
            imageHeight: 300.0,
            imageWidth: 200.0,
          ),
          SizedBox(height: 20.0),
          ContentScroll(
            images: past,
            title: 'Past Events',
            imageHeight: 300.0,
            imageWidth: 200.0,
          ),
        ],
      )),
    );
  }
}
