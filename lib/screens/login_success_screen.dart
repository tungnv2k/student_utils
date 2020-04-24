import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart' show CalendarApi;
import 'package:student_utils_app/app_life_cycle.dart';
import 'package:student_utils_app/models/bookmark.dart';
import 'package:student_utils_app/models/calendar_event.dart';
import 'package:student_utils_app/models/note.dart';
import 'package:student_utils_app/screens/calendar_screen.dart';
import 'package:student_utils_app/screens/note_list_screen.dart';
import 'package:student_utils_app/service/file/bookmark/bookmark_file.dart';
import 'package:student_utils_app/service/file/note/note_file.dart';
import 'package:student_utils_app/service/login/sign_in.dart';
import 'package:student_utils_app/storage/bookmark_storage.dart';
import 'package:student_utils_app/storage/calendar_storage.dart';
import 'package:student_utils_app/storage/note_storage.dart';
import 'bookmark_list_screen.dart';
import 'login_screen.dart';

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
  Map<String, List<CalendarEvent>> dateEvents =
      <String, List<CalendarEvent>>{};
  List<Bookmark> bookmarks = <Bookmark>[];
  List<Note> notes = <Note>[];
  PageController _pageController;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      detachedCallBack: () async {
        await writeNotes(notes);
        await writeBookmarks(bookmarks);
      },
    ));
    readNotes().then((result) {
      setState(() {
        notes = result;
      });
    });
    readBookmarks().then((result) {
      setState(() {
        bookmarks = result;
      });
    });
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
                dateEvents.clear();
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
      appBar: buildTopBar(
          title: _appBarTitle,
          leftIcon: EvaIcons.menu,
          rightIcon: EvaIcons.moreVerticalOutline,
          onLeftTap: () => _scaffoldKey.currentState.openDrawer()),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageSwitch,
        children: <Widget>[
          BookmarkStorage(
              bookmarks: bookmarks, child: const BookmarkListScreen()),
          CalendarStorage(
              dateEvents: dateEvents, child: const CalendarScreen()),
          NoteStorage(notes: notes, child: const NoteListScreen())
        ],
      ),
        ),
      ),
    );
  }
}
