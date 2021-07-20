import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatererList extends StatefulWidget {
  @override
  _CatererListState createState() => _CatererListState();
}

class _CatererListState extends State<CatererList> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('caterer-record').orderBy('averagerate').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child:CircularProgressIndicator());
        }else{
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String _name = doc.get('caterername');
              int _averagerate = doc.get('averagerate');
                return Card(
                  child: ListTile(
                    title: Text(_name),
                    subtitle: Text('$_averagerate'),
                  ),
                );
              }).toList(),
          );
        }
      }
    );
  }
}
