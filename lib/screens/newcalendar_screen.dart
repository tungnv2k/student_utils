import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_utils_app/models/date_event.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/models/menu.dart';

class NewCalendarScreen extends StatefulWidget
{
  @override
  State createState()=> CalendarState();
}
class CalendarState extends State<NewCalendarScreen>
{
  final List<DateEvent> _dateEvents =<DateEvent>[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Center(child:Text("Calendar")),
        actions: <Widget>[
          IconButton(
              icon:Icon(Icons.refresh , color: Colors.white),
              onPressed: () {
//            smtE
              }),
          IconButton(
            icon: Icon(Icons.list,color: Colors.white,),
            onPressed: () { //do smt/?
            },
          ),
        ],
      ),
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
                    })
            ),
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>setState((){
          DateEvent _dateEvent = new DateEvent();
        _dateEvent.getEvents().addAll(
            [CalendarEvent(), CalendarEvent(), CalendarEvent()]);
        _dateEvents.insert(0, _dateEvent);
        }),
        child:  new Icon(Icons.add),
      ),
    );
  }
}