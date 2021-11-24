import 'package:college_events/models/allparticipate_details.dart';
import 'package:college_events/models/allteam_details.dart';
import 'package:college_events/screen/team_screen/team_participate_screen.dart';
import 'package:flutter/material.dart';

class TeamNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TeamNameScreenState();
  }
}

class _TeamNameScreenState extends State<TeamNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Team Name",
          style: TextStyle(color: Colors.black, fontSize: 24),
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
      body: Center(
        child: ListView.separated(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${teams.map((e) => e.name).elementAt(index)}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              dense: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamParticipateScreen(
                      teamName:
                          teams.map((e) => e.name).elementAt(index),
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
    );
  }
}
