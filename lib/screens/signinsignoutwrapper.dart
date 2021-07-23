import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:listing/screens/listpage.dart';
import 'package:listing/screens/loginpage.dart';

class SignInSignOutWrapper extends StatefulWidget {
  @override
  _SignInSignOutWrapperState createState() => _SignInSignOutWrapperState();
}

class _SignInSignOutWrapperState extends State<SignInSignOutWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return LoginPage();
        }else{
          return ListPage();
        }
      }
    );
  }
}