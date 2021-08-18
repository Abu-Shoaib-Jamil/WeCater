import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: MaterialButton(
        onPressed: () async {
          FirebaseCrashlytics.instance.crash();
        },
        child: Text("Crash"),
      )),
    );
  }
}
