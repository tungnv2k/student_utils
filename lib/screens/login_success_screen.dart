import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:googleapis/calendar/v3.dart' show CalendarApi;
import 'package:student_utils_app/app_life_cycle.dart';
import 'package:student_utils_app/components/app_bar.dart';
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
import 'bookmark_screen.dart';
import 'login_screen.dart';
import 'note_screen.dart';

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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const platform = const MethodChannel('app.channel.shared.data');
  PageController _pageController;
  var _appBarTitle = "Calendar";
  var _onFABPressed;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(LifecycleEventHandler(
      detachedCallBack: () async {
        await writeNotes(notes);
        await writeBookmarks(bookmarks);
      },
      resumeCallBack: () => null
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
    _initShare();
    _onFABPressed = _onCalendarTap;
    _pageController = PageController(initialPage: 1);
  }

  _initShare() async {
    // App is already running in background
    // Listen to lifecycle changes to subsequently call Java MethodHandler to check for shared data
    SystemChannels.lifecycle.setMessageHandler((msg) {
      if (msg.contains('resumed')) {
        _getSharedData().then((d) {
          if (d.isEmpty) return;
          _onBookmarkShare("", d["text"]);
        });
      }
      return;
    });

    // App is started by the intent
    // Call Java MethodHandler on application start up to check for shared data
    var data = await _getSharedData();
    if (data.isNotEmpty) {
      _onBookmarkShare("", data["text"]);
    }
  }

  Future<Map> _getSharedData() async =>
      await platform.invokeMethod('getSharedData');
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: _onFABPressed,
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

  void _onPageSwitch(int value) {
    switch (value) {
      case 0:
        setState(() {
          _appBarTitle = "Bookmarks";
          _onFABPressed = _onBookmarkTap;
        });
        break;
      case 1:
        setState(() {
          _appBarTitle = "Calendar";
          _onFABPressed = _onCalendarTap;
        });
        break;
      case 2:
        setState(() {
          _appBarTitle = "Notes";
          _onFABPressed = _onNoteTap;
        });
        break;
    }
  }

  void _onBookmarkTap() async {
    Bookmark currentBookmark = Bookmark(title: "", link: "");
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookmarkScreen(bookmark: currentBookmark),
        ));

    setState(() {
      if (result != null && result != currentBookmark) {
        bookmarks.add(result);
      }
    });
  }

  void _onCalendarTap() {}

  void _onNoteTap() async {
    Note currentNote = Note(title: "", description: "");
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NoteScreen(note: currentNote),
        ));

    setState(() {
      if (result != null && result != currentNote) {
        notes.add(result);
      }
    });
  }

  void _onBookmarkShare(String title, String link) async {
    _pageController.jumpToPage(0);

    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              BookmarkScreen(bookmark: Bookmark(title: title, link: link)),
        ));

    setState(() {
      bookmarks.add(result);
    });
  }
}
