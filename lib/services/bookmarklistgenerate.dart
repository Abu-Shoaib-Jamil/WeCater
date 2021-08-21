import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BookmarkListGenerate extends StatefulWidget {
  String colname;
  BookmarkListGenerate({required this.colname});
  @override
  _BookmarkListGenerateState createState() => _BookmarkListGenerateState();
}

class _BookmarkListGenerateState extends State<BookmarkListGenerate> {
  Future getCatererData(String uid) async {
    DocumentSnapshot _info = await FirebaseFirestore.instance
        .collection("caterer-record")
        .doc(uid)
        .get();
    return _info;
  }

  Future getBanquetData(String uid) async {
    DocumentSnapshot _info = await FirebaseFirestore.instance
        .collection("banquet-record")
        .doc(uid)
        .get();
    return _info;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection("user-record")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          List data = snapshot.data!.get('bookmarks');
          if (data.isEmpty) {
            return Center(
              child: Text("No bookmarks found"),
            );
          } else {
            if (widget.colname == "caterer") {
              data.forEach(
                (uid) async {
                  DocumentSnapshot info = await getBanquetData(uid);
                  String _name = info.get('name');
                  double _avrate = info.get('averagerate');
                  String _serve = info.get('serve');
                  print(_name);
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("asset/caterer.jpg"),
                      radius: 25.0,
                    ),
                    title: Text(
                      "$_name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    subtitle: Text("$_serve"),
                    trailing: Wrap(
                      spacing: 5.0,
                      children: [
                        Text(
                          "$_avrate",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(
                          Icons.stars,
                          color: Colors.amberAccent,
                          size: 18.0,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (widget.colname == "banquet") {
              data.forEach(
                (uid) async {
                  DocumentSnapshot info = await getBanquetData(uid);
                  String _name = info.get('name');
                  double _avrate = info.get('averagerate');
                  print(_name);
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("asset/banquet.jpg"),
                      radius: 25.0,
                    ),
                    title: Text(
                      "$_name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    trailing: Wrap(
                      spacing: 5.0,
                      children: [
                        Text(
                          "$_avrate",
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Icon(
                          Icons.stars,
                          color: Colors.amberAccent,
                          size: 18.0,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return Container();
          }
        }
      },
    );
  }
}
