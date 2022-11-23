import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';


void flutterToast(String msg){
  showToast(
    msg,
    duration: Duration(seconds: 2),
    position: ToastPosition.bottom,
    backgroundColor: Colors.black.withOpacity(0.8),
    radius: 13.0,
    textStyle: TextStyle(fontSize: 18.0),
  );
}