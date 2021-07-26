import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:listing/shared/testfield.dart';

class UploadAsset extends StatefulWidget {
  @override
  _UploadAssetState createState() => _UploadAssetState();
}

class _UploadAssetState extends State<UploadAsset> {
  final _docIdKey = GlobalKey<FormFieldState>();
  late String docId;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //Enter Banquet/Caterer ID
            Expanded(
              flex:1,
              child: TextFormField(
                  key: _docIdKey,
                  decoration: inputfield.copyWith(hintText:"Caterer/Banquet Id Number",suffixIcon: InkWell(onTap:()async{_docIdKey.currentState!.reset();setState((){docId="";});},child:Icon(Icons.cancel_outlined),),),
                  onChanged: (val){
                    setState((){
                      docId = val;
                    });
                  },
                ),
            ),
            //Single photo upload
            Expanded(
              flex: 4,
                child: Wrap(
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
            ),
            //upload to cloud storage and save its link in firestore
            Expanded(
              flex: 1,
              child: Center(
                child:ElevatedButton(
                  onPressed: ()async{
                    File _file = File(image!.path);
                    String _filepath = image!.path;
                    print(_filepath);
                    try{
                      await FirebaseStorage.instance.ref(docId).putFile(_file).whenComplete(() {_docIdKey.currentState!.reset();setState((){image=null;});});
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploaded Successfully"),),);
                    }on FirebaseException catch(e){
                      print(e.code);
                      print(e.message);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code),),);
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

Widget imageBox(BuildContext context,File image){
  return Container(
    height: 200,
    width: 200,
    child: Image.file(image),
  );
}