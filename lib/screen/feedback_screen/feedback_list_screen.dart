import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class FeedbackListScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FeedbackListScreenState();
  }
}

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  final objFeedbackDetails =
      FirebaseFirestore.instance.collection("feedback_details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Feedbacks",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: objFeedbackDetails
            .orderBy("date", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData && snapshot.data?.docs.length != 0) {
            return SingleChildScrollView(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  QueryDocumentSnapshot<Object?>? documentSnapshot =
                      snapshot.data?.docs[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 6.0,
                    ),
                    // height: 60,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black54,
                          offset: Offset(0.0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: ListTile(
                        title: Text(
                          '${documentSnapshot!["email"]}',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                        ),
                        subtitle: Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: ReadMoreText(
                            (documentSnapshot["description"]),
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            trimLines: 2,
                            colorClickableText: Colors.black,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            lessStyle: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            moreStyle: GoogleFonts.openSans(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        trailing: Text(
                          dateTimeText(documentSnapshot['date']),
                          style: GoogleFonts.openSans(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 13),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Container(height: 100, child: Center(child: Text("NO DATA")));
        },
      ),
    );
  }

  String dateTimeText(Timestamp tmpDtTime) {
    DateTime dtTime = tmpDtTime.toDate();
    Duration diff = DateTime.now().difference(dtTime);
    if (diff.inDays >= 1) {
      return '${diff.inDays}d';
    } else if (diff.inHours >= 1) {
      return '${diff.inHours}h';
    } else if (diff.inMinutes >= 1) {
      return '${diff.inMinutes}min';
    } else if (diff.inSeconds >= 1) {
      return '${diff.inSeconds}sec';
    } else {
      return 'just now';
    }
  }
}
