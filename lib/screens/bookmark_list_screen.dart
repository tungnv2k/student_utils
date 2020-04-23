import 'package:flutter/material.dart';
import 'package:student_utils_app/models/bookmark.dart';
import 'package:student_utils_app/screens/bookmark_screen.dart';
import 'package:student_utils_app/storage/bookmark_storage.dart';

class BookmarkListScreen extends StatefulWidget {
  const BookmarkListScreen({Key key}) : super(key: key);

  @override
  State createState() => BookmarkListScreenState();
}

class BookmarkListScreenState extends State<BookmarkListScreen> {
  List<Bookmark> bookmarkList;

  @override
  Widget build(BuildContext context) {
    bookmarkList = BookmarkStorage.of(context).bookmarks;
    return Scaffold(
      body: Column(
        children: List.generate(bookmarkList.length, (index) {
          return _buildBookmark(
              index: index,
              title: bookmarkList[index].title,
              link: bookmarkList[index].link);
        }),
      ),
    );
  }

  Widget _buildBookmark({@required int index, String title, String link}) {
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
        _awaitBookmarkUpdate(context, index, title, link);
      },
    );
  }

  void _awaitBookmarkUpdate(BuildContext context, int index, String title, String link) async {
    Bookmark currentBookmark = Bookmark(title: title, link: link);
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookmarkScreen(bookmark: currentBookmark),
        ));

    setState(() {
      if (result != null && result != currentBookmark) {
        BookmarkStorage.of(context).bookmarks[index] = result;
      }
    });
  }
}
