import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/controller/form_controller.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/employee_dashboard.dart';
import 'package:major_project_fronted/views/global%20widgits/custom_flip_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChekinWithName extends StatelessWidget {
  ChekinWithName({Key? key}) : super(key: key);

  int totalEmployee = 0;

  @override
  Widget build(BuildContext context) {
    totalEmployee = Provider.of<AuthController>(context, listen: false)
        .allEmployeeList
        .length;
    return Consumer<FormController>(
      builder: (context, provider, child) {
        return Card(
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Daily Chek-Ins',
                style: kHeadingTextStyle.copyWith(color: Colors.white),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  CustomFlipCard(
                    frontData: '${provider.allTodatyChekinList.length}',
                    backText: 'All employee chekin today',
                    frontTitle: 'Today Chek-Ins',
                    frontSubtitle: 'out of $totalEmployee',
                    color: Colors.red,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 35, horizontal: 20),
                    height: 250,
                    width: 220,
                    child: Column(
                      children: [
                        provider.allTodatyChekinList.length == 0?Container(): Text('Employees On-Board Today',style: kWhiteContentStyle,),
                        provider.allTodatyChekinList.length == 0
                            ? Container(
                                child: Center(
                                  child: Text(
                                    'Not any chek-In today',
                                    style: kWhiteContentStyle,
                                  ),
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount:
                                        provider.allTodatyChekinList.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 5),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 12,
                                              child: Icon(
                                                Icons.person,
                                                color: Colors.white,
                                                size: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              '${provider.allTodatyChekinList[index].empName}',
                                              style: kWhiteContentStyle,
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
