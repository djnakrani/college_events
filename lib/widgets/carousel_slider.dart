import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/event_details_screen/details_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CarouselSliderWidget extends StatelessWidget {
  final List<String> gallary = [
    "img1.png",
    "img2.png",
    "img4.png",
    "img3.png",
  ];
  final String mainTitle;
  final int uId;
  final List<dynamic> currentNameList;

  CarouselSliderWidget({
    required this.uId,
    required this.mainTitle,
    required this.currentNameList,
  });

  var objEventDetails = FirebaseFirestore.instance.collection("event_details");

  @override
  Widget build(BuildContext context) {
    print("Event title $currentNameList");
    return FutureBuilder<QuerySnapshot>(
      future:
          objEventDetails.where("eventtitle", whereIn: currentNameList).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
          return CarouselSlider.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              QueryDocumentSnapshot<Object?>? documentSnapshot =
                  snapshot.data?.docs[index];
              return Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                width: MediaQuery.of(context).size.width,
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
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          documentSnapshot!["imgurl"],
                        ),
                        fit: BoxFit.fill,
                        height: 240,
                        width: (MediaQuery.of(context).size.width),
                      ),
                      Positioned(
                        child: Container(
                          child: Text(
                            documentSnapshot["whomfor"] == "Male"
                                ? '${documentSnapshot["eventtitle"]} - Male'
                                : documentSnapshot["whomfor"] == "Female"
                                    ? '${documentSnapshot["eventtitle"]} - Female'
                                    : (documentSnapshot["eventtitle"]),
                            style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailEventScreen(
                          uId: uId,
                          eventId: documentSnapshot.id,
                          imgUrl: documentSnapshot["imgurl"],
                          title: documentSnapshot["eventtitle"],
                          startDate: documentSnapshot["startdate"],
                          endDate: documentSnapshot["enddate"],
                          lastDate: documentSnapshot["lastdate"],
                          time: documentSnapshot["time"],
                          place: documentSnapshot["place"],
                          whomFor: documentSnapshot["whomfor"],
                          mainTitle: mainTitle,
                          description: documentSnapshot["description"],
                          maxparticipate: documentSnapshot["maxparticipate"],
                          judgeId: documentSnapshot["judgeid"],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            options: CarouselOptions(
              height: 240.0,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
          );
        }
        return CarouselSlider(
          options: CarouselOptions(
            height: 240.0,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
          ),
          items: gallary.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  // padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(top: 8, bottom: 8),
                  width: MediaQuery.of(context).size.width,
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
                  child: Stack(
                    children: <Widget>[
                      Image(
                        image: AssetImage("images/${i.toString()}"),
                        fit: BoxFit.fill,
                        height: 240,
                        width: (MediaQuery.of(context).size.width),
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

//  CarouselSlider With List (Just For Reference)

// return CarouselSlider(
//   options: CarouselOptions(
//     height: 240.0,
//     enlargeCenterPage: true,
//     aspectRatio: 16 / 9,
//     enableInfiniteScroll: true,
//     viewportFraction: 0.8,
//   ),
//   items: events.map((i) {
//     return Builder(
//       builder: (BuildContext context) {
//         return Container(
//           // padding: EdgeInsets.all(2),
//           margin: EdgeInsets.only(top: 8, bottom: 8),
//           width: MediaQuery.of(context).size.width,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(8.0),
//             color: Colors.amber,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black,
//                 offset: Offset(0, 2),
//                 blurRadius: 6.0,
//               ),
//             ],
//           ),
//           child: GestureDetector(
//             child: Stack(
//               children: <Widget>[
//                 Image(
//                   image: AssetImage(i.imageUrl),
//                   fit: BoxFit.fill,
//                   width: (MediaQuery.of(context).size.width),
//                 ),
//                 Positioned(
//                   child: Container(
//                     child: Text(
//                       i.title,
//                       style: GoogleFonts.openSans(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                       // maxLines: 1,
//                     ),
//                     color: Colors.white54,
//                     padding:
//                         EdgeInsets.only(top: 8, left: 15, bottom: 8),
//                     width: (MediaQuery.of(context).size.width),
//                     alignment: Alignment.bottomLeft,
//                   ),
//                   bottom: 0,
//                 ),
//               ],
//             ),
//             onTap: () {
//               // Navigator.push(
//               //   context,
//               //   MaterialPageRoute(
//               //     builder: (context) =>
//               //         DetailEventScreen(
//               //           imgUrl: i.imageUrl,
//               //           title: i.title,
//               //           startDate: i.startDate,
//               //           endDate: i.endDate,
//               //           lastDate: i.lastDate,
//               //           time: i.time,
//               //           place: i.place,
//               //           mainTitle: mainTitle,
//               //           description: i.description,
//               //         ),
//               //   ),
//               // );
//             },
//           ),
//         );
//       },
//     );
//   }).toList(),
// );
