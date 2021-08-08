import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wecater/screens/detailpage.dart';
import 'package:geolocator/geolocator.dart';

class GenerateList extends StatefulWidget {
  String? colname,serve;
  double userlat,userlong;
  GenerateList({required this.serve,required this.colname,required this.userlat,required this.userlong});
  @override
  _GenerateListState createState() => _GenerateListState();
}

class _GenerateListState extends State<GenerateList> {
  var _distance = 0;
  Future getDistance(String address)async{
    List<Location> _loc = await locationFromAddress(address);
    var _dist =Geolocator.distanceBetween(widget.userlat, widget.userlong, _loc.first.latitude, _loc.first.longitude);
    setState(() {
      _distance = _dist as int;
    });
  }
  @override
  Widget build(BuildContext context) {
      return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('${widget.colname}'+'-record').orderBy('averagerate',descending: true).where('serve',isEqualTo:widget.serve).get(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(child:CircularProgressIndicator(),);
        }else{
          return ListView(
            children: snapshot.data!.docs.map((doc){
              String _name = doc.get('name');
              double _avrate = doc.get('averagerate');
              String _cataddress = doc.get('address');
              getDistance(_cataddress);
              String _docid = doc.id;
              if( (widget.userlat==0 && widget.userlong==0) || ( (widget.userlat!=0&&widget.userlong!=0) && (_distance<=10000) ) ){
                return InkWell(
                  onTap: ()async{
                    Navigator.push(context, MaterialPageRoute(builder:(context)=>DetailPage(docId: _docid, colname: widget.colname.toString()),),);
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Image Section
                          Expanded(
                            flex: 2,
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                image:DecorationImage(
                                  image: NetworkImage("https://content3.jdmagicbox.com/def_content/caterers/default-caterers-7.jpg?clr=47331f"),
                                  fit: BoxFit.fill,
                                  repeat: ImageRepeat.noRepeat,
                                  ),
                              ),
                            ),
                          ),
                          //Detail section
                          Expanded(
                            flex: 4,
                            child: Wrap(
                              direction: Axis.vertical,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              spacing: 10.0,
                              children: [
                                Text("$_name",style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),),
                                Text("$_distance"),
                              ],
                            ),
                          ),
                          //Rating section
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Wrap(
                                  spacing: 5.0,
                                  children: [
                                    Text("$_avrate",style: TextStyle(fontSize:18.0),),
                                    Icon(Icons.stars,color:Colors.amberAccent,size: 18.0,),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
            }else{
              return Container();
            }
              }).toList(),
          );
        }
      }
    );
  }
}