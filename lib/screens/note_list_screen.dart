import 'package:flutter/material.dart';
import 'package:student_utils_app/models/note.dart';
import 'package:student_utils_app/screens/note_screen.dart';
import 'package:student_utils_app/storage/note_storage.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({Key key}) : super(key: key);

  @override
  State createState() => NoteListScreenState();
}

class NoteListScreenState extends State<NoteListScreen> {
  List<Note> noteList;

  @override
  Widget build(BuildContext context) {
    noteList = NoteStorage.of(context).notes;
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(16.0, 10.0, 8.0, 0.0),
            child: Column(
                children:
                    List.generate((noteList.length / 2.0).ceil(), (index) {
              return _buildNotes(
                index: 2 * index,
                title: noteList[2 * index].title,
                note: noteList[2 * index].description,
              );
            })),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(8.0, 10.0, 16.0, 0.0),
            child: Column(
              children: List.generate((noteList.length / 2).ceil(), (index) {
                if (2 * index + 1 >= noteList.length) {
                  return SizedBox.shrink();
                }
                return _buildNotes(
                  index: 2 * index + 1,
                  title: noteList[2 * index + 1].title,
                  note: noteList[2 * index + 1].description,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotes({@required int index, String title, String note}) {
    final noteTitle = title == null
        ? note.substring(
            0, (note.length <= 15 ? note.length : 15)) // Limit title characters
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
                          ? description.substring(0, 100) +
                              "..." // Description too long
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
        _awaitNoteUpdate(context, index, noteTitle, description);
      },
    );
  }

  void _awaitNoteUpdate(BuildContext context, int index, String noteTitle,
      String description) async {
    Note currentNote = Note(title: noteTitle, description: description);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteScreen(note: currentNote),
        ));

    setState(() {
      if (result != null || result != currentNote) {
        NoteStorage.of(context).notes[index] = result;
      }
    });
  }
}
