import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NotificationsScreenState();
  }
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Notifications",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("notifications_details")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return ListView.separated(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot<Object?>? documentSnapshot =
                snapshot.data?.docs[index];
                return ListTile(
                  title: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      documentSnapshot!['notificationtitle'],
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                  subtitle: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      documentSnapshot['notificationdescription'],
                      style: GoogleFonts.openSans(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  dense: true,
                  trailing: Text(
                    dateTimeText(documentSnapshot['datetime']),
                    style: GoogleFonts.openSans(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  onTap: () {},
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
          return Container(height: 100, child: Center(child: Text("NO DATA")));
        },
      ),
    );
  }
  String dateTimeText(Timestamp tmpDtTime){
    DateTime dtTime = tmpDtTime.toDate();
    Duration diff = DateTime.now().difference(dtTime);
    if(diff.inDays >= 1){
      return '${diff.inDays} days ago';
    } else if(diff.inHours >= 1){
      return '${diff.inHours} hours ago';
    } else if(diff.inMinutes >= 1){
      return '${diff.inMinutes} minutes ago';
    } else if (diff.inSeconds >= 1){
      return '${diff.inSeconds} seconds ago';
    } else {
      return 'just now';
    }
  }
}
