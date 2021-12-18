import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_events/screen/admin_screens/calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddStudentScreen extends StatefulWidget {
  final String fName;
  final String mNumber;
  final String emailId;
  final String eNumber;
  final String sClass;
  final String clg;
  final String dob;
  final String mTitle;
  final String gender;

  AddStudentScreen({
    this.fName = "",
    this.mNumber = "",
    this.emailId = "",
    this.dob = "",
    this.mTitle = "",
    this.gender = "",
    this.eNumber = "",
    this.sClass = "",
    this.clg = "",
  });

  @override
  State<StatefulWidget> createState() {
    return _AddStudentScreenState();
  }
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _enrollNumber = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  final TextEditingController _emailID = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _dateOfBirthController =
      new TextEditingController();

  CollectionReference objStudentDetails =
      FirebaseFirestore.instance.collection('student_details');
  final List<String> gender = ["Male", "Female"];
  final List<String> sClass = ["FYMCA", "SYMCA", "TYMCA"];
  final List<String> college = ["GMCA, Maninagar"];
  String _selectedGender = "Male";
  String _selectedClass = "FYMCA";
  String _selectedClg = "GMCA, Maninagar";

  @override
  void initState() {
    if (widget.mTitle == "Edit") {
      _fullName.text = widget.fName;
      _enrollNumber.text = widget.eNumber;
      _mobileNumber.text = widget.mNumber;
      _emailID.text = widget.emailId;
      _dateOfBirthController.text = widget.dob;
      _selectedGender = widget.gender;
      _selectedClass = widget.sClass;
      _selectedClg = widget.clg;
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
          widget.mTitle == "Edit" ? "Edit Student Details" : "Add Student",
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
                    controller: _fullName,
                    decoration: new InputDecoration(
                      labelText: "Event Full Name",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Full Name  is required" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new TextFormField(
                    controller: _enrollNumber,
                    decoration: new InputDecoration(
                      labelText: "Enter Enrollment Number",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Enrollment Number is required" : null,
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: new CalendarPicker(
                        _dateOfBirthController, "Date of Birth")),
                Card(
                  margin: EdgeInsets.only(top: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black45, width: 0.8),
                  ),
                  color: Theme.of(context).backgroundColor,
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("Gender   :   "),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: _selectedGender,
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).backgroundColor,
                              ),
                              style: GoogleFonts.openSans(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedGender = newValue!;
                                });
                              },
                              items: gender.map<DropdownMenuItem<String>>(
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
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                      controller: _mobileNumber,
                      keyboardType: TextInputType.number,
                      decoration: new InputDecoration(
                        labelText: "Enter Mobile Number",
                        border: new OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Your Mobile Number';
                        } else if (value.length != 10) {
                          return "Invalid Mobile Number";
                        }
                        return null;
                      }),
                ),
                new Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: new TextFormField(
                    controller: _emailID,
                    keyboardType: TextInputType.number,
                    decoration: new InputDecoration(
                      labelText: "Enter Email Id",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Email Id is required" : null,
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
                        Text("Class   :   "),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: _selectedClass,
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).backgroundColor,
                              ),
                              style: GoogleFonts.openSans(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedClass = newValue!;
                                });
                              },
                              items: sClass.map<DropdownMenuItem<String>>(
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
                  margin: EdgeInsets.only(top: 10.0, bottom: 25),
                  color: Theme.of(context).backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(color: Colors.black45, width: 0.8),
                  ),
                  child: ListTile(
                    title: Row(
                      children: [
                        Text("College Name   :   "),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButton<String>(
                              value: _selectedClg,
                              underline: Container(
                                height: 2,
                                color: Theme.of(context).backgroundColor,
                              ),
                              style: GoogleFonts.openSans(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedClg = newValue!;
                                });
                              },
                              items: college.map<DropdownMenuItem<String>>(
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: new MaterialButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        widget.mTitle == "Edit" ? "Update" : "Add",
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
                        DateTime dob = DateFormat(timeFormat)
                            .parseStrict(_dateOfBirthController.text);

                        if (widget.mTitle == "Edit") {
                          NavigatorState nav;
                          objStudentDetails.doc('${widget.eNumber}').set({
                            'fullname': _fullName.text,
                            'dateofbirth': Timestamp.fromDate(dob),
                            'gender': _selectedGender,
                            'mobileno': _mobileNumber.text,
                            'emailid': _emailID.text,
                            'class': _selectedClass,
                            'collegename': _selectedClg,
                          }, SetOptions(merge: false)).then((value) {
                            nav = Navigator.of(context);
                            nav.pop();
                            nav.pop();
                          }).catchError(
                              (error) => print("Failed to add user: $error"));
                        } else {
                          objStudentDetails
                              .doc('${_enrollNumber.text}')
                              .set({
                                'fullname': _fullName.text,
                                'dateofbirth': Timestamp.fromDate(dob),
                                'gender': _selectedGender,
                                'mobileno': _mobileNumber.text,
                                'emailid': _emailID.text,
                                'class': _selectedClass,
                                'collegename': _selectedClg,
                              })
                              .then((value) => Navigator.pop(context))
                              .catchError((error) =>
                                  print("Failed to add user: $error"));
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
}
