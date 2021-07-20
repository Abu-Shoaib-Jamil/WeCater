import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 1.0,
      backgroundColor: Colors.white,
      child: AlertDialog(
      content:CircularProgressIndicator(
        backgroundColor: Colors.grey,
        color: Colors.black,
        ),
      ),
    );
  }
}