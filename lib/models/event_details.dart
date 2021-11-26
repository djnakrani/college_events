// import 'dart:collection';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// final firestoreInstance = FirebaseFirestore.instance;
// class EventDetails {
//   static Future<List<EventDetails>> _getEventsFromFirestore() async {
//     CollectionReference ref = firestoreInstance.collection("event_details");
//     // for (var queryDocumentSnapshot in querySnapshot.docs) {
//     // Map<String, dynamic> data = queryDocumentSnapshot.data();
//     // var name = data['name'];
//     // var phone = data['phone'];
//   }
// }
// //   // String imageUrl;
// //   String eventtitle;
// //   DateTime startdate;
// //   DateTime enddate;
// //   DateTime lastdate;
// //   String time;
// //   String place;
// //   String description;
// //   String whomfor;
// //
// //   EventDetails({
// //     // required this.imageUrl,
// //     required this.eventtitle,
// //     required this.startdate,
// //     required this.enddate,
// //     required this.lastdate,
// //     required this.time,
// //     required this.place,
// //     required this.description,
// //     required this.whomfor,
// //   });
// //   factory EventDetails.fromMap(dynamic data) => EventDetails(
// //     eventtitle: data["eventtitle"] == null ? null : data["eventtitle"],
// //     startdate: data["startdate"] == null ? null : data["startdate"],
// //     enddate: data["enddate"] == null ? null : data["enddate"],
// //     lastdate: data["lastdate"] == null ? null : data["lastdate"],
// //     place: data["place"] == null ? null : data["place"],
// //     description: data["description"] == null ? null : data["description"],
// //     whomfor: data["whomfor"] == null ? null : data["whomfor"],
// //     time: data["time"] == null ? null : data["time"],
// //   );
// //
// //   Map<String, dynamic> toMap() => {
// //     "eventtitle": eventtitle == null ? null : eventtitle,
// //     "startdate": startdate == null ? null : startdate,
// //     "enddate": enddate == null ? null : enddate,
// //     "password": place == null ? null : place,
// //     "profilePicture": profilePicture == null ? null : profilePicture,
// //     "uid": uid == null ? null : uid,
// //   };
// // }