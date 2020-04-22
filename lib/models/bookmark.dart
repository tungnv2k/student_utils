import 'package:flutter/material.dart';

class Bookmark {
  final String title;
  final String link;

  Bookmark({this.title, @required this.link});

  @override
  bool operator ==(covariant Bookmark other) {
    return this.title == (other.title) && this.link == (other.link);
  }

  @override
  int get hashCode => this.hashCode;
}
