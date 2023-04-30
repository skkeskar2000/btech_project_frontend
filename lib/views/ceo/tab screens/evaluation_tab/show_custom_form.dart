import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/tab%20screens/evaluation_tab/show_custom_forn_dialog.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/fill%20form/submit_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowCustomForms extends StatefulWidget {
  final bool isFilling;
  final String id;
  final String name;

  const ShowCustomForms(
      {Key? key, required this.isFilling, required this.id, required this.name})
      : super(key: key);

  @override
  State<ShowCustomForms> createState() => _ShowCustomFormsState();
}

class _ShowCustomFormsState extends State<ShowCustomForms> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return Container(
          child: Column(
            children: [
              provider.isFormListLoading
                  ? Container(
                      child: CircularProgressIndicator(),
                    )
                  : provider.customFormAttributeList.isEmpty
                      ? Container(
                          child: Center(
                            child: Text(
                              'No Forms Found !',
                              style: kHeadingTextStyle,
                            ),
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: provider.customFormAttributeList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(15),
                              margin: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.blueAccent.shade400,
                                        Colors.purpleAccent.shade400,
                                        Colors.pinkAccent.shade400
                                      ]),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Evaluation Form No ${index + 1}',
                                    style: kHeadingTextStyle.copyWith(
                                        color: Colors.white),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Questions : ${provider.customFormAttributeList[index].length - 2}',
                                        style: kWhiteContentStyle,
                                      ),
                                      widget.isFilling
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return SubmitForm(
                                                    questionList: provider
                                                            .customFormAttributeList[
                                                        index],
                                                    name: widget.name,
                                                    id: widget.id,
                                                  );
                                                }));
                                              },
                                              child: IconTextButton(
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 0,
                                                ),
                                                title: 'Fill Form',
                                                isSelected: false,
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return ViewCustomFormDialogue(
                                                        customFormQuestionList:
                                                            provider.customFormAttributeList[
                                                                index],
                                                      );
                                                    });
                                              },
                                              child: IconTextButton(
                                                icon: Icon(
                                                  Icons.view_headline_outlined,
                                                  color: Colors.white,
                                                ),
                                                title: 'View Form',
                                                isSelected: false,
                                              ),
                                            )
                                    ],
                                  )
                                ],
                              ),
                            );
                          })
            ],
          ),
        );
      },
    );
  }
}
