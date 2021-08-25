import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clipboard/clipboard.dart';

class BanquetListWithSearch extends StatefulWidget {
  final String searchvalue;
  BanquetListWithSearch({required this.searchvalue});
  @override
  _BanquetListWithSearchState createState() => _BanquetListWithSearchState();
}

class _BanquetListWithSearchState extends State<BanquetListWithSearch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('banquet-record')
            .where('searchcases', arrayContains: widget.searchvalue)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                String _name = doc.get('name');
                var _hygienerate = doc.get('hygienerate');
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          "DocID : $_docid\nHygiene : $_hygienerate\nAddress : $_address\nContact : $_contact"),
                    ),
                  ),
                );
              }).toList(),
            );
          }
        });
  }
}
