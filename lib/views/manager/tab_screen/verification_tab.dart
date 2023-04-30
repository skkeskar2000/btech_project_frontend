import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerificationTab extends StatefulWidget {
  const VerificationTab({Key? key}) : super(key: key);

  @override
  State<VerificationTab> createState() => _VerificationTabState();
}

class _VerificationTabState extends State<VerificationTab> {
  @override
  void initState() {
    // TODO: implement initState

    Provider.of<FormController>(context, listen: false).getCustomFormResponse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, right: 50),
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(colors: [
                      Color(0xff303649),
                      Colors.blueGrey.shade700,
                      Colors.blueGrey.shade600
                    ])),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Submitted Forms',
                      style: kHeadingTextStyle.copyWith(color: Colors.white),
                    ),
                    Icon(
                      Icons.verified,
                      size: 80,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: CustomHorizontalCard(
                      title: 'Responses',
                      subtitle:
                          'Total number of responses given by your employees to the evaluation forms.',
                      data: '${provider.customFormResponse.length}',
                      color: Colors.purpleAccent,
                    ),
                  ),
                  Expanded(
                      child: CustomHorizontalCard(
                    title: 'Pending Verifications',
                    subtitle:
                        'This number shows how many responses are not verified. You can go through responses below and verify them.',
                    data: '${provider.pendingVerifications}',
                    color: Colors.orange,
                  )),
                ],
              ),
              SizedBox(height: 10,),
              Card(
                margin: EdgeInsets.only(bottom: 1),
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                          flex: 5,
                          child: Text(
                            "Name",
                            style: kContentStyle.copyWith(fontWeight: FontWeight.w600),
                          )),
                      Expanded(
                          flex: 3,
                          child: Text("Date Submitted",
                              style: kContentStyle.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                      Expanded(
                          flex: 3,
                          child: Text('View Responses',
                              style: kContentStyle.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                      Expanded(
                          flex: 3,
                          child: Text('Verification Status',
                              style: kContentStyle.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center)),
                      Expanded(
                          flex: 3,
                          child: Text('Update',
                              style: kContentStyle.copyWith(fontWeight: FontWeight.w600), textAlign: TextAlign.center))
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Card(
                  margin: EdgeInsets.only(top: 2),
                  elevation: 10,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: provider.customFormResponse.length,
                      itemBuilder: (context, index) {
                        return FormVerificationList(
                          responseList: provider.customFormResponse[index],
                        );
                      }),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CustomHorizontalCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String data;
  final Color color;

  const CustomHorizontalCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: kContentStyle,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    subtitle,
                    style: kGreyText,
                    softWrap: true,
                    maxLines: 5,
                  )
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Card(
                color: Colors.transparent,
                elevation: 15,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      data,
                      style: kHeadingTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormVerificationList extends StatelessWidget {
  final Map<String, dynamic> responseList;

  FormVerificationList({
    super.key,
    required this.responseList,
  });

  String name = '';
  String verificationStatus = 'Verified';
  String userId = '';
  String fromId = '';
  bool updateStatus = false;
  String date = '';

  getNameStatus() {
    responseList.forEach((key, value) {
      if (key == "userId") {
        userId = value;
      }
      if (key == "formId") {
        fromId = value;
      }
      if (key == "createdAt") {
        date = value;
      }

      if (key == 'userName') {
        name = value;
      }
      if (key == 'isVerified') {
        if (value) {
          verificationStatus = 'Verified';
          updateStatus = false;
        } else {
          updateStatus = true;
          verificationStatus = 'Not Verified';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getNameStatus();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 15,
            child: Icon(
              CupertinoIcons.profile_circled,
              fill: 1,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(
            '$name',
            style: kContentStyle,
          ),
        ),
        Expanded(
            flex: 3,
            child: Text('${date.substring(0, 10)}',
                style: kContentStyle.copyWith(color: Colors.grey),
                textAlign: TextAlign.center)),
        Expanded(
            flex: 3,
            child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ResponseDilogue(
                          respMap: responseList,
                        );
                      });
                },
                child: Text(
                  'View Response',
                  style: kContentStyle.copyWith(color: Colors.green),
                ))),
        Expanded(
          flex: 3,
          child: Container(
              alignment: Alignment.center,
              child: Text(
                '$verificationStatus',
                style: kContentStyle.copyWith(
                    color: verificationStatus == 'Verified'
                        ? Colors.green
                        : Colors.red),
              )),
        ),
        Expanded(
          flex: 3,
          child: TextButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 5)),
                backgroundColor: MaterialStateProperty.all(Colors.cyan)),
            onPressed: () {
              Provider.of<FormController>(context, listen: false)
                  .updateCustomFormVerification(
                      userId: userId, formId: fromId, isVerified: updateStatus);
            },
            child: Text(
              'Update Status',
              style: kWhiteContentStyle,
            ),
          ),
        )
      ],
    );
  }
}

class ResponseDilogue extends StatelessWidget {
  final Map<String, dynamic> respMap;

  ResponseDilogue({Key? key, required this.respMap}) : super(key: key);

  List<String> questions = [];
  List<String> values = [];
  int total = 0;

  getQueVal() {
    respMap.forEach((key, value) {
      if (key == 'createdAt' ||
          key == 'updatedAt' ||
          key == '__v' ||
          key == 'role' ||
          key == "_id" ||
          key == "total" ||
          key == "userId" ||
          key == "formId" ||
          key == "isVerified" ||
          key == "userName") {
        if (key == "total") {
          total = value;
        }
      } else {
        questions.add(key);
        values.add(value.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getQueVal();
    return AlertDialog(
      content: Container(
        height: 700,
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Response Report',
              style: kHeadingTextStyle,
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}.${questions[index]}',
                            style: kContentStyle,
                          ),
                          Text(
                            'Response Rating : ${values[index]}',
                            style: kContentStyle.copyWith(color: Colors.green),
                          )
                        ],
                      ),
                    );
                  }),
            ),
            IconTextButton(
                icon: Icon(
                  Icons.credit_score_sharp,
                  color: Colors.white,
                ),
                title: 'Total Score: $total',
                isSelected: true)
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      actions: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: IconTextButton(
              icon: Icon(
                Icons.close,
                color: Colors.red,
              ),
              title: "Close",
              isSelected: false),
        )
      ],
    );
  }
}
