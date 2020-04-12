import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_utils_app/components/app_bar.dart';
import 'package:student_utils_app/models/bookmark.dart';
import 'package:student_utils_app/screens/bookmark_screen.dart';

class BookmarkListScreen extends StatefulWidget {
  @override
  State createState() => BookmarkListScreenState();
}

class BookmarkListScreenState extends State<BookmarkListScreen> {
  List<Bookmark> bookmarkList = <Bookmark>[
    Bookmark(title: "SE 2020", link: "http://link.to.se.excel"),
    Bookmark(title: "OS 2020", link: "https://link.to.check.attendance"),
    Bookmark(
        title:
            "OOP BI99999999999999999999999999999999999999999999999999999999999999999999999999999999999",
        link:
            "http://google.drive.oop.commmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: buildTopBar("Bookmark")),
          Column(
            children: List.generate(bookmarkList.length, (index) {
              return _buildBookmark(
                  bookmarkList[index].title, bookmarkList[index].link);
            }),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return BookmarkScreen(
                bookmark: Bookmark(title: null, link: null),
              );
            }));
          },
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

  Widget _buildBookmark(String title, String link) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
              child: CircleAvatar(
                child: Icon(Icons.event),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                  ),
                  Text(
                    link,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookmarkScreen(
                    bookmark: Bookmark(title: title, link: link),
                  )),
        );
      },
    );
  }
}
