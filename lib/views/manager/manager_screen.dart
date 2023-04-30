import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/controller/auth_controller.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/global%20widgits/board_type.dart';
import 'package:major_project_fronted/views/manager/tab_screen/add_employee_tab.dart';
import 'package:major_project_fronted/views/manager/tab_screen/manager_dashboard.dart';
import 'package:major_project_fronted/views/manager/tab_screen/manager_employee_dashboard.dart';
import 'package:major_project_fronted/views/manager/tab_screen/verification_tab.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../global widgits/profile_widgit.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  String name = '';
  String id = '';
  String role = '';

  List<String> tabListManager = [
    'Dashboard',
    'Employee',
    'Verification',
    'Add Employee'
  ];
  List<Icon> tabIconList = [
    Icon(
      Icons.dashboard,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      Icons.people_outline_rounded,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      Icons.verified,
      size: 20,
      color: Colors.white,
    ),
    Icon(
      CupertinoIcons.person_badge_plus,
      size: 20,
      color: Colors.white,
    )
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    getPref();
    Provider.of<AuthController>(context, listen: false)
        .getAllUsers(currentId:id);
    super.initState();
  }

  getPref() async {
    name = Provider.of<AuthController>(context, listen: false).name;
    id = Provider.of<AuthController>(context, listen: false).id;
    role = Provider.of<AuthController>(context, listen: false).role;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabWidgitList = [
      ManagerDashboard(),
      EmployeeManagerTab(id: id,),
      VerificationTab(),
      AddEmployeeTab()
    ];
    print('manager');
    return Scaffold(
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
                  title: 'ManagerBoard',
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
                        itemCount: tabListManager.length,
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
                              title: tabListManager[index],
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
          Expanded(child: tabWidgitList[selectedIndex])
        ],
      ),
    );
  }
}
