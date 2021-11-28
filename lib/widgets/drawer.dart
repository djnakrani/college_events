import 'package:college_events/screen/admin_screens/add_student_screen/class_list_screen.dart';
import 'package:college_events/screen/admin_screens/create_event_screen/add_events_list_screen.dart';
import 'package:college_events/screen/admin_screens/manage_judge_screen/judge_list_screen.dart';
import 'package:college_events/screen/events_screen/events_list_screen.dart';
import 'package:college_events/screen/gallery_screen/gallery_screen.dart';
import 'package:college_events/screen/profile_screen/student_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class navigationDrawer extends StatelessWidget {
  final int uId;
  navigationDrawer({
    required this.uId,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(context),
            createDrawerBodyItem(
              icon: Icons.account_circle,
              text: uId == 0 ? 'Add Student' : 'Profile',
              onTap: () {
                uId == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassListScreen(),
                        ))
                    : uId == 1
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentProfileScreen(pId: 0),
                            ))
                        : SizedBox();
              },
            ),
            createDrawerBodyItem(
              icon: Icons.event_note,
              text: uId == 1
                  ? 'Your Events'
                  : uId == 2
                      ? "Assign Upcoming Events"
                      : "Create Event",
              onTap: () {
                uId == 0
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEventsScreen(uId: uId,),
                        ))
                    : uId == 2
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventsScreen(
                                uId: uId,
                                mainTitle: "Assign Upcoming Events",
                              ),
                            ),
                          )
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EventsScreen(
                                mainTitle: "Your Events",
                                uId: uId,
                              ),
                            ));
              },
            ),
            if (uId == 0) createDrawerBodyItem(
              icon: Icons.contact_page,
              text: 'Manage Judge',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JudgeListScreen(uId: uId,),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Icons.collections,
              text: 'Gallery',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GalleryScreen(uId),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Icons.contact_page,
              text: 'About Institute',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => JudgeListScreen(uId: uId,),
                  ),
                );
              },
            ),
            createDrawerBodyItem(
              icon: Icons.feedback,
              text: 'Feedback',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GalleryScreen(),
                //   ),
                // );
              },
            ),
            createDrawerBodyItem(
              icon: Icons.logout,
              text: 'Logout',
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => GalleryScreen(),
                //   ),
                // );
              },
            ),
            ListTile(
              enabled: false,
              title: Text('App version 1.0.0',
                  style: GoogleFonts.openSans(
                      fontSize: 16.0,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500)),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerHeader(BuildContext context) {
    return Container(
      height: 268,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 25),
              child: CircleAvatar(
                maxRadius: 60,
                backgroundColor: Colors.white,
                foregroundImage: AssetImage("images/chesscomp.jpg"),
                backgroundImage: AssetImage("images/login.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Kashyap Kalathiya",
                style: GoogleFonts.openSans(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Kashyapkalathiya654@gmail.com",
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createDrawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: GoogleFonts.openSans(fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
