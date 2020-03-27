import 'package:flutter/material.dart';

class NoteListScreen extends StatefulWidget {
  @override
  State createState() => NoteListScreenState();
}

class NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Notes"))),
      body: Column(
        children: <Widget>[
          Flexible(
            child: Column(
              children: <Widget>[
                _buildNotes("This is a note"),
                _buildNotes("This is also a note"),
                _buildNotes(
                    "This is a very long note, just for testing, no other purpose"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotes(String note) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 0.5),
          child: Card(
            color: Colors.amberAccent,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                note,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
