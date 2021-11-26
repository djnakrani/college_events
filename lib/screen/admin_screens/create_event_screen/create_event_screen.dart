import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../time_picker.dart';

class CreateEventScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CreateEventScreenState();
  }
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  late String _eventName, _eventDescription, _place;
  late int _maxParticispate;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _startDateController =
      new TextEditingController();
  final TextEditingController _endDateController = new TextEditingController();
  final TextEditingController _lastDateController = new TextEditingController();
  final TextEditingController _timeController = new TextEditingController();

  CollectionReference objEventDetails =
      FirebaseFirestore.instance.collection('event_details');
  final List<String> whomFor = ["Male", "Female", "Both"];
  String _selectedType = "Male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
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
                      labelText: "Event Name",
                      border: new OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _eventName = value.toString();
                    },
                    validator: (val) =>
                        val!.isEmpty ? "Event Name should not be empty" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    // controller: _descriptionController,
                    decoration: new InputDecoration(
                      labelText: "Description",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty
                        ? "Event description should not be empty"
                        : null,
                    onChanged: (value) {
                      _eventDescription = value.toString();
                    },
                    maxLines: 4,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    // controller: _placeController,
                    decoration: new InputDecoration(
                      labelText: "Event Place",
                      border: new OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _place = value.toString();
                    },
                    validator: (val) =>
                        val!.isEmpty ? "Event Place should not be empty" : null,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child:
                        new CalendarPicker(_startDateController, "Start Date")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new CalendarPicker(_endDateController, "End Date")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child:
                        new CalendarPicker(_lastDateController, "Last Date")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new TimePicker(_timeController, "Time")),
                Card(
                  margin: EdgeInsets.only(top: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black45, width: 0.8),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Whom For   :   "),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: _selectedType,
                              underline: Container(
                                height: 2,
                                color: Colors.white,
                              ),
                              style: GoogleFonts.openSans(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedType = newValue!;
                                });
                              },
                              items: whomFor.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(value),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 8.0),
                  child: new TextFormField(
                    // controller: _maxController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Max Participate in Team",
                      border: new OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      // _maxParticispate = value.toString();
                    },
                    validator: (val) =>
                        val!.isEmpty ? "Enter Max Participate in Team" : null,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                        String timeFormat = "EEE, MMM d, yyyy";
                        String dateTimeFormat = "EEE, MMM d, yyyy 'at' h:mm a";
                        DateTime sDate = DateFormat(timeFormat)
                            .parseStrict(_startDateController.text);
                        DateTime eDate = DateFormat(timeFormat)
                            .parseStrict(_endDateController.text);
                        DateTime lDate = DateFormat(timeFormat)
                            .parseStrict(_lastDateController.text);
                        DateTime time = DateFormat(dateTimeFormat)
                            .parseStrict(_timeController.text);

                        objEventDetails
                            .add({
                              'eventtitle': _eventName,
                              'description': _eventDescription,
                              'startdate': Timestamp.fromDate(sDate),
                              'enddate': Timestamp.fromDate(eDate),
                              'lastdate': Timestamp.fromDate(lDate),
                              'time': Timestamp.fromDate(time),
                              'place': _place,
                              'maxparticipate': 2,
                              'whomfor': _selectedType,
                              'imgurl': 'images/tugofwar.jpg',
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
