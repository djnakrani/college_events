import 'package:college_events/models/allparticipate_details.dart';
import 'package:college_events/screen/participate_screen/participate_details_screen.dart';
import 'package:flutter/material.dart';

class TeamParticipateScreen extends StatefulWidget {
  final String teamName;
  TeamParticipateScreen({required this.teamName});

  @override
  State<StatefulWidget> createState() {
    return _TeamParticipateScreenState();
  }
}

class _TeamParticipateScreenState extends State<TeamParticipateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.teamName,
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
          itemCount: participates.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${participates.map((e) => e.name).elementAt(index)}',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              dense: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  '${participates.map((e) => e.div).elementAt(index)}',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              onTap: () {
                print('$index');
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
