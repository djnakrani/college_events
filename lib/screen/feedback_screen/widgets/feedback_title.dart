import 'package:college_events/screen/feedback_screen/quick_feedback.dart';
import 'package:flutter/material.dart';

class FeedbackTitle extends StatelessWidget {
  const FeedbackTitle({
    Key? key,
    required this.widget,
    required Icon currentFace,
  })  : _currentFace = currentFace,
        super(key: key);

  final QuickFeedback widget;
  final Icon _currentFace;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(widget.title),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 100),
          child: _currentFace,
        ),
      ],
    );
  }
}
