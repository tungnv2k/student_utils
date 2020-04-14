import 'package:flutter/material.dart';
import 'package:student_utils_app/screens/login_success_screen.dart';
import 'package:student_utils_app/service/login/sign_in.dart';

class NoLoginScreen extends StatefulWidget {
  @override
  _NoLoginScreenState createState() => _NoLoginScreenState();
}

class _NoLoginScreenState extends State<NoLoginScreen> {
  Future<bool> loginFuture;

  @override
  void initState() {
    super.initState();
    loginFuture = signInWithGoogle(silently: true).whenComplete(() {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
          return LoginSuccessScreen();
        }),
        (Route<dynamic> route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: loginFuture,
          builder: (context, snapshot) {
            return Container(
              color: Color.fromRGBO(0, 36, 86, 1),
              alignment: Alignment.center,
              child: SizedBox(
                width: 150.0,
                child: Image.asset('assets/logo.png'),
              ),
            );
          }),
    );
  }
}
