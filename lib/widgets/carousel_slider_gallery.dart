import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class carouselDetailsGalleryScreen extends StatelessWidget {
  final List<String> gallery;
  int curIndex;

  carouselDetailsGalleryScreen({
    required this.curIndex,
    required this.gallery,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100,
          // enlargeCenterPage: true,
          // aspectRatio: 16 / 3,
          // enableInfiniteScroll: true,
          viewportFraction: 0.21,
          initialPage: curIndex,
        ),
        items: gallery.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 3),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/${i.toString()}"),
                      fit: BoxFit.cover,
                      height: 100,
                      width: (MediaQuery.of(context).size.width),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

}
