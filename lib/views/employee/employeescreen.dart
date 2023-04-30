import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/prefrences.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/daily_checkins.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/employee_dashboard.dart';
import 'package:major_project_fronted/views/employee/tab%20screens/fill%20form/fill_forms.dart';
import 'package:major_project_fronted/views/global%20widgits/board_type.dart';
import 'package:major_project_fronted/views/global%20widgits/profile_widgit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeePage extends StatefulWidget {
  const EmployeePage({Key? key}) : super(key: key);

  @override
  State<EmployeePage> createState() => _EmployeePageState();
}

String name='';
String id='';
String role='';
List<String> tabListEmployee = ['Dashboard', 'Daily ChekIns', 'Fill Form'];
List<Icon> tabIconList=[
  Icon(Icons.dashboard,size: 20,color: Colors.white,),
  Icon(CupertinoIcons.calendar_today,size: 20,color: Colors.white,),
  Icon(Icons.analytics,size: 20,color: Colors.white,)
];
int selectedIndex=0;
class _EmployeePageState extends State<EmployeePage> {

  List<Widget> widgetsList=[];
  @override
  void initState() {
    getPref();
    widgetsList = [
      EmployeeEvaluationDashboard(
        id: id,
        name: name, text: 'Your',
      ),
      DailyCheckins(
        id: id,
        name: name,
      ),
      FillForm(
        id: id,
        name: name,
      )
    ];
    // TODO: implement initState

  }
  getPref()async{
     name= Provider.of<AuthController>(context,listen: false).name;
     id= Provider.of<AuthController>(context,listen: false).id;
     role= Provider.of<AuthController>(context,listen: false).role;
  }
  @override
  Widget build(BuildContext context) {

    print(name);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ProfileWidgit(name: name,),
                BoardType(
                  title: 'Employee Board',
                ),
                Text(
                  'Tools',
                  style: kGreyText,
                  textAlign: TextAlign.start,
                ),
                Expanded(
                  child: SizedBox(
                    width: 270,
                    child: ListView.builder(

                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: tabListEmployee.length,
                        itemBuilder: (context, index) {
                          double size=20;
                          return InkWell(
                            onTap: (){
                              setState(() {
                                selectedIndex=index;
                              });
                            },

                            child: IconTextButton(
                              icon: tabIconList[index],
                              title: tabListEmployee[index],
                              isSelected: selectedIndex == index,
                            ),
                          );
                        }),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: IconTextButton(icon: Icon(Icons.logout_rounded), title: 'Log Out', isSelected: true,),)

              ],
            ),
          ),
          Expanded(child: widgetsList[selectedIndex])
        ],
      ),
    );
  }
}
