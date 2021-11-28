import 'package:college_events/models/allteam_details.dart';
import 'package:college_events/screen/match_screen/create_match_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'match_detail_screen.dart';

class MatchNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MatchNameScreenState();
  }
}

class _MatchNameScreenState extends State<MatchNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Match Name",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            onPressed: () => print('Search'),
            icon: Icon(Icons.search),
            iconSize: 30.0,
            color: Colors.black,
          ),
          IconButton(
            padding: EdgeInsets.only(right: 10.0),
            onPressed: () => print('Add'),
            icon: Icon(Icons.add),
            iconSize: 30.0,
            color: Colors.black,
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              child: Row(
                children: [
                  Image(
                    image: AssetImage("images/1.png"),
                    height: 65,
                    width: 65,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Add New Match",
                    style: GoogleFonts.openSans(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateMatchScreen(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                "Pending Match",
                style: GoogleFonts.openSans(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: teams.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Image(
                        image: AssetImage("images/1.png"),
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${teams.map((e) => e.name).elementAt(index)}\n  vs \n${teams.map((e) => e.name).elementAt(index)}',
                        style: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  dense: true,
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchDetailsScreen(
                          matchName:
                              '${teams.map((e) => e.name).elementAt(index)} vs ${teams.map((e) => e.name).elementAt(index)}',
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                "All Match",
                style: GoogleFonts.openSans(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Image(
                        image: AssetImage("images/1.png"),
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${teams.map((e) => e.name).elementAt(index)}\n  vs \n${teams.map((e) => e.name).elementAt(index)}',
                        style: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
                      ),
                    ],
                  ),
                  dense: true,
                  trailing: Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchDetailsScreen(
                          matchName:
                          '${teams.map((e) => e.name).elementAt(index)} vs ${teams.map((e) => e.name).elementAt(index)}',
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
        ],
      ),
    );
  }
}
