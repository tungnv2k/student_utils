import 'package:flutter/material.dart';
import 'calendar_event.dart';

const String _day = "30";
const String _month = "FEB";

class DateEvent extends StatelessWidget {
  final String date;
  final List<CalendarEvent> _events = <CalendarEvent>[];

  DateEvent({this.date});

  List<CalendarEvent> getEvents() {
    return _events;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 11.0),
          child: Column(
            children: <Widget>[
              Text(
                _month,
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Text(
                _day,
                style: TextStyle(fontSize: 22),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Column(
          children: List.generate(_events.length, (index) {
            return Container(
              padding: EdgeInsets.fromLTRB(6.0, 5.0, 0.5, 5.0),
              child: _events[index],
            );
          }),
        )
      ],
    );
  }
}
