import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_utils_app/screens/login_screen.dart';
import 'package:student_utils_app/screens/no_login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(MaterialApp(
    theme: ThemeData(),
    home: email == null ? LoginScreen() : NoLoginScreen(),
  ));
}
