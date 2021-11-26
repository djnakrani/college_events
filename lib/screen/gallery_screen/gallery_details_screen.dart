import 'package:college_events/widgets/carousel_slider_gallery.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GalleryDetailsScreen extends StatefulWidget {
  int intPage;
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

  GalleryDetailsScreen({required this.intPage});

  @override
  State<StatefulWidget> createState() {
    return _GalleryDetailsScreenState();
  }
}

class _GalleryDetailsScreenState extends State<GalleryDetailsScreen> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.intPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          title: Text(
            "",
            style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
          ),
        ),
        body: Stack(
          children: [
            _buildContent(),
            _buildIndicator(),
          ],
        ),
    );
  }

  Widget _buildIndicator() {
    return Positioned(
      left: 0.0,
      bottom: 0.0,
      right: 0.0,
      child: Container(
        child: carouselDetailsGalleryScreen(curIndex: _currentIndex, gallery: widget.gallary,),),
    );
  }

  Widget _buildContent() {
    return PhotoViewGallery.builder(
      scrollPhysics: const BouncingScrollPhysics(),
      builder: (BuildContext context, int index) {
        return PhotoViewGalleryPageOptions(
          imageProvider:
          AssetImage("images/${widget.gallary[index].toString()}"),
          heroAttributes: PhotoViewHeroAttributes(tag: widget.gallary[index]),
          minScale: PhotoViewComputedScale.contained * 0.8,
          maxScale: PhotoViewComputedScale.covered * 0.8,
        );
      },
      itemCount: widget.gallary.length,
      backgroundDecoration: BoxDecoration(),
      pageController: _pageController,
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
