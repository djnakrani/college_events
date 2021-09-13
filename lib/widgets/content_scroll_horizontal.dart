import 'package:flutter/material.dart';

class ContentScrollHorizontal extends StatelessWidget {
  final List<String> images;
  final String title;
  // final double imageHeight;
  // final double imageWidth;

  ContentScrollHorizontal({
    required this.images,
    required this.title,
    // required this.imageHeight,
    // required this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            scrollDirection: Axis.vertical,
            itemCount: images.length,
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
                  child: Image(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
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
