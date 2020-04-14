import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/calendar_screen.dart';
import 'package:student_utils_app/screens/note_list_screen.dart';
import 'bookmark_list_screen.dart';

Map<String, List<CalendarEvent>> dateEvents = <String, List<CalendarEvent>>{};
CalendarApi calendarApi;
var calendarIds = [];
DateTime expiry;

class LoginSuccessScreen extends StatefulWidget {
  @override
  _LoginSuccessScreenState createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => null, // Prevent returning to login_screen on back button
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            BookmarkListScreen(),
            CalendarScreen(),
            NoteListScreen()
          ],
        ),
      ),
    );
  }
}
