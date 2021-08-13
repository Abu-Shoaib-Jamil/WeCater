import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String docId, colname;
  DetailPage({required this.docId, required this.colname});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection("${widget.colname}" + "-record")
          .doc(widget.docId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (widget.colname == 'caterer') {
            String _name = snapshot.data!.get('name');
            int _foodrate = snapshot.data!.get('foodrate');
            int _hygienerate = snapshot.data!.get('hygienerate');
            String _specialitem = snapshot.data!.get('specialitem');
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$_name"),
                      SizedBox(height: 20.0),
                      Text("$_foodrate"),
                      SizedBox(height: 20.0),
                      Text("$_hygienerate"),
                      SizedBox(height: 20.0),
                      Text("$_specialitem"),
                    ],
                  ),
                ),
              ),
            );
          } else {
            String _name = snapshot.data!.get('name');
            int _averagerate = snapshot.data!.get('averagerate');
            return Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("$_name"),
                      SizedBox(height: 20.0),
                      Text("$_averagerate"),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}
