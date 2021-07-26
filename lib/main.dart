import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listing/screens/listcaterer.dart';
import 'package:listing/screens/loginpage.dart';
import 'package:listing/screens/retrievepage.dart';
import 'package:listing/screens/signinsignoutwrapper.dart';
import 'package:listing/screens/uploadassets.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=>SignInSignOutWrapper(),
        '/listpage':(context)=>ListCaterer(),
        '/retrievepage':(context)=>RetrievePage(),
        '/loginpage':(context)=>LoginPage(),
        '/uploadasset':(context)=>UploadAsset(),
      },
    );
  }
}