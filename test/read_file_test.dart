import 'package:student_utils_app/models/note.dart';
import 'package:student_utils_app/service/file/note/note_file.dart';
import 'package:test/test.dart';

void main() {
  group('Read note file', () {
    test('Read note', () async {
      var result = await readNotes();

      expect(result, <Note>[
        Note(title: "some note", description: "note"),
        Note(title: "some more", description: "note taking")
      ]);
    });
    test('Read nonexist file', () async {
      var file = null;
      var result = await readNotes();

      expect(result, throwsA(NoSuchMethodError));
    });
    test('Read empty file', () async {
      var result = await readNotes();

      expect(result, <Note>[]);
    });
  });
}
