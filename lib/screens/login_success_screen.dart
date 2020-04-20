import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/screens/calendar_screen.dart';
import 'package:student_utils_app/screens/note_list_screen.dart';
import 'package:student_utils_app/service/login/sign_in.dart';
import 'bookmark_list_screen.dart';
import 'login_screen.dart';

Map<String, List<CalendarEvent>> dateEvents = <String, List<CalendarEvent>>{};
CalendarApi calendarApi;
var calendarIds = [];
DateTime expiry;

class LoginSuccessScreen extends StatefulWidget {
  final String name;
  final String email;
  final String imageUrl;

  const LoginSuccessScreen({Key key, this.name, this.email, this.imageUrl})
      : super(key: key);

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.imageUrl),
                    radius: 30.0,
                    backgroundColor: Colors.transparent,
                  ),
                  Text(widget.email),
                  Text(widget.name)
                ],
              ),
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {},
            ),
            ListTile(
              title: Text("Log out"),
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen();
                  }),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        ),
      ),
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
