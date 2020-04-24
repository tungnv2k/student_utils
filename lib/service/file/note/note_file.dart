import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:student_utils_app/models/note.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _noteFile async {
  final path = await _localPath;
  return File('$path/note.txt');
}

Future<List<Note>> readNotes() async {
  List<Note> notes = <Note>[];

  try {
    final file = await _noteFile;
    var contents = await file.readAsString();
    if (contents.contains("``")) {
      var noteArr = contents.split('``');

      noteArr.forEach((elem) {
        var note = elem?.split('~');
        notes.add(Note(title: note[0], description: note[1]));
      });
    }
    return notes;
  } catch (e) {
    return notes;
  }
}

Future<File> writeNotes(List<Note> notes) async {
  final file = await _noteFile;
  notes.forEach((note) {
    file.writeAsString('${note.title}~${note.description}``');
  });
  return file;
}
