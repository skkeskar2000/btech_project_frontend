import 'dart:ui';
import 'package:flutter/material.dart';

const kHeadingTextStyle =
    TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold);

const kContentStyle =
    TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);

const kWhiteContentStyle =
TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);

const kGreyText = TextStyle(
  color: Colors.grey,
  fontSize: 14,
);

const kTopTitleTextStyle =
TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500);

InputDecoration CustomInputDecoration(
    {required String label, required String hint, required Icon icon}) {
  return InputDecoration(
    //decoration of input
      prefixIcon: icon,
      focusedBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      enabledBorder:
      OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      hintText: hint,
      labelText: label,
      labelStyle: kContentStyle);
}