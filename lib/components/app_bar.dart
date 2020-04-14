import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

Widget buildTopBar(String title,
    {Color color = Colors.black, Color titleColor = Colors.white}) {
  return Container(
    color: color,
    height: 60.0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 15.0),
            alignment: Alignment.centerLeft,
            child: Icon(EvaIcons.menu, color: Colors.white, size: 25)),
        Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: titleColor, fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
            padding: EdgeInsets.only(right: 15.0),
            alignment: Alignment.centerRight,
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
              child: Icon(EvaIcons.arrowBack, color: Colors.white, size: 20)),
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
