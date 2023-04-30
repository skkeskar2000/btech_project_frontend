import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewCustomFormDialogue extends StatelessWidget {
  final List<String> customFormQuestionList;

  const ViewCustomFormDialogue({Key? key, required this.customFormQuestionList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        scrollDirection: Axis.vertical ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                'Form Questions',
                style: kHeadingTextStyle,
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 500,
              width: 600,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: customFormQuestionList.length - 2,
                  itemBuilder: (context, index) {
                    return Text('${index + 1}.${customFormQuestionList[index]}');
                  }),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconTextButton(
            icon: Icon(
              CupertinoIcons.multiply_circle_fill,
              color: Colors.white,
            ),
            title: 'Close',
            isSelected: false,
          ),
        )
      ],
    );
  }
}
