import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AssignJudgeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AssignJudgeScreenState();
  }
}

class _AssignJudgeScreenState extends State<AssignJudgeScreen> {
  late String _notificationName, _notificationDescription;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final objNotificationsDetails =
  FirebaseFirestore.instance.collection("notifications_details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Create Event",
          style: GoogleFonts.openSans(color: Colors.black, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: new Padding(
          padding: const EdgeInsets.all(15.0),
          child: new Form(
            key: _formKey,
            child: new Column(
              children: <Widget>[
                new Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    // controller: _nameController,
                    decoration: new InputDecoration(
                      labelText: "Enter Notification Title",
                      border: new OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _notificationName = value.toString();
                    },
                    validator: (val) =>
                        val!.isEmpty ? "Notification Title is required" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    // controller: _descriptionController,
                    decoration: new InputDecoration(
                      labelText: "Enter Description",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty
                        ? "Description is required"
                        : null,
                    onChanged: (value) {
                      _notificationDescription = value.toString();
                    },
                    maxLines: 4,
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: new MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        "Create",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        objNotificationsDetails
                            .add({
                              'notificationtitle': _notificationName,
                              'notificationdescription': _notificationDescription,
                              'datetime': Timestamp.now(),
                            })
                            .then((value) => Navigator.pop(context))
                            .catchError(
                                (error) => print("Failed to add user: $error"));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
