import 'package:college_events/models/allteam_details.dart';
import 'package:college_events/screen/team_screen/team_participate_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateMatchScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _CreateMatchScreenState();
  }
}

class _CreateMatchScreenState extends State<CreateMatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
         "Create Match",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
        ),

      ),
      body: Center(
        child: ListView.separated(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                '${teams.map((e) => e.name).elementAt(index)}',
                style: GoogleFonts.openSans(color: Colors.black, fontSize: 20),
              ),
              dense: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              onTap: () {},
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
