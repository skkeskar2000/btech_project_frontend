import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/decorationConstants.dart';

Widget CustomDataCard(
    {required String frontTitle,
    required String frontData,
    required String frontSubtitle}) {
  return Card(
    color: Colors.white,
    child: Container(
      height: 150,
      width: 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(frontTitle),
          Text(
            frontData,
            style: kHeadingTextStyle,
          ),
          Text(
            frontSubtitle,
            style: kGreyText,
          )
        ],
      ),
    ),
  );
}
