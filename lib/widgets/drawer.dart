import 'package:college_events/screen/events_screen/events_list_screen.dart';
import 'package:college_events/screen/gallery_screen/gallery_screen.dart';
import 'package:college_events/screen/student_profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class navigationDrawer extends StatelessWidget {
  int uId;

  navigationDrawer({
    required this.uId,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTap: () {
              uId == 1
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(pId: 0),
                      ))
                  : SizedBox();
            },
          ),
          createDrawerBodyItem(
            icon: Icons.event_note,
            text: uId == 1 ? 'Your Events' : "Assign Upcoming Events",
            onTap: () {
              uId == 1
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventsScreen(mainTitle: "Your Events"),
                      ))
                  : Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EventsScreen(mainTitle: "Assign Upcoming Events"),
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
                  builder: (context) => GalleryScreen(),
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
                  builder: (context) => GalleryScreen(),
                ),
              );
            },
          ),
          createDrawerBodyItem(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryScreen(),
                ),
              );
            },
          ),
          createDrawerBodyItem(
            icon: Icons.logout,
            text: 'Logout',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GalleryScreen(),
                ),
              );
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
    );
  }

  Widget createDrawerHeader() {
    return Container(
      height: 268,
      child: DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     fit: BoxFit.fill,
        //     image: AssetImage('images/storywriting.jpg'),
        //   ),
        // ),
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
