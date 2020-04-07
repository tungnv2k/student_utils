import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/login_screen.dart';
import 'package:student_utils_app/service/login/sign_in.dart';
import '../components/app_bar.dart';
import 'login_success_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State createState() => CalendarScreenState();
}

class CalendarScreenState extends State<CalendarScreen> {
  ScrollController _scrollController;
  Future<Map<String, List<CalendarEvent>>> futureEvents;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 7);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              height: 300.0,
              child: buildTopBar("Calendar")),
          Column(
            children: <Widget>[
              Container(
                height: 88.0,
                color: Colors.transparent,
              ),
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
                      child: _buildListView()),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 33.0),
            child: RaisedButton(
              onPressed: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }), ModalRoute.withName('/'));
              },
              color: Colors.deepPurple,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
  Widget _buildListView() {
    return ListView.builder(
        padding: EdgeInsets.all(6.0),
        controller: _scrollController,
        itemCount: dateEvents.length,
        itemBuilder: (BuildContext context, int index) {
          String date = dateEvents.keys.elementAt(index);
          return Column(children: <Widget>[
            _buildDateTile(
              DateTime.parse(date),
              dateEvents[date],
              date != toDate(DateTime.now().toLocal()).toString(),
            ),
            Divider(height: 8),
          ]);
        });
  }

  Widget _buildDateTile(
      DateTime date, List<CalendarEvent> events, bool isNotToday) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
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
        _buildEventList(events),
      ],
    );
  }

  Widget _buildEventList(List<CalendarEvent> events) {
    if (events.isEmpty) {
      return Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(6.0, 5.0, 0.5, 5.0),
            padding: EdgeInsets.fromLTRB(7.0, 11.0, 7.0, 11.0),
            width: 320.0,
            height: 50.0,
          )
        ],
      );
    }
    return Column(
      children: List.generate(events.length, (index) {
        return _buildEventTile(
          events[index].event,
          events[index].startTime,
          events[index].endTime,
        );
      }),
    );
  }

  Widget _buildEventTile(String event, DateTime startTime, DateTime endTime) {
    return Container(
        padding: EdgeInsets.fromLTRB(6.0, 5.0, 0.5, 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 14.0, 8.0, 14.0),
                  color: Colors.blueAccent,
                  width: 320.0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(event,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0)),
                        _buildTimeFrame(startTime, endTime),
                      ]),
                ))
          ],
        ));
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
}
