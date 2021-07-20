import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Authentication{
  FirebaseAuth _auth = FirebaseAuth.instance;

  //SignUp
  Future loginUsingEmailPass({required String email,required String password})async{
    try{
      UserCredential _credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? _user = _credential.user;
      String _uid = _user!.uid;
      return _uid;
    }on FirebaseAuthException catch(e){
      print(e.code);
      print(e.message);
      return e.code;
    }
  }

  //Login
  Future signUpUsingEmailPass({required String email,required String password})async{
    try{
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? _user = _credential.user;
      String _uid = _user!.uid;
      return _uid;
    }catch(e){
      if(e is PlatformException){
        if(e.code=='ERROR_EMAIL_ALREADY_IN_USE'){
          return "User already exit.Please Login to continue";
        }
      }else{
        return null;
      }
    }
  }

  //Logout
  Future logout()async{
    try{
      await _auth.signOut();
    }catch(e){
      return e;
    }
  }

  //Password Reset
  Future passwordReset({required String email})async{
    try{
      print(email);
      await _auth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      print(e.code);
      return e.code;
    }
  }
}