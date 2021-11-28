import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class CalendarPicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CalendarPickerState();
  final String dtPickerTitle;
  TextEditingController _controller;

  CalendarPicker(
    this._controller,
    this.dtPickerTitle,
  );
}

class CalendarPickerState extends State<CalendarPicker> {
  static String timeFormat = "EEE, MMM d, yyyy";

  void dateTimePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: stringToDate(widget._controller.text) ??
            DateTime.now().add(new Duration(days: 1)),
        firstDate: widget.dtPickerTitle == "Date of Birth"
            ? DateTime(1990)
            : DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 5 * 365)));

    if (date == null) return;

    final TimeOfDay? time = TimeOfDay.now().replacing(hour: 0, minute: 0);

    if (time == null) return;

    DateTime dateAndTime =
        new DateTime(date.year, date.month, date.day, time.hour, time.minute);

    this.setState(() =>
        widget._controller.text = DateFormat(timeFormat).format(dateAndTime));
  }

  static DateTime? stringToDate(String dateString) {
    try {
      return DateFormat(timeFormat).parseStrict(dateString);
    } catch (e) {
      return null;
    }
  }

  bool dateValidator(String date) {
    if (date.isEmpty) return true;
    return stringToDate(date) == null;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(children: <Widget>[
      new Expanded(
          child: new TextFormField(
        decoration: new InputDecoration(
          labelText: widget.dtPickerTitle,
        ),
        controller: widget._controller,
        keyboardType: TextInputType.datetime,
        readOnly: true,
        validator: (val) => dateValidator(val!) ? "Enter a valid date" : null,
      )),
      new IconButton(
        icon: new Icon(Icons.calendar_today),
        onPressed: () => dateTimePicker(),
        tooltip: "Choose date",
      )
    ]);
  }
}
