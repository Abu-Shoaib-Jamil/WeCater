import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:listing/screens/listpage.dart';
import 'package:listing/screens/loginpage.dart';
import 'package:listing/screens/retrievepage.dart';
import 'package:listing/screens/signinsignoutwrapper.dart';

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
        '/listpage':(context)=>ListPage(),
        '/retrievepage':(context)=>RetrievePage(),
        '/loginpage':(context)=>LoginPage(),
      },
    );
  }
}