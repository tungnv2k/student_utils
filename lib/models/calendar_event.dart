import 'package:flutter/material.dart';

class CalendarEvent {
  final String event;
  final DateTime startTime;
  final DateTime endTime;

  CalendarEvent({@required this.event, this.startTime, this.endTime});
}
