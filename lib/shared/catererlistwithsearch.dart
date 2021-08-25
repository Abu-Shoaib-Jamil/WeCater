import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatererListWithSearch extends StatefulWidget {
  final String searchvalue;
  CatererListWithSearch({required this.searchvalue});
  @override
  _CatererListWithSearchState createState() => _CatererListWithSearchState();
}

class _CatererListWithSearchState extends State<CatererListWithSearch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('caterer-record')
            .where('searchcases', arrayContains: widget.searchvalue)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                String _name = doc.get('name');
                var _avrate = doc.get('averagerate');
                String _address = doc.get('address');
                String _contact = doc.get('contact');
                String _docid = doc.id;
                return InkWell(
                  onTap: () async {
                    await FlutterClipboard.copy(_docid);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Copied to clipboard"),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Row(
                        children: [
                          Text(
                            _name,
                            style: TextStyle(
                                color: Colors.purple,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.content_copy),
                        ],
                      ),
                      subtitle: Text(
                          "DocID : $_docid\nAverage Rating : $_avrate\nAddress : $_address\nContact : $_contact"),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }
}
