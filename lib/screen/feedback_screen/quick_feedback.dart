library quick_feedback;

import 'dart:io';
import 'package:college_events/screen/feedback_screen/material_feedback_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class QuickFeedback extends StatefulWidget {
  // String title of the feedback dialog
  final String title;

  // default star value
  final int defaultRating;

  // show text box hint
  final bool showTextBox;

  // text box hint
  final String textBoxHint;

  // on submit callback method
  final Function onSubmitCallback;

  // on submit callback method
  final Function onAskLaterCallback;

  // submit button text default to SUBMIT
  final String submitText;

  // submit button text default to ASK ME LATER
  final String askLaterText;

  QuickFeedback({
    required this.title,
    required this.onSubmitCallback,
    required this.onAskLaterCallback,
    this.textBoxHint = 'Tell us more',
    this.defaultRating = 0,
    this.showTextBox = false,
    this.submitText = 'SUBMIT',
    this.askLaterText = 'ASK ME LATER',
  });

  @override
  _QuickFeedbackState createState() => _QuickFeedbackState();
}

class _QuickFeedbackState extends State<QuickFeedback> {
  late int _rating;
  Icon _currentFace = Icon(Icons.insert_emoticon);
  TextEditingController textEditor = TextEditingController();

  @override
  void initState() {
    setState(() {
      _rating = widget.defaultRating;
    });
    _iconAsPerRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _stars = _buildStars();
    if (Platform.isAndroid) {
      return MaterialFeedbackDialog(
        stars: _stars,
        widget: widget,
        rating: _rating,
        currentFace: _currentFace,
        feedbackEditingController: textEditor,
        feedbackTextBox: _feedbackTextBox(),
      );
    } else {
      return Container(
        child: Center(
          child: Text('Only Supported for Android and iOS.'),
        ),
      );
    }
  }

  Widget _feedbackTextBox() {
    return TextField(
      controller: textEditor,
      decoration: InputDecoration(
        hintText: widget.textBoxHint,
      ),
    );
  }

  void _iconAsPerRating() {
    setState(() {
      // _currentFace = _getFeedbackIcon();
    });
  }

  Widget _getFeedbackIcon() {
    switch (_rating) {
      case 1:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
      case 2:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
      case 3:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
      case 4:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
      case 5:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
      default:
        return Icon(Icons.insert_emoticon, key: ValueKey(_rating));
        break;
    }
  }

  List<Widget> _buildStars() {
    List<Widget> buttons = [];

    for (int rateValue = 1; rateValue <= 5; rateValue++) {
      final starRatingButton = Expanded(
        child: IconButton(
          icon: Icon(
            _rating >= rateValue ? Icons.star : Icons.star_border,
            color: Theme.of(context).accentColor,
            size: 35,
          ),
          onPressed: () {
            setState(() {
              _rating = rateValue;
            });
            _iconAsPerRating();
          },
        ),
      );
      buttons.add(starRatingButton);
    }

    return buttons;
  }
}