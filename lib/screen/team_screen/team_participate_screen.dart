// import 'package:college_events/models/allparticipate_details.dart';
// import 'package:college_events/screen/participate_screen/participate_details_screen.dart';
// import 'package:flutter/material.dart';
//
// class TeamParticipateScreen extends StatefulWidget {
//   final String teamName;
//   TeamParticipateScreen({required this.teamName});
//
//   @override
//   State<StatefulWidget> createState() {
//     return _TeamParticipateScreenState();
//   }
// }
//
// class _TeamParticipateScreenState extends State<TeamParticipateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color: Colors.black),
//         elevation: 0,
//         title: Text(
//           widget.teamName,
//           style: TextStyle(color: Colors.black, fontSize: 24),
//         ),
//       ),
//       body: ListView.separated(
//         itemCount: participates.length,
//         itemBuilder: (BuildContext context, int index){
//             return ListTile(
//               title: Padding(
//                 padding: const EdgeInsets.only(top: 5, bottom: 5),
//                 child: Text(
//                   '${participates.map((e) => e.name).elementAt(index)}',
//                   style: TextStyle(color: Colors.black, fontSize: 20),
//                 ),
//               ),
//               dense: true,
//               trailing: Icon(Icons.keyboard_arrow_right),
//               selected: participates[index].selected,
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ParticipateDetailsScreen()));
//               },
//             );
//           },
//           separatorBuilder: (context, index) {
//             return Divider();
//           },
//         ),
//     );
//   }
// }
