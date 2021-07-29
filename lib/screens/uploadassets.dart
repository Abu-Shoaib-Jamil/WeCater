import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:listing/shared/testfield.dart';
// import 'package:video_player/video_player.dart';

class UploadAsset extends StatefulWidget {
  @override
  _UploadAssetState createState() => _UploadAssetState();
}

class _UploadAssetState extends State<UploadAsset> {
  // VideoPlayerController _controller;
  final _docIdKey = GlobalKey<FormFieldState>();
  late String docId;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  XFile? video;
  String _dropdownvalue = "caterer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //DropdownButton for Caterer and Banquet Selection
             DropdownButton(
              value: _dropdownvalue,
              items:<String>[
                      'caterer',
                      'banquet'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style:TextStyle(color:Colors.black),),
                      );
                    }).toList(),
              onChanged: (String? val){
                setState((){
                  _dropdownvalue = val.toString();
                });
              },
            ),
            //Enter Banquet/Caterer ID
            Expanded(
              flex:1,
              child: TextFormField(
                  key: _docIdKey,
                  decoration: inputfield.copyWith(hintText:"Id Number",suffixIcon: InkWell(onTap:()async{_docIdKey.currentState!.reset();setState((){docId="";});},child:Icon(Icons.cancel_outlined),),),
                  validator:(val)=>(val!.isEmpty)?"Enter field":null,
                  onChanged: (val){
                    setState((){
                      docId = val;
                    });
                  },
                ),
            ),
            //Photo and Video Upload section
            Expanded(
              flex: 4,
                child: Column(
                  children: [
                    //Photo Upload Section
                    Text("Select Image"),
                    SizedBox(height:20.0),
                    Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    spacing:5.0,
                    children: [
                      InkWell(
                        onTap: ()async{
                          final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
                          setState(() {
                            image=_image;
                          });
                        },
                        child: Container(
                          height:100,
                          width:100,
                          decoration: BoxDecoration(
                            border: Border.all(width:1.0,color:Colors.black,style:BorderStyle.solid),
                          ),
                          child: Icon(Icons.add_a_photo),
                        ),
                      ),
                      (image==null)?Container():imageBox(context,File(image!.path)),
                    ],
                  ),
                  //   SizedBox(height:50.0),
                  //   //Video Upload Section
                  //   Text("Select Video"),
                  //   SizedBox(height:20.0),
                  //   Wrap(
                  //   alignment: WrapAlignment.start,
                  //   runAlignment: WrapAlignment.start,
                  //   spacing:5.0,
                  //   children: [
                  //     InkWell(
                  //       onTap: ()async{
                  //         final XFile? _video = await _picker.pickVideo(source: ImageSource.gallery);
                  //         setState(() {
                  //           video=_video;
                  //         });
                          
                  //       },
                  //       child: Container(
                  //         height:100,
                  //         width:100,
                  //         decoration: BoxDecoration(
                  //           border: Border.all(width:1.0,color:Colors.black,style:BorderStyle.solid),
                  //         ),
                  //         child: Icon(Icons.add_a_photo),
                  //       ),
                  //     ),
                  //     (video==null)?Container():,
                  //   ],
                  // ),
                  ],
                ),
            ),
            //upload to cloud storage and save its link in firestore
            Expanded(
              flex: 1,
              child: Center(
                child:ElevatedButton(
                  onPressed: ()async{
                    File _file = File(image!.path);
                    try{
                      if(_docIdKey.currentState!.validate()){
                        String _filename = "${DateTime.now()}";
                        //Upload to Firbase cloud storage and set the downloadUrl to Firestore.
                        await FirebaseStorage.instance.ref("$docId/images/$_filename").putFile(_file).whenComplete(()async{
                          String _downloadUrl = await FirebaseStorage.instance.ref("$docId/images/$_filename").getDownloadURL();
                          //Upload its link to Firestore
                          await FirebaseFirestore.instance.collection("$_dropdownvalue-record").doc(docId).set({
                            'images':{'img-$_filename': '$_downloadUrl',},
                          },SetOptions(merge:true));
                          _docIdKey.currentState!.reset();
                          setState((){
                            image=null;
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploaded Successfully"),),);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter CatererID or BanquetID number"),),);
                      }
                    }on FirebaseException catch(e){
                      if(e.code=='unauthorized'){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ImageSize<=100KB / VideoSize<=2MB"),),);
                      }else if(e.code=='no-object'){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong location set.Check if the value is Banquet or Caterer"),),);
                      }
                      else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code),),);
                      }
                    }
                  },
                  child: Text("Upload"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget imageBox(BuildContext context,File file){
  return Container(
    height: 200,
    width: 200,
    child: Image.file(file),
  );
}

