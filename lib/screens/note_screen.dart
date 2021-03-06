import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show LengthLimitingTextInputFormatter;
import 'package:student_utils_app/components/app_bar.dart';
import 'package:student_utils_app/models/note.dart';

class NoteScreen extends StatefulWidget {
  final Note note;

  NoteScreen({Key key, this.note}) : super(key: key);

  @override
  State createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  ScrollController _scrollController;
  TextEditingController _titleTextController;
  TextEditingController _textController;
  String title;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 7);
    _titleTextController = TextEditingController(text: widget.note.title);
    _textController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleTextController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildTopBar(
          title: title = widget.note.title,
          leftIcon: EvaIcons.arrowBack,
          rightIcon: EvaIcons.moreVertical,
          onLeftTap: () {
            Navigator.pop(
              context,
              Note(title: _titleTextController.text, description: _textController.text),
            );
          }),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: <Widget>[
              SizedBox(height: 60.0),
              Container(
                color: Colors.amberAccent,
                margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 0.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleTextController,
                      inputFormatters: [LengthLimitingTextInputFormatter(15)],
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black.withOpacity(0.80)),
                      decoration: InputDecoration.collapsed(
                        hintText: "Give this note a title...",
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                    Divider(height: 5.0),
                    SizedBox(height: 10.0),
                    TextField(
                      controller: _textController,
                      maxLines: null,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.80)),
                      decoration: InputDecoration.collapsed(
                        hintText: "Write something...",
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                    SizedBox(height: 200.0)
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height)
            ],
          ),
        ),
      ),
    );
  }
}
