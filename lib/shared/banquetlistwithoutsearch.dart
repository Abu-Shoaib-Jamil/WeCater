import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BanquetListWithoutSearch extends StatefulWidget {
  @override
  _BanquetListWithoutSearchState createState() => _BanquetListWithoutSearchState();
}

class _BanquetListWithoutSearchState extends State<BanquetListWithoutSearch> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('banquet-record').orderBy('hygienerate').snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child:CircularProgressIndicator());
        }else{
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String _name = doc.get('banquetname');
              var _hygienerate = doc.get('hygienerate');
              String _address  = doc.get('address');
              String _contact = doc.get('contact');
              String _docid = doc.id;
                return Card(
                  child: ListTile(
                    title: Text(_name,style: TextStyle(color:Colors.purple,fontWeight: FontWeight.bold),),
                    subtitle: Text("DocID : $_docid\nAverage Rating : $_hygienerate\nAddress : $_address\nContact : $_contact"),
                  ),
                );
              }).toList(),
          );
        }
      }
    );
  }
}