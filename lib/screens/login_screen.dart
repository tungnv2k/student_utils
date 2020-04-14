import 'package:flutter/material.dart';
import 'package:student_utils_app/service/login/sign_in.dart';

import 'login_success_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String _loadingText = "Signing in...";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Colors.white,
            Colors.white,
            Colors.indigo[400].withOpacity(0.5)
          ],
              stops: [
            0,
            0.60,
            1
          ])),
      child: Scaffold(
        body: Stack(children: <Widget>[
          _loginView(),
          _loadingView(),
        ]),
        backgroundColor: Colors.transparent,
      ),
    );
  }

  Widget _loginView() {
    return Container(
      margin: EdgeInsets.fromLTRB(30.0, 120.0, 30.0, 100.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[400].withOpacity(0.5),
              blurRadius: 20.0,
              offset: Offset(0.0, -8.0))
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50.0),
          Text(
            "Welcome!",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 60.0),
          Container(width: 100.0, child: Image.asset("assets/logo.png")),
          Text(
            "Student Utils",
            style: TextStyle(
                fontSize: 17,
                color: Colors.blue[900],
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 230.0),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _loadingView() {
    return Container(
      color: _isLoading ? Colors.black.withOpacity(0.70) : Colors.transparent,
      height: MediaQuery.of(context).size.height,
      width: _isLoading ? MediaQuery.of(context).size.width : 0.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            width: 50.0,
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : SizedBox.shrink(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              _loadingText,
              style: TextStyle(
                color: _isLoading ? Colors.white : Colors.transparent,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      margin: EdgeInsets.only(left: 45.0, right: 45.0),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.04, 0.38, 0.51, 0.66, 0.84, 0.95],
            colors: [
              Color.fromRGBO(10, 27, 68, 1),
              Color.fromRGBO(88, 86, 153, 1),
              Color.fromRGBO(142, 124, 191, 1),
              Color.fromRGBO(194, 149, 198, 1),
              Color.fromRGBO(243, 178, 193, 1),
              Color.fromRGBO(255, 215, 189, 1)
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                offset: Offset(-2.0, 2.0),
                blurRadius: 15.0)
          ],
          borderRadius: BorderRadius.circular(40.0)),
      child: FlatButton(
        splashColor: Colors.black,
        onPressed: () {
          setState(() {
            _isLoading = true;
          });
          signInWithGoogle().then((isLoggedIn) async {
            if (isLoggedIn) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) {
                    return LoginSuccessScreen();
                  },
                ),
                (Route<dynamic> route) => false,
              );
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Container(
                  height: 30.0,
                  width: 30.0,
                  child: Image.asset("assets/G.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  "Log In",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
