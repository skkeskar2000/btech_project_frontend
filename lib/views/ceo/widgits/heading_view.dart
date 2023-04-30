import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/material.dart';

class HeadingView extends StatelessWidget {
  const HeadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 250,

      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/questionbg.jpg'),
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              'Ask Your People',
              style: kTopTitleTextStyle,
            ),
          ),
          InkWell(
            child: IconTextButton(
              icon: Icon(
                Icons.question_mark_outlined,
                color: Colors.white,
                size: 25,
              ),
              title: 'See How It Works ?',
              isSelected: true,
            ),
          )
        ],
      ),
    );
  }
}
