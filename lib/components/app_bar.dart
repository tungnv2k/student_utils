import 'package:flutter/material.dart';

Widget buildTopBar(
    {String title,
    IconData leftIcon,
    IconData rightIcon,
    Color color = Colors.black,
    Color titleColor = Colors.white,
    Function onTitleTap,
    Function onLeftTap,
    Function onRightTap}) {
  return PreferredSize(
    child: SafeArea(
      child: Container(
        color: color,
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(leftIcon, color: Colors.white, size: 20),
                  splashColor: Colors.white,
                  onPressed: onLeftTap,
                )),
            Expanded(
              child: GestureDetector(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: titleColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                onTap: onTitleTap,
              ),
            ),
            Container(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(rightIcon,
                      color: Colors.white, size: 20),
                  splashColor: Colors.white,
                  onPressed: onRightTap,
                )),
          ],
        ),
      ),
    ),
    preferredSize: Size(double.infinity, 60.0),
  );
}
