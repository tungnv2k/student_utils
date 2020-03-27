import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  @override
  State createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Notes"))),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              color: Colors.amberAccent,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  maxLines: 20,
                  decoration:
                  InputDecoration.collapsed(hintText: "Enter your notes"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
