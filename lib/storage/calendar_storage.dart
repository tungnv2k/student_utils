import 'package:flutter/material.dart';
import 'package:student_utils_app/models/calendar_event.dart';

class CalendarStorage extends InheritedWidget {
  final Map<String, List<CalendarEvent>> dateEvents;

  CalendarStorage({Key key, this.dateEvents, Widget child})
      : super(key: key, child: child);

  static CalendarStorage of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CalendarStorage>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return this.dateEvents != dateEvents;
  }
}
