import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatererListWithSearch extends StatefulWidget {
  String searchvalue;
  CatererListWithSearch({required this.searchvalue});
  @override
  _CatererListWithSearchState createState() => _CatererListWithSearchState();
}

class _CatererListWithSearchState extends State<CatererListWithSearch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('caterer-record').orderBy('averagerate').where('caterername',isEqualTo: widget.searchvalue).snapshots(),
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
                    title: Text(_name,style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold),),
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