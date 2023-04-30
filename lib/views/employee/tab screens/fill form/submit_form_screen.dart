import 'package:major_project_fronted/constant/custom_toast.dart';
import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dropdown_widgit.dart';

class SubmitForm extends StatefulWidget {
  final List<String> questionList;
  final String id;
  final String name;

  const SubmitForm({
    Key? key,
    required this.questionList,
    required this.name,
    required this.id,
  }) : super(key: key);

  @override
  State<SubmitForm> createState() => _SubmitFormState();
}

class _SubmitFormState extends State<SubmitForm> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<FormController>(context, listen: false).checkAlreadyFilled(
        userId: widget.id,
        formId: widget.questionList[widget.questionList.length - 2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('called sk submit');
    List<String> items = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
    Map<String, dynamic> formData = {};
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 300),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: provider.isLoadingSubmitForm
                  ? CircularProgressIndicator()
                  : provider.isFilledAlready
                      ? Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          alignment: AlignmentDirectional.topStart,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/brown_bg.jpg'),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                              'Filled Form Already',
                              style: kTopTitleTextStyle,
                            ),
                            InkWell(onTap: (){
                              Navigator.pop(context);
                            },
                              child: IconTextButton(icon: Icon(Icons.ice_skating,size: 0,), title: '    View Another Form', isSelected: true,),
                            )
                          ],)
                        )
                      : Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 40, horizontal: 20),
                              alignment: AlignmentDirectional.topStart,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/brown_bg.jpg'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Evaluation Form',
                                    style: kTopTitleTextStyle,
                                  ),
                                  Text(
                                    'Submitting Form by ${widget.name}',
                                    style: kWhiteContentStyle,
                                  ),
                                  Text(
                                    'Total Questions ${widget.questionList.length - 2}',
                                    style: kWhiteContentStyle,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ListView.builder(
                                itemCount: widget.questionList.length - 2,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DropDownButtonWidget(
                                        items: items,
                                        onChanged: (value) {
                                          formData[widget.questionList[index]] =
                                              value;
                                        },
                                        questionTitle:
                                            '${index + 1}.${widget.questionList[index]}'),
                                  );
                                }),
                            InkWell(
                              onTap: () async {
                                int formIdIndex =
                                    widget.questionList.length - 2;
                                String formId =
                                    widget.questionList[formIdIndex];
                                if (formData.length ==
                                    widget.questionList.length - 2) {
                                  await provider.submitCustomForm(
                                      queAns: formData,
                                      formUserId: widget.id,
                                      formUserName: widget.name,
                                      formId: formId);
                                  formData.clear();
                                  if (provider.isSubmitCustomFormSuccess) {
                                    showCustomToast(
                                        'Form Submitted Successfully');
                                    Navigator.pop(context);
                                  }
                                } else {
                                  showCustomToast('Please Fill All Fields');
                                }
                              },
                              child: IconTextButton(
                                icon: Icon(Icons.cloud_done_sharp),
                                title: ' Submit Response',
                                isSelected: false,
                              ),
                            )
                          ],
                        ),
            ),
          ),
        );
      },
    );
  }
}
