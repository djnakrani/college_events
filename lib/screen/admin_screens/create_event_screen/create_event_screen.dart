import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/calendar_picker.dart';
import 'package:college_events/widgets/dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../time_picker.dart';

class CreateEventScreen extends StatefulWidget {
  final String title;
  final String startDate;
  final String endDate;
  final String lastDate;
  final String time;
  final String place;
  final String description;
  final String whomFor;
  final String mTitle;
  final String judgeId;
  final String eventId;
  final num maxparticipate;

  CreateEventScreen(
      {this.startDate = "",
      this.title = "",
      this.endDate = "",
      this.lastDate = "",
      this.time = "",
      this.place = "",
      this.description = "",
      this.whomFor = "",
      this.mTitle = "",
      this.judgeId = "",
      this.maxparticipate = 1,
      this.eventId = ""});

  @override
  State<StatefulWidget> createState() {
    return _CreateEventScreenState();
  }
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _eventName = new TextEditingController();
  final TextEditingController _eventDescription = new TextEditingController();
  final TextEditingController _maxParticipateController =
      new TextEditingController();
  final TextEditingController _place = new TextEditingController();
  final TextEditingController _startDateController =
      new TextEditingController();
  final TextEditingController _endDateController = new TextEditingController();
  final TextEditingController _lastDateController = new TextEditingController();
  final TextEditingController _timeController = new TextEditingController();

  CollectionReference objEventDetails =
      FirebaseFirestore.instance.collection('event_details');
  final objNotificationsDetails =
      FirebaseFirestore.instance.collection("notifications_details");
  CollectionReference objJudgeDetails =
      FirebaseFirestore.instance.collection('judge_details');
  final List<String> whomFor = ["Male", "Female", "Both"];

  String _selectedType = "Male";
  String selectedJudge = "Select Judge";
  bool isFirstTime = false;
  String _jId = "KHbDvyE1LbGrqCHnGKD1";

