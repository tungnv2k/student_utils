import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/event_screen.dart';
import 'package:student_utils_app/screens/login_screen.dart';
import 'package:student_utils_app/service/calendar/google_calendar_service.dart';
import 'package:student_utils_app/service/login/sign_in.dart';
import 'package:student_utils_app/service/parse/date_time_parse.dart';
import 'package:student_utils_app/storage/calendar_storage.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/app_bar.dart';
import 'login_success_screen.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key key}) : super(key: key);

  @override
  State createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  Map<String, List<CalendarEvent>> dateEvents;
  CalendarController _calendarController;
  ItemScrollController _scrollController;
  Future<Map<String, List<CalendarEvent>>> futureEvents;
  double heightCalendar;
  bool tabCalIsCollapsed;
  Color appBarColor;
  Color titleColor;

  @override
  void initState() {
    _scrollController = ItemScrollController();
    super.initState();
    _calendarController = CalendarController();
    heightCalendar = 0.0;
    tabCalIsCollapsed = true;
    appBarColor = Colors.black;
    titleColor = Colors.white;
    futureEvents = initCalendar();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateEvents = CalendarStorage.of(context).dateEvents;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            color: Colors.indigo,
            child: Column(
              children: <Widget>[
                _buildTableCalendar(),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 88.0,
                        color: Colors.white,
                        child: _buildDateList()),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: SafeArea(
                child: buildTopBar("Calendar",
                    color: appBarColor, titleColor: titleColor)),
            onTap: () {
              setState(() {
                if (tabCalIsCollapsed) {
                  appBarColor = titleColor = Colors.transparent;
                  tabCalIsCollapsed = false;
                } else {
                  appBarColor = Colors.black;
                  titleColor = Colors.white;
                  tabCalIsCollapsed = true;
                }
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 33.0),
            child: RaisedButton(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                  (Route<dynamic> route) => false,
                );
              },
              color: Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          )
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            EvaIcons.plus,
            size: 35.0,
            color: Colors.blue,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDateList() {
    if (dateEvents.isNotEmpty) {
      return _buildListView();
    }
    return FutureBuilder<Map<String, List<CalendarEvent>>>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          dateEvents.addAll(snapshot.data);
          return _buildListView();
        }
        return Column(
          children: <Widget>[
            SizedBox(height: 5.0, child: new LinearProgressIndicator()),
          ],
        );
      },
    );
  }

  Widget _buildListView() {
    return ScrollablePositionedList.builder(
        padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
        itemScrollController: _scrollController,
        itemCount: dateEvents.length,
        itemBuilder: (BuildContext context, int index) {
          String date = dateEvents.keys.elementAt(index);
          return Column(children: <Widget>[
            _buildDateTile(
              DateTime.parse(date),
              dateEvents[date],
              date != toDate(DateTime.now().toLocal()).toString(),
            ),
            Divider(height: 10.0),
          ]);
        });
  }

  Widget _buildDateTile(
      DateTime date, List<CalendarEvent> events, bool isNotToday) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Flexible(
          flex: 3,
          child: Container(
            width: 44.0,
            height: 44.0,
            padding: EdgeInsets.only(top: 4.0),
            margin: EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: isNotToday ? Colors.transparent : Colors.indigo[400],
            ),
            child: Column(
              children: <Widget>[
                Text(
                  toWeekDay(date),
                  style: TextStyle(
                    fontSize: 12,
                    color: isNotToday ? Colors.grey : Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  toDay(date),
                  style: TextStyle(
                    fontSize: 22,
                    color: isNotToday ? Colors.black : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ),
        Flexible(flex: 20, child: _buildEventList(events)),
      ],
    );
  }

  Widget _buildEventList(List<CalendarEvent> events) {
    if (events.isEmpty) {
      return _buildEventTile("No events.", null, null,
          color: Colors.transparent, textColor: Colors.grey.withOpacity(0.7));
    }
    return Column(
      children: List.generate(events.length, (index) {
        return _buildEventTile(
            events[index].event, events[index].startTime, events[index].endTime,
            color: Colors.blueAccent);
      }),
    );
  }

  Widget _buildEventTile(String event, DateTime startTime, DateTime endTime,
      {Color color, Color textColor = Colors.white}) {
    return InkWell(
        child: Container(
          margin: EdgeInsets.fromLTRB(6.0, 5.0, 3.0, 5.0),
          padding: EdgeInsets.fromLTRB(8.0, 11.0, 2.0, 11.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 18.0,
                  child: Text(event,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0)),
                ),
                _buildTimeFrame(startTime, endTime),
              ]),
        ),
        splashColor: Colors.white.withOpacity(0.6),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventScreen(
                date: DateTime(startTime.year, startTime.month, startTime.day),
                event: event,
                timeSpan: toTimeFrame(startTime, endTime),
              ),
            )));
  }

  Widget _buildTimeFrame(DateTime startTime, DateTime endTime) {
    if (startTime == null && endTime == null) {
      return SizedBox.shrink();
    }
    return Text(
      toTimeFrame(startTime, endTime),
      style: TextStyle(color: Colors.white, fontSize: 15.0),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    int rows = last.difference(first).inDays ~/ 7;
    setState(() {
      heightCalendar = 140.0 + rows * 40;
    });
    if (format == CalendarFormat.month) {
      if (first.day != 1) {
        _calendarController.setSelectedDay(
            DateTime(first.year, first.month + 1, 1),
            runCallback: true);
      } else {
        _calendarController.setSelectedDay(first, runCallback: true);
      }
    }
    if (format == CalendarFormat.week) {
      _calendarController.setSelectedDay(first, runCallback: true);
    }
  }

  _buildTableCalendar() {
    if (tabCalIsCollapsed) {
      return SizedBox(height: 60.0);
    }
    return TableCalendar(
      calendarController: _calendarController,
      rowHeight: 40.0,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      headerStyle: HeaderStyle(
        formatButtonShowsNext: false,
        leftChevronIcon: Icon(Icons.close, color: Colors.transparent), // Hide
        rightChevronIcon: Icon(Icons.close, color: Colors.transparent), // Hide
      ),
      onDaySelected: (day, list) => scrollTo(day),
      onVisibleDaysChanged: _onVisibleDaysChanged,
    );
  }

  void scrollTo(DateTime date) {
    _scrollController.scrollTo(
        index: date.difference(DateTime.now()).inDays,
        duration: Duration(milliseconds: 400));
  }
}
