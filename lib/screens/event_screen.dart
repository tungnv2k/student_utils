import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_utils_app/service/parse/date_time_parse.dart';

class EventScreen extends StatefulWidget {
  final DateTime date;
  final String event;
  final String timeSpan;

  const EventScreen({Key key, this.date, this.event, this.timeSpan})
      : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: InkWell(
                child: Icon(
                  EvaIcons.close,
                  size: 36.0,
                  color: Colors.blue,
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            Container(
              height: 50.0,
              alignment: Alignment.center,
              color: Colors.blue,
              child: RichText(
                text: TextSpan(
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontFamily: 'ProximaNovaSoft'),
                    children: <TextSpan>[
                      TextSpan(
                          text: toWeekDay(widget.date),
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: ", " +
                              widget.date.day.toString() +
                              " " +
                              toMonth(widget.date),
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w400))
                    ]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      widget.event,
                      style: TextStyle(
                          fontFamily: 'ProximaNovaSoft',
                          fontSize: 26.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      widget.timeSpan,
                      style: TextStyle(
                          fontFamily: 'ProximaNovaSoft',
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.start,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
