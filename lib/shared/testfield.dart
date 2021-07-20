import 'package:flutter/material.dart';

const inputfield = InputDecoration(
  labelStyle: TextStyle(color:Colors.grey),
  filled: true,
  fillColor: Colors.white,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.grey,width:2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.black,width:2.0),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color:Colors.red,width:2.0),
  ),
);