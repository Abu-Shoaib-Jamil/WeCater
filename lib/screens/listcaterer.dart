import 'package:flutter/material.dart';
import 'package:listing/shared/testfield.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListCaterer extends StatefulWidget {
  @override
  _ListCatererState createState() => _ListCatererState();
}

class _ListCatererState extends State<ListCaterer> {
  final _listKey = GlobalKey<FormState>();
  late String _catname,_serve,_streetno,_streetname,_district,_pincode,_state,_specialitem,_contact;
  late int _foodrate,_hygienerate;
  Future _uploadData()async{
    try{
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
          'averagerate' : (_foodrate+_hygienerate)/2,
          'address' : _streetno + ", " + _streetname + ", " + _district + "-" + _pincode + ", " + _state,
      });
      return 'success';
    }catch(e){
      return e;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment:MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Listing Form
            Expanded(
              flex:4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
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
                        //Serve and Street number
                        Row(
                          children: [
                            Expanded(
                                flex:1,
                                //Serve
                                child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"Serve(veg/nonveg/both)"),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Enter Serve";
                                  }else if(val.length<3 || val.length>6){
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
                            ),
                            SizedBox(width: 5.0,),
                            //Street Number
                            Expanded(
                                flex:1,
                                child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"Street No"),
                                onChanged: (val){
                                  setState((){
                                    _streetno = val;
                                  });
                                },
                              ),
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
                        //District and Pincode
                        Row(
                          children: [
                            //District
                            Expanded(
                                flex:1,
                                child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"District"),
                                validator: (val)=>(val!.isEmpty)?"Enter District":null,
                                onChanged: (val){
                                  setState((){
                                    _district = val;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            //Pincode
                            Expanded(
                                flex:1,
                                child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"Pincode"),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Enter pincode";
                                  }else if(val.length!=6){
                                    return "Pincode must be of length 6";
                                  }else{
                                    return null;
                                  }
                                },
                                onChanged: (val){
                                  setState((){
                                    _pincode = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.0,),
                        //State
                        TextFormField(
                          decoration: inputfield.copyWith(labelText:"State"),
                          validator: (val)=>(val!.isEmpty)?"Enter State":null,
                          onChanged: (val){
                            setState((){
                              _state = val;
                            });
                          },
                        ),
                        SizedBox(height: 15.0,),
                        //Contact
                        TextFormField(
                          decoration: inputfield.copyWith(labelText:"Contact"),
                          validator: (val){
                            if(val!.isEmpty){
                              return "Enter Contact";
                            }else if(val.length!=10){
                              return "Wrong Contact";
                            }else{
                              return null;
                            }
                          },
                          onChanged: (val){
                            setState((){
                              _contact = val;
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
                        //FoodRating and HygieneRating
                        Row(
                          children: [
                            //Food Quality Rating
                            Expanded(
                              flex:1,
                              child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"Food Quality Rating(>=0 & <5)"),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Enter Food Quality Rating";
                                  }else if(int.parse(val)>6 && int.parse(val)<0){
                                    return "0 <= Rating <= 5";
                                  }else{
                                    return null;
                                  }
                                },
                                onChanged:(val){
                                  setState((){
                                    _foodrate = int.parse(val);
                                  });
                                }
                              ),
                            ),
                            SizedBox(width: 5.0,),
                            //Hygiene Rating
                            Expanded(
                              flex:1,
                              child: TextFormField(
                                decoration: inputfield.copyWith(labelText:"Hygiene Rating(>=0 & <5)"),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Enter Hygiene Rating";
                                  }else if(int.parse(val)>6 && int.parse(val)<0){
                                    return "0 <= Rating <= 5";
                                  }else{
                                    return null;
                                  }
                                },
                                onChanged:(val){
                                  setState((){
                                    _hygienerate = int.parse(val);
                                  });
                                }
                              ),
                            ),
                          ],
                        ),
                      ]
                    ),
                  ),
                ),
              ),
            ),
            //Upload Button
            Expanded(
              flex: 1,
              child:Center(
                child:ElevatedButton(
                    onPressed: ()async{
                      //Firestore upload and show snackbar once done or error while uploading
                      if(_listKey.currentState!.validate()){
                        var _result = await _uploadData();
                        if(_result=='success'){
                           _listKey.currentState!.reset();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green,content:Text("Successfully Uploaded",style: TextStyle(color:Colors.white),),),);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red,content:Text("$_result",style: TextStyle(color:Colors.white),),),);
                        }
                      }
                    },
                    child: Text("Upload"),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}