  @override
  void initState() {
    if (widget.mTitle == "Edit") {
      var strMax = widget.maxparticipate.toString();
      _eventName.text = widget.title;
      _eventDescription.text = widget.description;
      _place.text = widget.place;
      _startDateController.text = widget.startDate;
      _endDateController.text = widget.endDate;
      _lastDateController.text = widget.lastDate;
      _timeController.text = widget.time;
      _maxParticipateController.text = strMax;
      _selectedType = widget.whomFor;
    } else {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.mTitle == "Edit" ? "Edit Event Details" : "Create Event",
          style: GoogleFonts.openSans(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
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
                    controller: _eventName,
                    decoration: new InputDecoration(
                      labelText: "Event Name",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Event Name should not be empty" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    controller: _eventDescription,
                    decoration: new InputDecoration(
                      labelText: "Description",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) => val!.isEmpty
                        ? "Event description should not be empty"
                        : null,
                    maxLines: 4,
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    controller: _place,
                    decoration: new InputDecoration(
                      labelText: "Event Place",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Event Place should not be empty" : null,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new CalendarPicker(
                        _startDateController, "Event Start Date")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new CalendarPicker(
                        _endDateController, "Event End Date")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new CalendarPicker(
                        _lastDateController, "Last Applying Date for Event")),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new TimePicker(_timeController, "Event Time")),
                Card(
                  margin: EdgeInsets.only(top: 20.0),
                  color: Theme.of(context).backgroundColor,
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
                                color: Theme.of(context).backgroundColor,
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
                Card(
                  margin: EdgeInsets.only(top: 10.0),
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black45, width: 0.8),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Assign Judge   :   "),
                        Expanded(
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: StreamBuilder<QuerySnapshot>(
                                stream: objJudgeDetails.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text('Something went wrong');
                                  } else if (snapshot.hasData &&
                                      snapshot.data?.docs.length != 0) {
                                    Iterable<String> name = snapshot.data!.docs
                                        .map((e) => e.get('fullname'));

                                    final List<String> myDemo = [
                                      "Select Judge"
                                    ];
                                    for (final element in name) {
                                      myDemo.add(element);
                                    }

                                    return DropdownButton<String>(
                                      value: selectedJudge,
                                      underline: Container(
                                        height: 2,
                                        color:
                                            Theme.of(context).backgroundColor,
                                      ),
                                      style: GoogleFonts.openSans(
                                          color: Colors.black),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedJudge = newValue!;
                                          print(selectedJudge);
                                        });
                                      },
                                      elevation: 16,
                                      menuMaxHeight: 200,
                                      items: myDemo
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  }
                                  return Container(
                                      height: 100,
                                      child: Center(child: Text("NO DATA")));
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 10.0),
                  child: new TextFormField(
                    controller: _maxParticipateController,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Max Participate in Team",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Enter Max Participate in Team" : null,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: new MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        widget.mTitle == "Edit" ? "Update" : "Create",
                        style: GoogleFonts.openSans(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (selectedJudge != "Select Judge") {
                        final id = objJudgeDetails
                            .where('fullname', isEqualTo: selectedJudge)
                            .get()
                            .then((value) => value.docs.first.id);
                        getUserId(id);
                      } else {
                        _jId = "KHbDvyE1LbGrqCHnGKD1";
                      }
                      print(_jId);
                      if (_formKey.currentState!.validate()) {
                        if (selectedJudge != "Select Judge") {
                          String timeFormat = "EEE, MMM d, yyyy";
                          String dateTimeFormat =
                              "EEE, MMM d, yyyy 'at' h:mm a";
                          DateTime sDate = DateFormat(timeFormat)
                              .parseStrict(_startDateController.text);
                          DateTime eDate = DateFormat(timeFormat)
                              .parseStrict(_endDateController.text);
                          DateTime lDate = DateFormat(timeFormat)
                              .parseStrict(_lastDateController.text);
                          DateTime time = DateFormat(dateTimeFormat)
                              .parseStrict(_timeController.text);
                          var intMax =
                              int.parse(_maxParticipateController.text);
                          if (widget.mTitle == "Edit") {
                            objEventDetails
                                .doc('${widget.eventId}')
                                .set({
                                  'eventtitle': _eventName.text,
                                  'description': _eventDescription.text,
                                  'startdate': Timestamp.fromDate(sDate),
                                  'enddate': Timestamp.fromDate(eDate),
                                  'lastdate': Timestamp.fromDate(lDate),
                                  'time': Timestamp.fromDate(time),
                                  'place': _place.text,
                                  'maxparticipate': intMax,
                                  'whomfor': _selectedType,
                                  'judgeid': _jId,
                                  'imgurl': 'images/tugofwar.jpg',
                                }, SetOptions(merge: false))
                                .then((value) => objNotificationsDetails.add({
                                      'notificationtitle': _selectedType ==
                                              "Both"
                                          ? "${_eventName.text}"
                                          : "${_eventName.text} for ${_selectedType}",
                                      'notificationdescription':
                                          'Event is Updated You Can Check the Details',
                                      'datetime': Timestamp.now(),
                                    }).then((value) {
                                      var nav = Navigator.of(context);
                                      nav.pop();
                                      nav.pop();
                                    }).catchError((error) => print("Failed to add Notification")))
                                .catchError((error) =>
                                    print("Failed to add Notification"));
                          } else {
                            objEventDetails
                                .add({
                                  'eventtitle': _eventName.text,
                                  'description': _eventDescription.text,
                                  'startdate': Timestamp.fromDate(sDate),
                                  'enddate': Timestamp.fromDate(eDate),
                                  'lastdate': Timestamp.fromDate(lDate),
                                  'time': Timestamp.fromDate(time),
                                  'place': _place.text,
                                  'maxparticipate': intMax,
                                  'whomfor': _selectedType,
                                  'judgeid': _jId,
                                  'imgurl': 'images/cricket.jpg',
                                })
                                .then((value) => objNotificationsDetails
                                    .add({
                                      'notificationtitle': _selectedType ==
                                              "Both"
                                          ? "${_eventName.text}"
                                          : "${_eventName.text} for ${_selectedType}",
                                      'notificationdescription':
                                          'Event is created, last date for apply in event is ${_lastDateController.text} and Assigned Judge is ${selectedJudge}',
                                      'datetime': Timestamp.now(),
                                    })
                                    .then((value) => Navigator.pop(context))
                                    .catchError((error) => print(
                                        "Failed to add Notification: $error")))
                                .catchError((error) => print(
                                    "Failed to add Notification: $error"));
                          }
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return DialogBox(
                                onSubmitCallback: () {},
                                subtitle: 'Please Select Judge',
                                showTitle: false,
                                showButton: false,
                                showOk: true,
                                showTextBox: false,
                                title: '',
                                onAskLaterCallback: (onSubmit) {},
                                askLaterText: 'Ok',
                                submitText: 'Ok',
                              );
                            },
                          );
                        }
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

  Future<void> getUserId(futureString) async {
    final jId = await futureString;
    setState(() => _jId = jId);
  }
}
