import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wecater/screens/catererpage.dart';
import 'package:wecater/screens/loginpage.dart';
import 'package:wecater/screens/signinsignoutwrapper.dart';
import 'package:wecater/screens/signuppage.dart';
import 'package:wecater/screens/splashscreen.dart';

void main() async {
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
        '/': (context) => SplashScreen(),
        '/signinsignoutwrapper': (context) => SignInSignOutWrapper(),
        '/catererpage': (context) => CatererPage(),
        '/signuppage': (context) => SignUpPage(),
        '/loginpage': (context) => LoginPage(),
      },
    );
  }
}
