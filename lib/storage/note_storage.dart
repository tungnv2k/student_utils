import 'package:flutter/material.dart';
import 'package:student_utils_app/models/note.dart';

class NoteStorage extends InheritedWidget {
  final List<Note> notes;

  const NoteStorage({Key key, this.notes, Widget child})
      : super(key: key, child: child);

  static NoteStorage of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<NoteStorage>(aspect: NoteStorage);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this.notes != notes;
  }
}
