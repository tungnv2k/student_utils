import 'package:flutter/material.dart';
import 'package:student_utils_app/models/bookmark.dart';

class BookmarkStorage extends InheritedWidget {
  final List<Bookmark> bookmarks;

  BookmarkStorage({Key key, this.bookmarks, Widget child})
      : super(key: key, child: child);

  static BookmarkStorage of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<BookmarkStorage>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this.bookmarks != bookmarks;
  }
}
