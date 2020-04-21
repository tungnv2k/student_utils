import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:student_utils_app/models/bookmark.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _bookmarkFile async {
  final path = await _localPath;
  return File('$path/bookmark.txt');
}

Future<List<Bookmark>> readBookmarks() async {
  List<Bookmark> bookmarks = <Bookmark>[];

  try {
    final file = await _bookmarkFile;

    var lines = await file.readAsLines();

    lines.forEach((line) {
      print(line);
      line.split("@");
      bookmarks.add(Bookmark(title: line[0], link: line[1]));
    });

    return bookmarks;
  } catch (e) {
    return bookmarks;
  }
}

Future<File> writeBookmarks(List<Bookmark> bookmarks) async {
  final file = await _bookmarkFile;

  bookmarks.forEach((bookmark) {
    file.writeAsString('${bookmark.title}@${bookmark.link}\n');
  });

  return file;
}
