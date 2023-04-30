import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/material.dart';

class HeadingFillForm extends StatelessWidget {
  const HeadingFillForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 250,
      decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/pinkQuestionbg.jpg'),
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Text(
              'Submit Your Response',
              style: kHeadingTextStyle,
            ),
          ),
          InkWell(
            child: IconTextButton(
              icon: Icon(
                Icons.question_mark_outlined,
                color: Colors.white,
                size: 0,
              ),
              title: '     See How It Works ?',
              isSelected: true,
            ),
          )
        ],
      ),
    );
  }
}
