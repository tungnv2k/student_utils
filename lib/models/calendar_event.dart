import 'package:flutter/material.dart';

const String _event = "Test event";
const String _time = "1 - 3 PM";

class CalendarEvent extends StatelessWidget {
  final String event;
  final String time;

  CalendarEvent({this.event, this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              padding: EdgeInsets.fromLTRB(7.0, 11.0, 7.0, 11.0),
              color: Colors.blueAccent,
              width: 320.0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_event,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0)),
                    Text(
                      _time,
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    )
                  ]),
            ))
      ],
    );
  }
}
