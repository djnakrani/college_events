import 'package:flutter/material.dart';

dialog_box(BuildContext context,String title,String subtitle) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(subtitle),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      });
}
