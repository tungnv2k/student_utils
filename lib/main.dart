import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarScreen(),
    );
  }
}

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
                _dateEvent._events.addAll([
                  CalendarEvent(),
                  CalendarEvent(),
                  CalendarEvent()
                ]);
                _dateEvents.insert(0, _dateEvent);
              }),
            ),
          )
        ],
      ),
    );
  }
}

const String _day = "30";
const String _month = "FEB";

class DateEvent extends StatelessWidget {
  final String date;
  final List<CalendarEvent> _events = <CalendarEvent>[];

  DateEvent({this.date});

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
                    Container(
                      child: Text(
                        _time,
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    )
                  ]),
            ))
      ],
    );
  }
}
