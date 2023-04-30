import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:flutter/material.dart';

import 'flipCard.dart';
class CustomFlipCard extends StatelessWidget {
  final String frontTitle;
  final String frontData;
  final String frontSubtitle;
  final String backText;
  final Color color;

  const CustomFlipCard(
      {Key? key,
        required this.frontData,
        required this.backText,
        required this.frontTitle,
        required this.frontSubtitle, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlipCard(

        front: Card(
          color: Colors.white,
          child: Container(
            height: 250,
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
        ),
        back: Card(
          color: color,
          child: Container(
            padding: EdgeInsets.all(20),
            height: 250,
            width: 190,
            child: Text(
              backText,
              style: kWhiteContentStyle,
            ),
          ),
        ));
  }
}