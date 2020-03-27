import 'package:flutter/material.dart';
import 'package:student_utils_app/models/date_event.dart';
import 'package:student_utils_app/models/calendar_event.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  final List<DateEvent> _dateEvents = <DateEvent>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Calendar"))),
      body: Column(
        children: <Widget>[
          Flexible(
            // List Calendar events
              child: ListView.separated(
                  padding: EdgeInsets.all(6.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _dateEvents[index],
                  itemCount: _dateEvents.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 8);
                  })),
          Container(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                DateEvent _dateEvent = new DateEvent();
                _dateEvent.getEvents().addAll(
                    [CalendarEvent(), CalendarEvent(), CalendarEvent()]);
                _dateEvents.insert(0, _dateEvent);
              }),
            ),
          )
        ],
      ),
    );
  }
}
