import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wecater/screens/homepage.dart';
import 'package:wecater/screens/loginpage.dart';

class SignInSignOutWrapper extends StatefulWidget {
  @override
  _SignInSignOutWrapperState createState() => _SignInSignOutWrapperState();
}

class _SignInSignOutWrapperState extends State<SignInSignOutWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return LoginPage();
        }else{
          return Homepage();
        }
      },
    );
  }
}