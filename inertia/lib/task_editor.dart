// Class for adding new events in your calendar.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskEditor extends StatefulWidget {
  @override
  TaskEditorState createState() => TaskEditorState();
}

class TaskEditorState extends State<TaskEditor> {
  Widget _getTaskEditor(BuildContext context) {
    return Container(
      color: Colors.black,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("New Event", style: TextStyle(color: Colors.yellowAccent)),
            backgroundColor: Colors.blue.shade900,
            leading: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.red.shade900,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
    );
  }
  
}
