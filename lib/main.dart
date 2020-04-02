import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_utils_app/screens/login_screen.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  runApp(
      MaterialApp(home: email == null ? LoginScreen() : LoginSuccessScreen()));
}
