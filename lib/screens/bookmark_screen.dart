import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  @override
  State createState() => BookmarkScreenState();
}

class BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Bookmarks"))),
      body: Container(
        padding: EdgeInsets.all(8.0),
        color: Color.fromRGBO(238, 238, 238, 1.0),
        child: Column(
          children: <Widget>[
            _buildBookmark("SE 2020", "http://link.to.se.excel"),
            _buildBookmark("OS 2020", "https://link.to.check.attendance"),
            _buildBookmark("OOP BI9-229", "http://google.drive.oop.com"),
          ],
        ),
      ),
    );
  }

  Widget _buildBookmark(String name, String link) {
    return Container(
        padding: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
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
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            link,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
        ));
  }
}
