import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/model/default_form_mode.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.formList,
    required this.index,
  });

  final List<DefaultQuestions> formList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Form Questions',
              style: kHeadingTextStyle,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              '1.${formList[index].que1}',
              style: kContentStyle,
            ),
            Text(
              '2.${formList[index].que2}',
              style: kContentStyle,
            ),
            Text(
              '3.${formList[index].que3}',
              style: kContentStyle,
            ),
            Text(
              '4.${formList[index].que4}',
              style: kContentStyle,
            ),
            Text(
              '5.${formList[index].que5}',
              style: kContentStyle,
            ),
            Text(
              '6.${formList[index].que6}',
              style: kContentStyle,
            ),
            Text(
              '7.${formList[index].que7}',
              style: kContentStyle,
            ),
            Text(
              '8.${formList[index].que8}',
              style: kContentStyle,
            ),
            Text(
              '9.${formList[index].que9}',
              style: kContentStyle,
            ),
            Text(
              '10.${formList[index].que10}',
              style: kContentStyle,
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: IconTextButton(
              icon: Icon(
                CupertinoIcons.multiply_circle_fill,
                color: Colors.white,
              ),
              title: 'CLOSE',
              isSelected: false),
        )
      ],
    );
  }
}
