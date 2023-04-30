import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:flutter/material.dart';

class BoardType extends StatelessWidget {
  final String title;

  const BoardType({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
      margin: EdgeInsets.symmetric(vertical: 25),
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient:  LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purpleAccent, Colors.pinkAccent])
      ),
      child: Text(
        title,
        style: kHeadingTextStyle.copyWith(color: Colors.white),
      ),
    );
  }
}
