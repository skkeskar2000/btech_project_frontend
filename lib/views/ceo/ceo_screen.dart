import 'package:major_project_fronted/constant/decorationConstants.dart';
import 'package:major_project_fronted/views/ceo/tab%20screens/evaluation_tab/evaluation_tab.dart';
import 'package:major_project_fronted/views/ceo/tab%20screens/people_tab.dart';
import 'package:major_project_fronted/views/ceo/widgits/text_icon_button.dart';
import 'package:major_project_fronted/views/global%20widgits/board_type.dart';
import 'package:major_project_fronted/views/global%20widgits/profile_widgit.dart';
import 'package:major_project_fronted/views/manager/tab_screen/manager_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CEOScreen extends StatefulWidget {
  const CEOScreen({Key? key}) : super(key: key);

  @override
  State<CEOScreen> createState() => _CEOScreenState();
}

class _CEOScreenState extends State<CEOScreen> {
  List<String> tabListCEO = ['Dashboard', 'People', 'Evaluations'];
  List<Icon> tabIconList=[
    Icon(Icons.dashboard,size: 20,color: Colors.white,),
    Icon(Icons.people_outline_rounded,size: 20,color: Colors.white,),
    Icon(Icons.analytics,size: 20,color: Colors.white,)

  ];

  int selectedIndex = 0;
  int hoverIndex=0;

  @override
  Widget build(BuildContext context) {
    List<Widget> tabWidgitList = [ManagerDashboard(), PeopleTab(), EvaluationTab()];
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
                ProfileWidgit(name: '',),
                BoardType(
                  title: 'CBoard',
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
                        itemCount: tabListCEO.length,
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
                              title: tabListCEO[index],
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




