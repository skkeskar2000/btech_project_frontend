import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/model/default_form_mode.dart';
import 'package:major_project_fronted/views/ceo/tab%20screens/evaluation_tab/show_custom_form.dart';
import 'package:major_project_fronted/views/ceo/widgits/heading_view.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_custom_form.dart';
import 'default_form_question_diglogue.dart';

class EvaluationTab extends StatefulWidget {
  const EvaluationTab({Key? key}) : super(key: key);

  @override
  State<EvaluationTab> createState() => _EvaluationTabState();
}

class _EvaluationTabState extends State<EvaluationTab> {
  @override
  List<DefaultQuestions> formList = [];
  bool isSelectedDefaultForms = true;

  void initState() {
    // TODO: implement initState
    Provider.of<FormController>(context, listen: false).getDefaultFormList();
    Provider.of<FormController>(context, listen: false)
        .getCustomFormAttribute();
    super.initState();
  }

  Icon getIcon(bool isPublished) {
    if (isPublished) {
      return Icon(
        Icons.remove_circle,
        color: Colors.red,
      );
    } else {
      return Icon(
        Icons.add_task_sharp,
        color: Colors.green,
      );
    }
  }
  getText(bool isPublished) {
    if (isPublished) {
      return 'Disable';
    } else
      return 'Enable';
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<FormController>(
        builder: (context, provider, child) {
          if (formList.isEmpty) {
            formList = provider.formList;
          }
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingView(),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSelectedDefaultForms = true;
                          });
                        },
                        child: Stack(children: [
                          Text(
                            'Default Evaluation Forms',
                            style: kContentStyle,
                          ),
                          isSelectedDefaultForms
                              ? Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(colors: [
                                          Colors.lightBlueAccent,
                                          Colors.purpleAccent,
                                          Colors.pinkAccent
                                        ])),
                                  ))
                              : Container()
                        ]),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSelectedDefaultForms = false;
                          });
                        },
                        child: Stack(children: [
                          Text(
                            'Custom Forms',
                            style: kContentStyle,
                          ),
                          isSelectedDefaultForms
                              ? Container()
                              : Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    height: 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        gradient: LinearGradient(colors: [
                                          Colors.lightBlueAccent,
                                          Colors.purpleAccent,
                                          Colors.pinkAccent
                                        ])),
                                  ))
                        ]),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CreateFormDialogue();
                              });
                        },
                        child: IconTextButton(
                          icon: Icon(
                            CupertinoIcons.plus_circle,
                            color: Colors.white,
                          ),
                          title: 'CREATE FORM',
                          isSelected: false,
                        ),
                      )
                    ],
                  ),
                ),
                isSelectedDefaultForms
                    ? Container(
                        child: Column(
                          children: [
                            provider.isFormListLoading
                                ? Container(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: formList.length,
                                    itemBuilder: (context, index) {
                                      String status =
                                          formList[index].isPublished
                                              ? 'Accepting'
                                              : 'Not Accepting';
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
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Evaluation Form No ${index + 1}',
                                              style: kHeadingTextStyle.copyWith(
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Total Questions : 10',
                                                      style: kWhiteContentStyle,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      'This Form is  $status Responses',
                                                      style: kWhiteContentStyle,
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return CustomDialog(
                                                                formList:
                                                                    formList,
                                                                index: index,
                                                              );
                                                            });
                                                      },
                                                      child: IconTextButton(
                                                        icon: Icon(
                                                          Icons
                                                              .view_headline_outlined,
                                                          color: Colors.white,
                                                        ),
                                                        title: 'View Form',
                                                        isSelected: false,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        bool ustatus = provider
                                                                .formList[index]
                                                                .isPublished
                                                            ? false
                                                            : true;
                                                        print(ustatus);
                                                        provider
                                                            .updateFormPublishStatus(
                                                                provider
                                                                    .formList[
                                                                        index]
                                                                    .id,
                                                                ustatus)
                                                            .then((value) =>
                                                                formList = provider
                                                                    .formList);
                                                      },
                                                      child: IconTextButton(
                                                        icon: getIcon(provider
                                                            .formList[index]
                                                            .isPublished),
                                                        title: getText(provider
                                                            .formList[index]
                                                            .isPublished),
                                                        isSelected: false,
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    })
                          ],
                        ),
                      )
                    : const ShowCustomForms(isFilling: false, id: '', name: '',),
              ],
            ),
          );
        },
      ),
    );
  }


}
