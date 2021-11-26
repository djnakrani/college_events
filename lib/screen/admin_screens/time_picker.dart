import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new TimePickerState();
  final String dtPickerTitle;
  TextEditingController _controller;

  TimePicker(
    this._controller,
    this.dtPickerTitle,
  );
}

class TimePickerState extends State<TimePicker> {
  static String timeFormat = "EEE, MMM d, yyyy 'at' h:mm a";

  void dateTimePicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: stringToDate(widget._controller.text) ??
            DateTime.now().add(new Duration(days: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(new Duration(days: 5 * 365)));

    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
            context: context,
            initialTime: stringToTime(widget._controller.text) ??
                TimeOfDay.now().replacing(minute: 0));

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

  static TimeOfDay? stringToTime(String timeString) {
    try {
      return TimeOfDay.fromDateTime(
          DateFormat(timeFormat).parseStrict(timeString));
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
            icon: new Icon(Icons.calendar_today)),
        controller: widget._controller,
        keyboardType: TextInputType.datetime,
        validator: (val) => dateValidator(val!) ? "Enter a valid date" : null,
      )),
      new IconButton(
        icon: new Icon(Icons.more_horiz),
        onPressed: () => dateTimePicker(),
        tooltip: "Choose date",
      )
    ]);
  }
}
