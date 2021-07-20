import 'package:flutter/material.dart';

var inputdeco = InputDecoration(
  contentPadding: EdgeInsets.all(20.0),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderSide:BorderSide(
        color: Colors.grey,style:BorderStyle.solid
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide:BorderSide(
        color: Colors.black,style:BorderStyle.solid
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderSide:BorderSide(
        color: Colors.red,style:BorderStyle.solid
      ),
    ),
  );
