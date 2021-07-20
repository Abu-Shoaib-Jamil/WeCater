import 'package:flutter/material.dart';
import 'package:listing/shared/testfield.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final _listKey = GlobalKey<FormState>();
  late String _catname,_serve,_streetno,_streetname,_district,_pincode,_state="West Bengal",_specialitem;
  late int _contact,_foodrate=2,_hygienerate=2,_averagerate=((_foodrate+_hygienerate)/2) as int;
  Future _uploadData()async{
    var _uid = Uuid().v1();
    await FirebaseFirestore.instance.collection('caterer-record').doc(_uid).set({
        'caterername' : _catname,
        'serve' : _serve,
        'streetnumber' : _streetno,
        'streetname' : _streetname,
        'district' : _district,
        'pincode' : _pincode,
        'state' : _state,
        'specialitem' : _specialitem,
        'contact'  :_contact,
        'foodrate' : _foodrate,
        'hygienerate' : _hygienerate,
        'averagerage' : _averagerate,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //WeCater Logo
            Expanded(
              flex: 1,
              child:Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  spacing:20.0,
                  children: [
                    CircleAvatar(backgroundColor: Colors.purple[900],backgroundImage:AssetImage("asset/logo.png"),radius:50.0),
                    Text("WeCater",style: TextStyle(fontSize: 28.0,fontWeight: FontWeight.bold,)
                    ,),
                  ],
              ),
            ),
            //Listing Form
            Expanded(
              flex:4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _listKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      //Caterer Name
                      TextFormField(
                        decoration: inputfield.copyWith(labelText:"Caterer Name"),
                        validator: (val){
                          if(val!.isEmpty){
                            return "Enter Caterer Name";
                          }else{
                            return null;
                          }
                        },
                        onChanged: (val){
                          setState((){
                            _catname = val;
                          });
                        },
                      ),
                      SizedBox(height: 15.0,),
                      //Serve
                      Wrap(
                        children: [
                          TextFormField(
                            decoration: inputfield.copyWith(labelText:"Serve"),
                            validator: (val){
                              if(val!.isEmpty){
                                return "Enter Serve";
                              }else if(val.length<3 || val.length>5){
                                return "Enter veg/nonveg/both";
                              }else{
                                return null;
                              }
                            },
                            onChanged: (val){
                              setState((){
                                _serve = val;
                              });
                            },
                          ),
                          SizedBox(width: 5.0,),
                          //Street Number
                          TextFormField(
                            decoration: inputfield.copyWith(labelText:"Street No"),
                            onChanged: (val){
                              setState((){
                                _streetno = val;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      //Street Name
                      TextFormField(
                        decoration: inputfield.copyWith(labelText:"Street Name"),
                        validator: (val)=>(val!.isEmpty)?"Enter Street Name":null,
                        onChanged: (val){
                          setState((){
                            _streetname = val;
                          });
                        },
                      ),
                      SizedBox(height: 15.0,),
                      //District
                      Wrap(
                        children: [
                          TextFormField(
                            decoration: inputfield.copyWith(labelText:"District"),
                            validator: (val)=>(val!.isEmpty)?"Enter District":null,
                            onChanged: (val){
                              setState((){
                                _district = val;
                              });
                            },
                          ),
                          SizedBox(width: 5.0,),
                          //Pincode
                          TextFormField(
                            decoration: inputfield.copyWith(labelText:"Pincode"),
                            validator: (val)=>(val!.isEmpty)?"Enter Pincode":null,
                            onChanged: (val){
                              setState((){
                                _pincode = val;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 15.0,),
                      //State
                      TextFormField(
                        decoration: inputfield.copyWith(labelText:"State(West Bengal by default)"),
                        validator: (val)=>(val!.isEmpty)?"Enter State":null,
                      ),
                      SizedBox(height: 15.0,),
                      //Contact
                      TextFormField(
                        decoration: inputfield.copyWith(labelText:"Contact"),
                        validator: (val)=>(val!.isEmpty)?"Enter contact number":null,
                        onChanged: (val){
                          setState((){
                            _contact = val as int;
                          });
                        },
                      ),
                      SizedBox(height: 15.0,),
                      //Special Item
                      TextFormField(
                        decoration: inputfield.copyWith(labelText:"Special Item"),
                        onChanged: (val){
                          setState((){
                            _specialitem = val;
                          });
                        },
                      ),
                      SizedBox(height: 15.0,),
                    ]
                  ),
                ),
              ),
            ),
            //Upload and Retrieve Button
            Expanded(
              flex: 1,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Upload Data
                  TextButton(
                    onPressed: ()async{
                      //Firestore upload and show snackbar once done or error while uploading
                      await _uploadData();
                    },
                    child: Text("Upload"),
                  ),
                  //Retrieve
                  TextButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/retrievepage');
                    },
                    child: Text("Retrieve"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}