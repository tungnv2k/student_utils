import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_utils_app/screens/bookmark_screen.dart';
import 'package:student_utils_app/screens/calendar_screen.dart';
import 'package:student_utils_app/screens/login_screen.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/screens/note_list_screen.dart';
import 'package:student_utils_app/screens/no_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
    theme: ThemeData(fontFamily: 'ProximaNovaSoft'),
    home: email == null ? LoginScreen() : LoginSuccessScreen(),
    routes: {
      '/login': (context) => LoginScreen(),
      '/login_success': (context) => LoginSuccessScreen(),
      '/calendar': (context) => CalendarScreen(),
      '/note_list': (context) => NoteListScreen(),
      '/bookmark': (context) => BookmarkScreen(),
    },
    home: email == null ? LoginScreen() : NoLoginScreen(),
  ));
}
