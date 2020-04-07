import 'package:flutter/material.dart';
import 'package:student_utils_app/components/app_bar.dart';
import 'package:student_utils_app/models/note.dart';
import 'package:student_utils_app/screens/note_screen.dart';

class NoteListScreen extends StatefulWidget {
  @override
  State createState() => NoteListScreenState();
}

class NoteListScreenState extends State<NoteListScreen> {
  List<Note> noteList = <Note>[
    Note(title: null, description: "Tran Quoc Thong"),
    Note(title: "Idol", description: "Japonaise"),
    Note(title: "", description: "Stop it"),
    Note(
        title: null,
        description:
            "reeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeerererererererererererererererererereererererererererererererererererererereerererrrerere"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: buildTopBar("Notes")),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 0.0),
                child: Column(
                    children: List.generate(noteList.length ~/ 2, (index) {
                  return _buildNotes(
                    noteList[2 * index].description,
                    title: noteList[2 * index].title,
                  );
                })),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(8.0, 10.0, 16.0, 0.0),
                child: Column(
                    children: List.generate(noteList.length ~/ 2, (index) {
                  return _buildNotes(
                    noteList[2 * index + 1].description,
                    title: noteList[2 * index + 1].title,
                  );
                })),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNotes(String note, {String title}) {
    final noteTitle = title == null
        ? note.substring(0, (note.length <= 15 ? note.length : 15))  // Limit title characters
        : title;
    final description =
        title == null ? (note.length > 15 ? note.substring(15) : "") : note;

    return GestureDetector(
      child: Container(
        color: Colors.amberAccent,
        width: MediaQuery.of(context).size.width / 2 - 8.0 * 3,
        margin: EdgeInsets.only(bottom: 15.0),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                noteTitle,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.75)),
              ),
              description.isNotEmpty
                  ? Text(
                      description.length > 100
                          ? description.substring(0, 100) + "..."   // Description too long
                          : description,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.60)))
                  : SizedBox.shrink(),
              SizedBox(height: 30.0)
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteScreen(
                  note: Note(title: noteTitle, description: description)),
            ));
      },
    );
  }
}
