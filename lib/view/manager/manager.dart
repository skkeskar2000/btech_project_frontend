import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as ma;
import 'package:major_project_fronted/constant/utils.dart';
import 'package:major_project_fronted/preferences.dart';
import 'package:major_project_fronted/view/ceo/user_list_widget.dart';
import 'package:major_project_fronted/view/employee/sidenav/dashboard.dart';
import 'package:major_project_fronted/view/employee/sidenav/fillForm.dart';
import 'package:major_project_fronted/view/manager/sidenav/analysis.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int index = 0;

  String userId ='';

  @override
  void initState() {
    userId = SharedPreferenceHelper.getString(Preferences.userid)!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: const NavigationAppBar(
          title: Text("Fluent Design App Bar"),
          automaticallyImplyLeading: false),
      pane: NavigationPane(
          displayMode: PaneDisplayMode.auto,
          selected: index,
          onChanged: (newIndex) {
            setState(() {
              index = newIndex;
            });
          },
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.profile_search),
              title: const Text("Employee"),
              body: const ScaffoldPage(
                content: ma.Material(
                  child: UserListWidget(user: 'employee',),
                ),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.profile_search),
              title: const Text("Manager"),
              body: const ScaffoldPage(
                content: ma.Material(
                  child: UserListWidget(user: 'manager',),
                ),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.view_dashboard),
              title: const Text("Dashboard"),
              body: ScaffoldPage(
                content: ma.Material(
                    child: userId.isNotEmpty
                        ? Dashboard(
                      userId: userId,
                    )
                        : const Text('No Form Filled')),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.edit_create),
              title: const Text("Fill Form"),
              body: ScaffoldPage(
                header: Column(
                  children: const [
                    Center(
                      child: Text(
                        "Fill Form",
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                    ),
                    ma.Divider(
                      thickness: 1,
                    ),
                  ],
                ),
                content: const ma.Material(
                  child: FillForm(),
                ),
              ),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.analytics_view),
              title: const Text("Analysis"),
              body: ScaffoldPage(
                header: Center(
                  child: Text(
                    'Analysis',
                    style: TextStyle(fontSize: 40,color: headingTextColor),
                  ),
                ),
                content: ma.Material(
                  child: Analysis(),
                ),
              ),
            ),
          ],
          footerItems: [
            PaneItem(
                icon: const Icon(FluentIcons.help),
                title: const Text("Help"),
                body: const ScaffoldPage(
                  header: Text(
                    "Help",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
            ),
            PaneItem(
                icon: const Icon(FluentIcons.album_remove),
                title: const Text("Logout"),
                body: const ScaffoldPage(
                  header: Text(
                    "Sample Page 2",
                    style: TextStyle(fontSize: 60),
                  ),
                ),
                onTap: (){
                  Navigator.pop(context);
                }
            ),
          ]
      ),
    );
  }

  Container _formWidget({required String heading}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const ma.TextField(
            decoration: ma.InputDecoration(
              hintText: 'Enter The value',
              border: ma.OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
