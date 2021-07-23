import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  FirebaseAuth _auth = FirebaseAuth.instance;

  //Login
  Future login({required String email,required String password})async{
    try{
      UserCredential? _credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? _user = _credential.user;
      return _user!.uid;
    }on FirebaseAuthException catch(e){
      return e.code;
    }
  }

  //Logout
  Future logout()async{
    try{
      await _auth.signOut();
    }on FirebaseAuthException catch(e){
      return e.code;
    }
  }
}