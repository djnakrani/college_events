import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ParticipateDetailsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParticipateDetailsScreenState();
  }
}

class _ParticipateDetailsScreenState extends State<ParticipateDetailsScreen> {
  List<String> items = <String>[
    "Jaipur",
    "Delhi",
    "Jodhpur",
    "Bikaner",
    "Jaipur",
    "Delhi",
    "Jodhpur",
    "Bikaner",
    "Jaipur",
    "Delhi",
    "Jodhpur",
    "Bikaner",
    "Mumbai"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Participate Details",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Stack(
        children: [
          Container(height: 200,),
          Padding(
            padding: EdgeInsets.only(top: 200),
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    items[index],
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  dense: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
