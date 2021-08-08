import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailPage extends StatefulWidget {
  String docId,colname;
  DetailPage({required this.docId,required this.colname});
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future:FirebaseFirestore.instance.collection("${widget.colname}"+"-record").doc(widget.docId).get(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            String _name,_specialitem;
            int _foodrate,_hygienerate;
            if(widget.colname=='caterer'){
              _name = snapshot.data!.get('name');
              _foodrate = snapshot.data!.get('foodrate');
              _hygienerate = snapshot.data!.get('hygienerate');
              _specialitem = snapshot.data!.get('specialitem');
              return Scaffold(
              body: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$_name"),
                    SizedBox(height:20.0),
                    Text("$_foodrate"),
                    SizedBox(height:20.0),
                    Text("$_hygienerate"),
                    SizedBox(height:20.0),
                    Text("$_specialitem"),
                  ],
                ),
              ),
            );
            }else{
              _name = snapshot.data!.get('name');
              _hygienerate = snapshot.data!.get('hygienerate');
              return Scaffold(
              body: SingleChildScrollView(
                child:Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("$_name"),
                    SizedBox(height:20.0),
                    Text("$_hygienerate"),
                  ],
                ),
              ),
            );
            }
          }
        },
      );
  }
}