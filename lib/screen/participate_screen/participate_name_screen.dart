import 'package:flutter/material.dart';

class ParticipateNameScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParticipateNameScreenState();
  }
}

class _ParticipateNameScreenState extends State<ParticipateNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Participate",
          style: TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                'Participate $index',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              dense: true,
              trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'Male',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              onTap: () {
                print('$index');
              },
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
        ),
      ),
    );
  }
}
