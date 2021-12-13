import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox extends StatefulWidget {
  final String title;
  final String subtitle;
  final String hintText;
  final bool showTitle;
  final bool showTextBox;
  final bool showButton;
  final bool showOk;
  final bool showDelete;
  final bool dropdown;
  final Function onSubmitCallback;
  final Function onAskLaterCallback;
  final String submitText;
  final String textScore;
  final String askLaterText;

  DialogBox(
      {required this.title,
      required this.subtitle,
      required this.showTextBox,
      required this.showButton,
      required this.onSubmitCallback,
      required this.onAskLaterCallback,
      required this.submitText,
      required this.askLaterText,
      this.hintText = "Enter Here",
      this.textScore = "null",
      this.showTitle = true,
      required this.showOk,
      this.dropdown = false, this.showDelete=false});

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  TextEditingController textEditor = TextEditingController();
  final List<String> teamStatus = ["Pending", "Won", "Loss","Winner","1st RunnerUp","2nd RunnerUp"];
  String _selectedType = "Pending";

  @override
  Widget build(BuildContext context) {
    textEditor.text = "x";
    widget.textScore != "null" ? textEditor.text = widget.textScore : null;
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Visibility(
        visible: widget.showTitle,
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.openSans(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 2),
              child: Visibility(
                visible: widget.showButton,
                child: Text(
                  widget.subtitle,
                  style: GoogleFonts.openSans(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Visibility(
              visible: widget.showTextBox,
              child: TextField(
                controller: textEditor,
                decoration: InputDecoration(
                  hintText: widget.hintText,
                ),
              ),
            ),
            Visibility(
              visible: widget.dropdown,
              child: Card(
                margin: EdgeInsets.only(top: 20.0),
                color: Theme.of(context).backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(color: Colors.black45, width: 0.8),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.72,
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
                        textEditor.text = _selectedType;
                        print(_selectedType);
                      });
                    },
                    elevation: 16,
                    menuMaxHeight: 200,
                    items: teamStatus
                        .map<DropdownMenuItem<String>>((String value) {
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
            )
          ],
        ),
      ),
      actions: [
        Visibility(
          visible: widget.showButton,
          child: MaterialButton(
            onPressed: () => widget.onAskLaterCallback({
              Navigator.of(context).pop(),
            }),
            child: Text(widget.askLaterText),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            // splashColor: Colors.grey,
          ),
        ),
        Visibility(
          visible: widget.showOk,
          child: MaterialButton(
            onPressed: () => widget.onSubmitCallback({
              'text': textEditor.text,
            }),
            child: Text(widget.submitText),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            // splashColor: Colors.grey,
          ),
        ),
        Visibility(
          visible: widget.showDelete,
          child: MaterialButton(
            onPressed: () => widget.onSubmitCallback({
              'text': "Done",
            }),
            child: Text(widget.submitText),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            // splashColor: Colors.grey,
          ),
        )
      ],
    );
  }
}
