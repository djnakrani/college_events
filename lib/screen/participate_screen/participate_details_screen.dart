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
    "Enrollment Number",
    "Roll Number",
    "Gender",
    "Date of Birth",
    "Email Id",
    "Mobile Number",
    "Blood Group",
    "Address",
    "College Name",
  ];
  List<String> items1 = <String>[
    "205690694039",
    "92",
    "Male",
    "08-05-2000",
    "kashyap@gmail.com",
    "9889898989",
    "A+",
    "Surat",
    "GMCA",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Participate Details",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(vertical: 10),
            height: 200,
            child: Image(
              image: AssetImage('images/login.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Kashyap Ghanshyambhai Kalathiya",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${items[index]} : ${items1[index]}',
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
