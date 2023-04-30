import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateFormDialogue extends StatefulWidget {
  const CreateFormDialogue({Key? key}) : super(key: key);

  @override
  State<CreateFormDialogue> createState() => _CreateFormDialogueState();
}

class _CreateFormDialogueState extends State<CreateFormDialogue> {
  List<String> createFormQuestionList = [];

  final formHeadingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    formHeadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return AlertDialog(
          content: Container(
            child: Column(
              children: [
                Text(
                  'Add Questions',
                  style: kHeadingTextStyle,
                ),
                createFormQuestionList.isEmpty
                    ? Container()
                    : Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            height: 800,
                            width: 500,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: createFormQuestionList.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      '${index + 1}.${createFormQuestionList[index]}',
                                      style: kContentStyle,
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                TextFormField(
                  decoration: CustomInputDecoration(
                      label: 'Add Question',
                      hint: 'Type Question',
                      icon: Icon(
                        Icons.question_mark_outlined,
                        size: 0,
                      )),
                  controller: formHeadingController,
                ),
                InkWell(
                  onTap: () {
                    // add question to form list
                    if (formHeadingController.text != '') {
                      createFormQuestionList.add(formHeadingController.text);
                      setState(() {
                        createFormQuestionList;
                        formHeadingController.clear();
                      });
                    }
                  },
                  child: IconTextButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.white,
                    ),
                    title: 'Add Question',
                    isSelected: true,
                  ),
                )
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () async {
                //save form function
                if (createFormQuestionList.isNotEmpty) {
                  Map<String, dynamic> mapQuestion = {};
                  for (int i = 0; i < createFormQuestionList.length; i++) {
                    mapQuestion[i.toString()] = createFormQuestionList[i];
                  }
                  await provider.saveCustomForm(questionMap: mapQuestion);
                  if (provider.isSaveSuccess) {
                    showCustomToast('Form Saved Successfully');
                    Navigator.pop(context);
                  }
                } else {
                  showCustomToast('Please Add At least One Question');
                }
              },
              child: IconTextButton(
                icon: Icon(
                  Icons.cloud_done,
                  color: Colors.white,
                ),
                title: 'Save Form',
                isSelected: true,
              ),
            ),
            InkWell(
              onTap: () {
                createFormQuestionList.clear();
                Navigator.pop(context);
              },
              child: IconTextButton(
                icon: Icon(
                  CupertinoIcons.multiply_circle_fill,
                  color: Colors.white,
                ),
                title: 'Cancel',
                isSelected: false,
              ),
            ),
          ],
        );
      },
    );
  }
}
