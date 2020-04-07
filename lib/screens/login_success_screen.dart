import 'package:flutter/material.dart';
import 'package:student_utils_app/models/calendar_event.dart';

import 'package:student_utils_app/screens/bookmark_screen.dart';
import 'package:student_utils_app/screens/calendar_screen.dart';
import 'package:student_utils_app/screens/note_list_screen.dart';


Map<String, List<CalendarEvent>> dateEvents = <String, List<CalendarEvent>>{};

class LoginSuccessScreen extends StatefulWidget {
  @override
  _LoginSuccessScreenState createState() => _LoginSuccessScreenState();
}

class _LoginSuccessScreenState extends State<LoginSuccessScreen> {
  PageController pageController;

  @override
  void initState() {
    pageController = PageController(initialPage: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => null, // Prevent returning to login_screen
        child: PageView(
          controller: pageController,
          children: <Widget>[
            BookmarkScreen(),
            CalendarScreen(),
            NoteListScreen()
          ],
        ),
      ),
    );
  }
}
