import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateJudgeScreen extends StatefulWidget {
  final String fName;
  final String mNumber;
  final String emailId;
  final String add;
  final String mTitle;
  final String gender;
  final String judgeId;

  CreateJudgeScreen(
      {this.fName = "",
      this.mNumber = "",
      this.emailId = "",
      this.add = "",
      this.mTitle = "",
      this.gender = "",
      this.judgeId = ""});

  @override
  State<StatefulWidget> createState() {
    return _CreateJudgeScreenState();
  }
}

class _CreateJudgeScreenState extends State<CreateJudgeScreen> {
  final TextEditingController _fullName = new TextEditingController();
  final TextEditingController _mobileNumber = new TextEditingController();
  final TextEditingController _emailId = new TextEditingController();
  final TextEditingController _address = new TextEditingController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  CollectionReference objJudgeDetails =
      FirebaseFirestore.instance.collection('judge_details');
  final List<String> gender = ["Male", "Female"];
  String _selectedGender = "Male";

  @override
  void initState() {
    if (widget.mTitle == "Edit") {
      _fullName.text = widget.fName;
      _mobileNumber.text = widget.mNumber;
      _emailId.text = widget.emailId;
      _address.text = widget.add;
      _selectedGender = widget.gender;
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
          widget.mTitle == "Edit" ? "Edit Judge Details" : "Add Judge",
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
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: new TextFormField(
                    controller: _fullName,
                    decoration: new InputDecoration(
                      labelText: "Enter Full Name",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Name is Required" : null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
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
                new TextFormField(
                  controller: _emailId,
                  decoration: new InputDecoration(
                    labelText: "Enter Email ID",
                    border: new OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      val!.isEmpty ? "Email ID is Required" : null,
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
                                    padding: const EdgeInsets.all(10.0),
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
                  padding: const EdgeInsets.only(top: 10, bottom: 20.0),
                  child: new TextFormField(
                    controller: _address,
                    decoration: new InputDecoration(
                      labelText: "Enter Address",
                      border: new OutlineInputBorder(),
                    ),
                    validator: (val) =>
                        val!.isEmpty ? "Address is Required" : null,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                        if (widget.mTitle == "Edit") {
                          NavigatorState nav;
                          objJudgeDetails.doc('${widget.judgeId}').set({
                            'fullname': _fullName.text,
                            'mobileno': _mobileNumber.text,
                            'emailid': _emailId.text,
                            'gender': _selectedGender,
                            'address': _address.text,
                          }, SetOptions(merge: false)).then((value) {
                            nav = Navigator.of(context);
                            nav.pop();
                            nav.pop();
                          }).catchError(
                              (error) => print("Failed to add user: $error"));
                        } else {
                          objJudgeDetails
                              .add({
                                'fullname': _fullName.text,
                                'mobileno': _mobileNumber.text,
                                'emailid': _emailId.text,
                                'gender': _selectedGender,
                                'address': _address.text,
                              })
                              .then((value) => Navigator.pop(context))
                              .catchError((error) =>
                                  print("Failed to add Notification: $error"));
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
