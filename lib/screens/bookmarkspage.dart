import 'package:flutter/material.dart';
import 'package:wecater/services/bookmarklistgenerate.dart';

// ignore: must_be_immutable
class BookmarksPage extends StatefulWidget {
  String colname;
  BookmarksPage({required this.colname});
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BookmarkListGenerate(
          colname: widget.colname,
        ),
      ),
    );
  }
}
