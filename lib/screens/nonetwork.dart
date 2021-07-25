import 'package:flutter/material.dart';

class NoNetwork extends StatefulWidget {
  @override
  _NoNetworkState createState() => _NoNetworkState();
}

class _NoNetworkState extends State<NoNetwork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:Text("No Internet Connection\nCheck Internet Connection and try again"),
        ),
      ),
    );
  }
}