import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogBox extends StatefulWidget {
  final String title;
  final String subtitle;
  final String hintText;
  final bool showTextBox;
  final bool showButton;
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
      this.textScore = "null"});

  @override
  _DialogBoxState createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  TextEditingController textEditor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.textScore != "null" ? textEditor.text = widget.textScore : null;
    return AlertDialog(
      backgroundColor: Theme.of(context).backgroundColor,
      title: Center(
        child: Text(
          widget.title,
          style: GoogleFonts.openSans(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      content: Container(
        width: MediaQuery.of(context).size.width * 0.72,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 8),
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
            )
          ],
        ),
      ),
      actions: [
        Visibility(
          visible: widget.showButton,
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.onAskLaterCallback is Function) {
                widget.onAskLaterCallback();
              }
            },
            child: Text(widget.askLaterText),
            color: Theme.of(context).primaryColor,
            textColor: Colors.white,
            padding: EdgeInsets.all(8.0),
            splashColor: Colors.grey,
          ),
        ),
        Visibility(
          visible: widget.showTextBox,
          child: MaterialButton(
            onPressed: () => widget.onSubmitCallback({
              'text': textEditor.text,
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
