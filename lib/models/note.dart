import 'dart:ui';

import 'package:flutter/material.dart';

class Note {
  final String title;
  final String description;
  final Color color;
  final DateTime updatedAt;

  Note({
    @required this.title,
    @required this.description,
    this.color,
    this.updatedAt,
  });

  @override
  bool operator ==(covariant Note other) {
    return this.title == (other.title) &&
        this.description == (other.description);
  }

  @override
  int get hashCode => this.hashCode;
}
