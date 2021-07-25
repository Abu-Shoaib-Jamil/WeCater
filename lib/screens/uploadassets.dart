import 'package:flutter/material.dart';

class UploadAsset extends StatefulWidget {
  @override
  _UploadAssetState createState() => _UploadAssetState();
}

class _UploadAssetState extends State<UploadAsset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child:Wrap(
                  runAlignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  direction: Axis.horizontal,
                  spacing:20.0,
                  children: [
                    CircleAvatar(backgroundColor: Colors.purple[900],backgroundImage:AssetImage("asset/logo.png"),radius:35.0),
                    Text("WeCater",style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,)
                    ,),
                  ],
              ),
            ),
            Expanded(
              flex: 2,
              //Add section to pickup image and video from gallery and on pressed upload them in cloud storage
              //and store its downloadurl in firestore.
              child: Text("Add image_picker plugin"),
            ),
          ],
        ),
      ),
    );
  }
}