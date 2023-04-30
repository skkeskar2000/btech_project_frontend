import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/global%20widgits/custom_flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'custom_data_card.dart';

class AssessmentLog extends StatefulWidget {
  const AssessmentLog({Key? key}) : super(key: key);

  @override
  State<AssessmentLog> createState() => _AssessmentLogState();
}

class _AssessmentLogState extends State<AssessmentLog> {
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
        return Column(
          children: [
            Text(
              'Assessment Log',
              style: kHeadingTextStyle.copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDataCard(
                  frontData: '${provider.customFormResponse.length}',
                  frontTitle: 'Total Responses Received',
                  frontSubtitle: 'resps',
                ),
                CustomDataCard(
                  frontData: '${provider.allTopScore}',
                  frontTitle: 'Top Score',
                  frontSubtitle: 'marks',
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomDataCard(
                  frontData: '${provider.pendingVerifications}',
                  frontTitle: 'Pending Verifications',
                  frontSubtitle: 'forms',
                ),
                CustomDataCard(
                  frontData: '${provider.allLeastScore}',
                  frontTitle: 'Least Score',
                  frontSubtitle: 'marks',
                )
              ],
            )
          ],
        );
      },
    );
  }
}
