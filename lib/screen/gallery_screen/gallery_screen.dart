import 'package:college_events/screen/gallery_screen/gallery_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GalleryScreen extends StatefulWidget {
  final int uId;

  GalleryScreen(this.uId);

  final List<String> gallary = [
    "img1.png",
    "img2.png",
    "img4.png",
    "img3.png",
    "img6.png",
    "img7.png",
    "img8.png",
    "img9.png",
  ];

  @override
  State<StatefulWidget> createState() {
    return _GalleryScreenState();
  }
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Gallery",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.builder(
        itemCount: widget.gallary.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, i) {
          return Padding(
            padding: EdgeInsets.all(2),
            child: GestureDetector(
                child: Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: AssetImage(
                            "images/${widget.gallary[i].toString()}"),
                        fit: BoxFit.cover),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GalleryDetailsScreen(
                        intPage: i,
                      ),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: widget.uId == 0
          ? FloatingActionButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => CreateJudgeScreen()));
              },
              child: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
    );
  }
}
