import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as ma;
import 'package:major_project_fronted/constant/toast.dart';
import 'package:major_project_fronted/constant/utils.dart';
import 'package:major_project_fronted/services/form_services.dart';
import 'package:major_project_fronted/view/ceo/user_list_widget.dart';

class CeoHome extends StatefulWidget {
  const CeoHome({Key? key}) : super(key: key);

  @override
  State<CeoHome> createState() => _CeoHomeState();
}

class _CeoHomeState extends State<CeoHome> {
  int index = 0;
  List<String> formList = [];
  final formHeadingController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    formHeadingController.dispose();
    super.dispose();
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
            icon: const Icon(FluentIcons.edit_create),
            title: const Text("Create Form"),
            body: ScaffoldPage(
              header: Column(
                children: [
                  Stack(
                    children: [
                      const Center(
                        child: Text(
                          "Ceate Form",
                          style: TextStyle(
                            fontSize: 40,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 80,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: headingTextColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: GestureDetector(
                            onTap: _openDialog,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Add',
                                  style: TextStyle(color: textWhiteColour),
                                ),
                                Icon(
                                  FluentIcons.add,
                                  color: textWhiteColour,
                                  size: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ma.Divider(thickness: 1,),
                ],
              ),
              content: ma.Material(
                child: SingleChildScrollView(
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: formList.length,
                            itemBuilder: (context, index) => _formWidget(heading: formList[index]),
                          ),
                          const SizedBox(height: 20,),
                          formList.isNotEmpty ? ma.ElevatedButton(
                            onPressed: ()async{
                              Map<String,dynamic> m = {};
                              for(var i in formList){
                                m[i] = i;
                              }
                              if(await FormServices.saveCustomForm(m: m)){
                                flutterToast('Successfull created');
                                setState(() {
                                  index = 0;
                                });
                              }else{
                                flutterToast('Unable to save');
                              }
                            },
                            style: ma.ButtonStyle(
                              backgroundColor: ma.MaterialStatePropertyAll(headingTextColor),
                            ),
                            child: const Text('Save'),
                          ) : Container(),
                          SizedBox(height: 40,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
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

  void _openDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return ContentDialog(
            title: Text('Enter the heading'),
            content: TextBox(
              controller: formHeadingController,
            ),
            actions: [
              Button(
                autofocus: true,
                onPressed: () {
                  setState(() {
                    formList.add(
                      formHeadingController.text,
                    );
                  });
                  formHeadingController.clear();
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
              Button(
                child: Text('Cancel'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}
