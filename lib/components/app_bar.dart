import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget buildTopBar(String title) {
  return Container(
    color: Colors.black,
    padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            width: 30.0,
            child: Icon(EvaIcons.menu, color: Colors.white, size: 30)),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        Container(
            width: 30.0,
            child: Icon(EvaIcons.moreVertical, color: Colors.white, size: 20)),
      ],
    ),
  );
}

Widget buildSubTopBar(String title, BuildContext context) {
  return Container(
    color: Colors.black,
    padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          child: Container(
              width: 30.0,
              child: Icon(EvaIcons.arrowBack, color: Colors.white, size: 25)),
          onTap: () => Navigator.of(context).pop(),
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w600),
        ),
        Container(
            width: 30.0,
            child: Icon(EvaIcons.moreVertical, color: Colors.white, size: 20)),
      ],
    ),
  );
}
