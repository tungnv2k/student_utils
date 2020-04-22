import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:student_utils_app/components/app_bar.dart';
import 'package:student_utils_app/models/bookmark.dart';

class BookmarkScreen extends StatefulWidget {
  final Bookmark bookmark;

  BookmarkScreen({Key key, this.bookmark}) : super(key: key);

  @override
  State createState() => BookmarkScreenState();
}

class BookmarkScreenState extends State<BookmarkScreen> {
  TextEditingController _titleController;
  TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.bookmark.title);
    _linkController = TextEditingController(text: widget.bookmark.link);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTopBar(
          title: "Bookmark",
          leftIcon: EvaIcons.arrowBack,
          rightIcon: EvaIcons.moreVertical,
          onLeftTap: () {
            Navigator.pop(
              context,
              Bookmark(title: _titleController.text, link: _linkController.text),
            );
          }),
      body: Column(
        children: <Widget>[
          SizedBox(height: 100.0),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _titleController,
              maxLines: 1,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
              decoration: InputDecoration.collapsed(
                  hintText: "Enter title...",
                  hintStyle: TextStyle(color: Colors.black45)),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              controller: _linkController,
              maxLines: 1,
              style: TextStyle(fontSize: 15.0, color: Colors.grey[800]),
              decoration: InputDecoration.collapsed(
                  hintText: "Enter link...",
                  hintStyle: TextStyle(color: Colors.black38)),
            ),
          )
        ],
      ),
    );
  }
}
