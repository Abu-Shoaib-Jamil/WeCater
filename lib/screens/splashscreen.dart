import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    timer();
  }
  void timer()async{
    Timer(Duration(seconds:2),()async{await Navigator.popAndPushNamed(context, '/signinsignoutwrapper');},);
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height/3;
    double width  = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: height,
            width:width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("asset/logo.png"),
                ),
              ),
            ),
            SizedBox(height: 30.0,),
          Text("WeCater",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28.0),),
        ],
      ),
    );
  }
}